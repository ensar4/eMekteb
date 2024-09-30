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
    public class TakmicarService : BaseCRUDService<TakmicarM, Takmicar, TakmicarSearchObject, TakmicarInsert, TakmicarUpdate>, ITakmicarService
    {
        public TakmicarService(eMektebContext dbContext, IMapper mapper) : base(dbContext, mapper)
        {
        }

        public override IQueryable<Takmicar> AddFilter(IQueryable<Takmicar> query, TakmicarSearchObject? search)
        {
            if (!string.IsNullOrWhiteSpace(search.Ime))
            {
                query = query.Where(y => y.Ime.StartsWith(search.Ime));
            }
            if (!string.IsNullOrWhiteSpace(search.Prezime))
            {
                query = query.Where(y => y.Prezime.StartsWith(search.Prezime));
            }

            if (!string.IsNullOrWhiteSpace(search.FTS))
            {
                query = query.Where(y => y.Ime.Contains(search.FTS) || y.Prezime.Contains(search.FTS));
            }
            else
                query = query.OrderByDescending(y => y.UkupnoBodova);

            return base.AddFilter(query, search);
        }

        public async Task<PagedResult<TakmicarM>> GetByKategorijaId(int kategorijaId)
        {
       

            var items = await _dbContext.Set<Takmicar>()
                                   .Where(y => y.KategorijaId == kategorijaId).OrderByDescending(y => y.UkupnoBodova)
                                   .ToListAsync();

            PagedResult<TakmicarM> result = new PagedResult<TakmicarM>();
            result.Count = items.Count();


            var tmp = _mapper.Map<List<TakmicarM>>(items);
            result.Result = tmp;

            return result;
        }

        public async Task<TakmicarM> Update(TakmicarM takmicar)
        {
            var entity = await _dbContext.Takmicar.FindAsync(takmicar.Id);

            if (entity == null)
            {
                throw new KeyNotFoundException($"Takmicar with Id {takmicar.Id} not found.");
            }

            _mapper.Map(takmicar, entity);

            await _dbContext.SaveChangesAsync();

            return _mapper.Map<TakmicarM>(entity);
        }



    }
}
