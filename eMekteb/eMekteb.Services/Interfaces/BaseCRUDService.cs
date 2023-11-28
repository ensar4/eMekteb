using AutoMapper;
using eMekteb.Model.SearchObjects;
using eMekteb.Services.Database;
using Microsoft.EntityFrameworkCore.Metadata.Conventions;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eMekteb.Services.Interfaces
{
    public class BaseCRUDService<T, TDb, TSearch, TInsert, TUpdate> : BaseService<T, TDb, TSearch> where T : class where TDb : class where TSearch : BaseSearchObject
    {
        public BaseCRUDService(eMektebContext dbContext, IMapper mapper) : base(dbContext, mapper)
        {
        }

        public virtual async Task BeforeInsert(TDb entity, TInsert insert)
        {

        }
        public virtual async Task<T> Insert(TInsert insert)
        {
            var set = _dbContext.Set<TDb>();

            TDb entity = _mapper.Map<TDb>(insert);

            set.Add(entity);

            await BeforeInsert(entity, insert);

            await _dbContext.SaveChangesAsync();

            return _mapper.Map<T>(entity);    
        }



        public virtual async Task<T> Update(int id, TUpdate update)
        {
            var set = _dbContext.Set<TDb>();

            var entity = await set.FindAsync(id);

            _mapper.Map(update, entity);

            await _dbContext.SaveChangesAsync();

            return _mapper.Map<T>(entity);

        }
    }
}
