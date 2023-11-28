using AutoMapper;
using eMekteb.Model;
using eMekteb.Model.Request;
using eMekteb.Model.SearchObjects;
using eMekteb.Services.Database;
using eMekteb.Services.Interfaces;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eMekteb.Services
{
    public class MektebService : BaseCRUDService<MektebM, Mekteb, MektebSearchObject, MektebInsert, MektebUpdate>, IMektebService
    {
        public MektebService(eMektebContext dbContext, IMapper mapper) : base(dbContext, mapper)
        {
        }
        public override IQueryable<Mekteb> AddFilter(IQueryable<Mekteb> query, MektebSearchObject? search)
        {
            if (!string.IsNullOrWhiteSpace(search.naziv))
            {
                query = query.Where(y => y.Naziv.StartsWith(search.naziv));
            }

            if (!string.IsNullOrWhiteSpace(search.FTS))
            {
                query = query.Where(y => y.Naziv.Contains(search.FTS));
            }
            return base.AddFilter(query, search);
        }

    }
}
