using AutoMapper;
using eMekteb.Model;
using eMekteb.Model.SearchObjects;
using eMekteb.Services.Database;
using eMekteb.Services.Interfaces;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.SqlServer.Query.Internal;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eMekteb.Services
{
    public class BaseService<T, TDb, TSearch> : IService<T, TSearch> where T : class where TDb : class where TSearch : BaseSearchObject
    {
        protected eMektebContext _dbContext;
        protected IMapper _mapper { get; set; }

        public BaseService(eMektebContext dbContext, IMapper mapper)
        {
            this._dbContext = dbContext;
            this._mapper = mapper;
        }



        public virtual async Task<PagedResult<T>> Get(TSearch? search)
        {
            var query = _dbContext.Set<TDb>().AsQueryable();
            query = AddFilter(query, search);
            query = AddInclude(query, search);

            PagedResult<T> result = new PagedResult<T>();
            result.Count = await query.CountAsync();


            if (search?.Page.HasValue == true && search?.PageSize.HasValue == true)
            {
                if (query.Count() > search.PageSize)
                {
                    int skipCount = (search.Page.Value - 1) * search.PageSize.Value;
                    query = query.Skip(skipCount).Take(search.PageSize.Value);
                }

            }

            var list = await query.ToListAsync();

            var tmp = _mapper.Map<List<T>>(list);
            result.Result = tmp;

            return result;
        }
        public virtual async Task<T> GetById(int id)
        {
            var item = await _dbContext.Set<TDb>().FindAsync(id);
            return _mapper.Map<T>(item);
        }

        public virtual IQueryable<TDb> AddInclude(IQueryable<TDb> query, TSearch? search = null)
        {
            return query;
        }

        public virtual IQueryable<TDb> AddFilter(IQueryable<TDb> query, TSearch? search)
        {
            return query;
        }

       
    }
}
