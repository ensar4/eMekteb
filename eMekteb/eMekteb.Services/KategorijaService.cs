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
using static Microsoft.EntityFrameworkCore.DbLoggerCategory;

namespace eMekteb.Services
{
    public class KategorijaService : BaseCRUDService<KategorijaM, Kategorija, BaseSearchObject, KategorijaInsert, object>, IKategorijaService
    {
        public KategorijaService(eMektebContext dbContext, IMapper mapper) : base(dbContext, mapper)
        {
        }

        public async Task<PagedResult<KategorijaM>> GetByTakmicenjeId(int takmicenjeId)
        {
            var items = await _dbContext.Set<Kategorija>()
                                   .Where(y => y.TakmicenjeId == takmicenjeId)
                                   .ToListAsync();
            PagedResult<KategorijaM> result = new PagedResult<KategorijaM>();
            result.Count = items.Count();

            var tmp = _mapper.Map<List<KategorijaM>>(items);
            result.Result = tmp;

            return result;
        }

    }
}
