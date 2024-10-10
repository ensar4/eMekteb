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
    public class ZadacaService : BaseCRUDService<ZadacaM, Zadaca, BaseSearchObject, ZadacaInsert, ZadacaUpdate>, IZadacaService
    {
        public ZadacaService(eMektebContext dbContext, IMapper mapper) : base(dbContext, mapper)
        {
        }

        public async Task<PagedResult<ZadacaM>> GetByKorisnikId(int korisnikId)
        {
            var items = await _dbContext.Set<Zadaca>()
                                        .Where(z => z.KorisnikId == korisnikId)
                                        .Join(_dbContext.Razred,
                                              zadaca => zadaca.RazredId,
                                              razred => razred.Id,
                                              (zadaca, razred) => new
                                              {
                                                  Zadaca = zadaca,
                                                  RazredNaziv = razred.Naziv
                                              }).OrderByDescending(z=>z.Zadaca.DatumDodjele)
                                        .ToListAsync();

            var mappedItems = items.Select(i =>
            {
                var zadacaM = _mapper.Map<ZadacaM>(i.Zadaca);
                zadacaM.NazivRazreda = i.RazredNaziv; 
                return zadacaM;
            }).ToList();

            PagedResult<ZadacaM> result = new PagedResult<ZadacaM>
            {
                Count = mappedItems.Count,
                Result = mappedItems
            };

            return result;
        }



    }
}
