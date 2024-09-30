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
    public class SlikaService : BaseCRUDService<SlikaM, Slika, BaseSearchObject, SlikaInsert, SlikaUpdate>, ISlikaService
    {
     
        public SlikaService(eMektebContext dbContext, IMapper mapper) : base(dbContext, mapper)
        {
           
        }

        public async Task<PagedResult<SlikaM>> GetByKorisnikId(int korisnikId)
        {
            var items = await _dbContext.Set<Slika>()
                                   .Where(y => y.KorisnikId == korisnikId).OrderByDescending(y => y.Id) // Replace 'Id' with 'CreatedDate' if needed
                                   .ToListAsync();
                                   
            PagedResult<SlikaM> result = new PagedResult<SlikaM>();
            result.Count = items.Count();


            var tmp = _mapper.Map<List<SlikaM>>(items);
            result.Result = tmp;

            return result;
        }

    }
}
