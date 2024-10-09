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
    public class RazredService : BaseCRUDService<RazredM, Razred, BaseSearchObject, RazredInsert, object>, IRazredService
    {
        public RazredService(eMektebContext dbContext, IMapper mapper) : base(dbContext, mapper)
        {
        }

        public async Task<PagedResult<RazredM>> GetByMektebId(int mektebId)
        {
            var latestAkademskaGodina = await _dbContext.AkademskaGodina
                .OrderByDescending(ag => ag.Id) 
                .FirstOrDefaultAsync();

            if (latestAkademskaGodina == null)
            {
                throw new Exception("No AkademskaGodina found");
            }

            var items = await _dbContext.Set<Razred>()
                .Where(r => r.MektebId == mektebId)
                .Join(_dbContext.AkademskaRazred,
                      r => r.Id,
                      ar => ar.RazredId,
                      (r, ar) => new { Razred = r, AkademskaRazred = ar })
                .Where(joined => joined.AkademskaRazred.AkademskaGodinaId == latestAkademskaGodina.Id)
                .Select(joined => joined.Razred)
                .ToListAsync();

            PagedResult<RazredM> result = new PagedResult<RazredM>
            {
                Count = items.Count,
                Result = _mapper.Map<List<RazredM>>(items)
            };

            return result;
        }


    }
}
