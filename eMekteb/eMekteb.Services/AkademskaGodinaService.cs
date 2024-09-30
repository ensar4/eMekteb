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
    public class AkademskaGodinaService : BaseCRUDService<AkademskaGodinaM, AkademskaGodina, AkademskaGodSearchObject, AkademskaGodinaInsert, AkademskaGodinaUpdate>, IAkademskaGodinaService
    {
        public AkademskaGodinaService(eMektebContext dbContext, IMapper mapper) : base(dbContext, mapper)
        {
        }

        public async override Task<PagedResult<AkademskaGodinaM>> Get(AkademskaGodSearchObject? search)
        {
            var result = await base.Get(search);

            foreach (var aGm in result.Result)
            {
                aGm.UkupnoMekteba = await _dbContext.AkademskaMekteb
                    .CountAsync(mg => mg.AkademskaGodinaId == aGm.Id);

                var mektebiUAkademskojGodini = await _dbContext.AkademskaMekteb
                    .Where(mg => mg.AkademskaGodinaId == aGm.Id)
                    .Select(mg => mg.MektebId)
                    .ToListAsync();

                if (!mektebiUAkademskojGodini.Any())
                {
                    aGm.UkupnoUcenika = 0;
                    aGm.ProsjecnaOcjena = null;
                    aGm.ProsjecnoPrisustvo = null;
                    continue;
                }

                var korisniciIds = await _dbContext.Korisnik
                     .Where(k => k.KorisniciUloge.Any(ku => ku.Uloga.Naziv == "Ucenik")
                             && mektebiUAkademskojGodini.Contains(k.MektebId)) 
                     .Select(k => k.Id)
                     .ToListAsync();

                aGm.UkupnoUcenika = korisniciIds.Count;

                var zadace = await _dbContext.Zadaca
                    .Where(z => korisniciIds.Contains(z.KorisnikId))
                    .Include(z => z.Ocjene)
                    .ToListAsync();

                if (zadace.Count > 0)
                {
                    double averageGrade = (double)zadace.Average(z => z.Ocjene.Ocjena);
                    aGm.ProsjecnaOcjena = averageGrade;
                }
                else
                {
                    aGm.ProsjecnaOcjena = null;
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
                    aGm.ProsjecnoPrisustvo = averageAttendance;
                }
                else
                {
                    aGm.ProsjecnoPrisustvo = null;
                }
            }

            return result;
        }
        public async Task<AkademskaGodinaM?> GetLastAkGAsync()
        {
            var lastTakmicenje = await _dbContext.Set<AkademskaGodina>()
                                                 .OrderByDescending(t => t.Id)
                                                 .FirstOrDefaultAsync();

            return _mapper.Map<AkademskaGodinaM>(lastTakmicenje);
        }

        public override IQueryable<AkademskaGodina> AddFilter(IQueryable<AkademskaGodina> query, AkademskaGodSearchObject? search)
        {

            if (search?.IsAsc == true)
            {
                query = query.OrderBy(y => y.Naziv);
            }
            else
                query = query.OrderByDescending(y => y.Naziv);

            return base.AddFilter(query, search);



        }

    }
}
