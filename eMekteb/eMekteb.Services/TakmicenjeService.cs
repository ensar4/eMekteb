using AutoMapper;
using eMekteb.Model;
using eMekteb.Model.DTOs;
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
            if (search?.MedzlisId != null)
            {
                query = query.Where(m => m.MedzlisId == search.MedzlisId);
            }
            if (search?.IsAsc == true)
            {
                query = query.OrderBy(y => y.Godina);
            }
            else
                query = query.OrderByDescending(y => y.Godina);

            return base.AddFilter(query, search);
        }

        public async Task<List<MektebBodoviDto>> GetUkupniBodoviPoMektebu(int takmicenjeId)
        {
            var result = await _dbContext.Takmicar
                .Where(t => t.Kategorija!.TakmicenjeId == takmicenjeId && t.MektebId != null)
                .GroupBy(t => new { t.MektebId, t.Mekteb!.Naziv })
                .Select(g => new MektebBodoviDto
                {
                    MektebId = g.Key.MektebId!.Value,
                    NazivMekteba = g.Key.Naziv,
                    UkupnoBodova = g.Sum(x => x.UkupnoBodova ?? 0)
                })
                .OrderByDescending(x => x.UkupnoBodova)
                .ToListAsync();

            return result;
        }


    }
}

