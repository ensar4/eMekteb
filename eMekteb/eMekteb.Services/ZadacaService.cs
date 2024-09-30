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
    public class ZadacaService : BaseCRUDService<ZadacaM, Zadaca, BaseSearchObject, ZadacaInsert, ZadacaUpdate>, IZadacaService
    {
        public ZadacaService(eMektebContext dbContext, IMapper mapper) : base(dbContext, mapper)
        {
        }


        public async Task<PagedResult<ZadacaM>> GetByKorisnikId(int korisnikId)
        {
            var items = await _dbContext.Set<Zadaca>()
                                    .Where(y => y.KorisnikId == korisnikId)
                                    .ToListAsync();
            PagedResult<ZadacaM> result = new PagedResult<ZadacaM>();
            result.Count = items.Count();


            var tmp = _mapper.Map<List<ZadacaM>>(items);
            result.Result = tmp;

            return result;
        }


    }
}
