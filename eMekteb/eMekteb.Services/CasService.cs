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
    public class CasService : BaseCRUDService<CasM, Cas, BaseSearchObject, CasInsert, CasUpdate>, ICasService
    {
     
        public CasService(eMektebContext dbContext, IMapper mapper) : base(dbContext, mapper)
        {
           
        }

        public async Task<PagedResult<CasM>> GetByMektebId(int mektebId)
        {
            var items = await _dbContext.Set<Cas>()
                                   .Where(y => y.MektebId == mektebId).OrderByDescending(y=>y.Id)
                                   .ToListAsync();
            PagedResult<CasM> result = new PagedResult<CasM>();
            result.Count = items.Count();


            var tmp = _mapper.Map<List<CasM>>(items);
            result.Result = tmp;

            return result;
        }

    }
}
