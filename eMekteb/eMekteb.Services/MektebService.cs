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
            // Call the base insert method to add the new Mekteb
            var mekteb = await base.Insert(insert);

            // Get the most recent academic year
            var latestAcademicYear = await _dbContext.AkademskaGodina
                .OrderByDescending(ag => ag.DatumPocetka)
                .FirstOrDefaultAsync();

            if (latestAcademicYear != null)
            {
                // List of razredi to be added
                var razredi = new List<string> { "I nivo", "II nivo", "III nivo", "Sufara", "Tedžvid", "Hatma" };

                // Insert new Razredi and associate them with the most recent academic year
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

                // Save the changes for the RazredAkademska
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
                // Calculate the total number of students
                mektebM.UkupnoUcenika = await _dbContext.Korisnik
                    .Where(u => u.MektebId == mektebM.Id && u.KorisniciUloge.Any(ku => ku.Uloga.Naziv == "Ucenik"))
                     .CountAsync();


                // Calculate the average grade for the Mekteb
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
                    double averageGrade = (double)zadace.Average(z => z.Ocjene.Ocjena); // Assuming Ocjene has a property 'Ocjena' for grade
                    mektebM.ProsjecnaOcjena = averageGrade;
                }
                else
                {
                    mektebM.ProsjecnaOcjena = null;
                }

                // Calculate the average attendance for the Mekteb
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

                // Get the name and surname of the Korisnik with the role of "imam"
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
                    mektebM.Mualim = null; // No imam found
                }
            }

            return result;
        }



    }
}
