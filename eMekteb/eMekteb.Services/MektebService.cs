using AutoMapper;
using eMekteb.Model;
using eMekteb.Model.Request;
using eMekteb.Model.SearchObjects;
using eMekteb.Services.Database;
using eMekteb.Services.Interfaces;
using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eMekteb.Services
{
    public class MektebService : BaseCRUDService<MektebM, Mekteb, MektebSearchObject, MektebInsert, MektebUpdate>, IMektebService
    {
        public MektebService(eMektebContext dbContext, IMapper mapper) : base(dbContext, mapper)
        {
        }


        public override async Task<MektebM> Insert(MektebInsert insert)
        {
            var mekteb = await base.Insert(insert);

            var latestAcademicYear = await _dbContext.AkademskaGodina
                .OrderByDescending(ag => ag.DatumPocetka)
                .FirstOrDefaultAsync();

            if (latestAcademicYear != null)
            {
                var razredi = new List<string> { "I nivo", "II nivo", "III nivo", "Sufara", "Tedžvid", "Hatma" };

                foreach (var nazivRazreda in razredi)
                {
                    var razred = new Razred
                    {
                        Naziv = nazivRazreda,
                        MektebId = mekteb.Id
                    };

                    _dbContext.Razred.Add(razred);
                    await _dbContext.SaveChangesAsync();

                    var razredAkademska = new AkademskaRazred
                    {
                        RazredId = razred.Id,
                        AkademskaGodinaId = latestAcademicYear.Id
                    };

                    _dbContext.AkademskaRazred.Add(razredAkademska);
                }

                await _dbContext.SaveChangesAsync();
            }

            return mekteb;
        }



        public override IQueryable<Mekteb> AddFilter(IQueryable<Mekteb> query, MektebSearchObject? search)
        {
            if (!string.IsNullOrWhiteSpace(search.naziv))
            {
                query = query.Where(y => y.Naziv.StartsWith(search.naziv));
            }
            if (search?.MedzlisId != null)
            {
                query = query.Where(m => m.MedzlisId == search.MedzlisId);
            }
            if (!string.IsNullOrWhiteSpace(search.FTS))
            {
                query = query.Where(y => y.Naziv.Contains(search.FTS));
            }
            if (search?.IsAsc == true) { 
                  query = query.OrderBy(y => y.Korisnik.Count());
            }
            else
                query = query.OrderByDescending(y => y.Korisnik.Count());

            return base.AddFilter(query, search);
        }


        public async override Task<PagedResult<MektebM>> Get(MektebSearchObject? search)
        {
            var result = await base.Get(search);

            foreach (var mektebM in result.Result)
            {
                mektebM.UkupnoUcenika = await _dbContext.Korisnik
                    .Where(u => u.MektebId == mektebM.Id && u.KorisniciUloge.Any(ku => ku.Uloga.Naziv == "Ucenik"))
                     .CountAsync();


                var korisniciIds = await _dbContext.Korisnik
                    .Where(k => k.MektebId == mektebM.Id)
                    .Select(k => k.Id)
                    .ToListAsync();

                var zadace = await _dbContext.Zadaca
                    .Where(z => korisniciIds.Contains(z.KorisnikId))
                    .Include(z => z.Ocjene)
                    .ToListAsync();

                if (zadace.Count > 0)
                {
                    double averageGrade = (double)zadace.Average(z => z.Ocjene.Ocjena); 
                    mektebM.ProsjecnaOcjena = averageGrade;
                }
                else
                {
                    mektebM.ProsjecnaOcjena = null;
                }

                var prisustva = await _dbContext.Prisustvo
                    .Where(p => korisniciIds.Contains(p.KorisnikId))
                    .ToListAsync();

                if (prisustva.Count > 0)
                {
                    double averageAttendance = prisustva
                        .GroupBy(p => p.KorisnikId)
                        .Select(g => g.Count(p => p.Prisutan == true) / (double)g.Count())
                        .Average() * 100;
                    mektebM.ProsjecnoPrisustvo = averageAttendance;
                }
                else
                {
                    mektebM.ProsjecnoPrisustvo = null;
                }

                var imam = await _dbContext.Korisnik
                    .Where(k => k.MektebId == mektebM.Id && k.KorisniciUloge.Any(ku => ku.Uloga.Naziv == "imam"))
                    .Select(k => new { k.Ime, k.Prezime })
                    .FirstOrDefaultAsync();

                if (imam != null)
                {
                    mektebM.Mualim = $"{imam.Ime} {imam.Prezime}";
                }
                else
                {
                    mektebM.Mualim = null; 
                }
            }

            return result;
        }


        public async Task<PagedResult<MektebM>> GetByMedzlisId(int medzlisId)
        {
            var query = _dbContext.Mekteb.Where(m => m.MedzlisId == medzlisId);

            var result = new PagedResult<MektebM>
            {
                Count = await query.CountAsync(),
                Result = await query.Select(m => new MektebM
                {
                    Id = m.Id,
                    Naziv = m.Naziv
                }).ToListAsync()
            };

            foreach (var mektebM in result.Result)
            {
                mektebM.UkupnoUcenika = await _dbContext.Korisnik
                    .Where(u => u.MektebId == mektebM.Id && u.KorisniciUloge.Any(ku => ku.Uloga.Naziv == "Ucenik"))
                    .CountAsync();

                var korisniciIds = await _dbContext.Korisnik
                    .Where(k => k.MektebId == mektebM.Id)
                    .Select(k => k.Id)
                    .ToListAsync();

                var zadace = await _dbContext.Zadaca
                    .Where(z => korisniciIds.Contains(z.KorisnikId))
                    .Include(z => z.Ocjene)
                    .ToListAsync();

                if (zadace.Any())
                {
                    mektebM.ProsjecnaOcjena = zadace.Average(z => z.Ocjene.Ocjena);
                }
                else
                {
                    mektebM.ProsjecnaOcjena = null;
                }

                var prisustva = await _dbContext.Prisustvo
                    .Where(p => korisniciIds.Contains(p.KorisnikId))
                    .ToListAsync();

                if (prisustva.Any())
                {
                    double averageAttendance = prisustva
                        .GroupBy(p => p.KorisnikId)
                        .Select(g => g.Count(p => (bool)p.Prisutan) / (double)g.Count())
                        .Average() * 100;
                    mektebM.ProsjecnoPrisustvo = averageAttendance;
                }
                else
                {
                    mektebM.ProsjecnoPrisustvo = null;
                }

                var imam = await _dbContext.Korisnik
                    .Where(k => k.MektebId == mektebM.Id && k.KorisniciUloge.Any(ku => ku.Uloga.Naziv == "imam"))
                    .Select(k => new { k.Ime, k.Prezime })
                    .FirstOrDefaultAsync();

                mektebM.Mualim = imam != null ? $"{imam.Ime} {imam.Prezime}" : null;
            }

            return result;
        }



    }
}
