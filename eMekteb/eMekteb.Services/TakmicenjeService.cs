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
    public class TakmicenjeService : BaseCRUDService<TakmicenjeM, Takmicenje, TakmicenjeSearchObject, TakmicenjeInsert, TakmicenjeUpdate>, ITakmicenjeService
    {
        public TakmicenjeService(eMektebContext dbContext, IMapper mapper) : base(dbContext, mapper)
        {
        }

        public async Task<TakmicenjeM?> GetLastTakmicenjeAsync()
        {
            var lastTakmicenje = await _dbContext.Set<Takmicenje>()
                                                 .OrderByDescending(t => t.Id)
                                                 .FirstOrDefaultAsync();

            return _mapper.Map<TakmicenjeM>(lastTakmicenje);
        }

        public override async Task<PagedResult<TakmicenjeM>> Get(TakmicenjeSearchObject? search)
        {
            var result = await base.Get(search);

            foreach (var takmicenje in result.Result)
            {
                takmicenje.UkupnoUcenika = await _dbContext.Takmicar
                    .CountAsync(t => t.Kategorija.TakmicenjeId == takmicenje.id);
            }

            return result;
        }

        public override IQueryable<Takmicenje> AddFilter(IQueryable<Takmicenje> query, TakmicenjeSearchObject? search)
        {
            if (search?.IsAsc == true)
            {
                query = query.OrderBy(y => y.Godina);
            }
            else
                query = query.OrderByDescending(y => y.Godina);

            return base.AddFilter(query, search);
        }


    }
}

