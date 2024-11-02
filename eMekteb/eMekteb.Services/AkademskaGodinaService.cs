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
                    .CountAsync(am => am.AkademskaGodinaId == aGm.Id);

                var razredIds = await _dbContext.AkademskaRazred
                    .Where(ag => ag.AkademskaGodinaId == aGm.Id)
                    .Select(ag => ag.RazredId)
                    .ToListAsync();

                if (!razredIds.Any())
                {
                    aGm.UkupnoUcenika = 0;
                    aGm.ProsjecnaOcjena = null;
                    aGm.ProsjecnoPrisustvo = null;
                    continue;
                }

                // Fetch Ucenik IDs connected to the found RazredIds via KorisnikRazred
                //var korisniciIds = await _dbContext.RazredKorisnik
                //    .Where(kr => razredIds.Contains(kr.RazredId))
                //    .Select(kr => kr.KorisnikId)
                //    .ToListAsync();

                //aGm.UkupnoUcenika = korisniciIds.Count;

                var korisniciIds = await _dbContext.RazredKorisnik
                    .Where(kr => razredIds.Contains(kr.RazredId))
                    .Select(kr => kr.KorisnikId)
                    .Distinct() 
                    .ToListAsync();

                aGm.UkupnoUcenika = korisniciIds.Count;

                var zadace = await _dbContext.Zadaca
                    .Where(z => razredIds.Contains(z.RazredId))  
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
                    .Where(p => razredIds.Contains((int)p.RazredId))  
                    .ToListAsync();

                if (prisustva.Count > 0)
                {
                    double averageAttendance = prisustva
                        .GroupBy(p => p.KorisnikId)
                        .Select(g => g.Count(p => (bool)p.Prisutan) / (double)g.Count())
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
            var last = await _dbContext.Set<AkademskaGodina>()
                                                 .OrderByDescending(t => t.Id)
                                                 .FirstOrDefaultAsync();

            return _mapper.Map<AkademskaGodinaM>(last);
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
