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
    public class KampKorisnikService : BaseCRUDService<KampKorisnikM, KampKorisnik, BaseSearchObject, KampKorisnikInsert, KampKorisnikUpdate>, IKampKorisnikService
    {
        public KampKorisnikService(eMektebContext dbContext, IMapper mapper) : base(dbContext, mapper)
        {
        }

        public async Task<PagedResult<KampKorisnikM>> GetByKampId(int kampId)
        {

            var items = await _dbContext.Set<KampKorisnik>()
                                   .Where(y => y.KampId == kampId)
                                   .ToListAsync();
            PagedResult<KampKorisnikM> result = new PagedResult<KampKorisnikM>();
            result.Count = items.Count();

            var tmp = _mapper.Map<List<KampKorisnikM>>(items);
            result.Result = tmp;

            return result;
        }

    }
}
