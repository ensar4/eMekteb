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
    public class KampService : BaseCRUDService<KampM, Kamp, BaseSearchObject, KampInsert, KampUpdate>, IKampService
    {
        public KampService(eMektebContext dbContext, IMapper mapper) : base(dbContext, mapper)
        {
        }

        public async Task<PagedResult<KampM>> GetByMektebId(int mektebId)
        { 
            var items = await _dbContext.Set<Kamp>()
                                   .Where(y => y.MektebId == mektebId)
                                   .ToListAsync();
            PagedResult<KampM> result = new PagedResult<KampM>();
            result.Count = items.Count();


            var tmp = _mapper.Map<List<KampM>>(items);
            result.Result = tmp;

            return result;
        }
        public async Task<KampM?> GetLastKampAsync()
        {
            var lastTakmicenje = await _dbContext.Set<Kamp>()
                                                 .OrderByDescending(t => t.Id)
                                                 .FirstOrDefaultAsync();

            return _mapper.Map<KampM>(lastTakmicenje);
        }


    }
}
