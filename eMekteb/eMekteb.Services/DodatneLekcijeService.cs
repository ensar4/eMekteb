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
    public class DodatneLekcijeService : BaseCRUDService<DodatneLekcijeM, DodatneLekcije, BaseSearchObject, DodatneLekcijeInsert, DodatneLekcijeUpdate>, IDodatneLekcijeService
    {
        public DodatneLekcijeService(eMektebContext dbContext, IMapper mapper) : base(dbContext, mapper)
        {
        }

        public async Task<PagedResult<DodatneLekcijeM>> GetByMektebId(int mektebId)
        {

            var items = await _dbContext.Set<DodatneLekcije>()
                                   .Where(y => y.MektebId == mektebId).OrderByDescending(y=>y.Id)
                                   .ToListAsync();
            PagedResult<DodatneLekcijeM> result = new PagedResult<DodatneLekcijeM>();
            result.Count = items.Count();

            var tmp = _mapper.Map<List<DodatneLekcijeM>>(items);
            result.Result = tmp;

            return result;
        }

        public async Task<DodatneLekcijeM> Update(DodatneLekcijeM lekcija)
        {
            var entity = await _dbContext.DodatneLekcije.FindAsync(lekcija.Id);

            if (entity == null)
            {
                throw new KeyNotFoundException($"Lekcija with Id {lekcija.Id} not found.");
            }

            _mapper.Map(lekcija, entity);

            await _dbContext.SaveChangesAsync();

            return _mapper.Map<DodatneLekcijeM>(entity);
        }




    }
}
