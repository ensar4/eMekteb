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

            return base.AddFilter(query, search);
        }



    }
}
