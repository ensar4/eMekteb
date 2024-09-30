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
    public class PrisustvoService : BaseCRUDService<PrisustvoM, Prisustvo, BaseSearchObject, PrisustvoInsert, object>, IPrisustvoService
    {
        public PrisustvoService(eMektebContext dbContext, IMapper mapper) : base(dbContext, mapper)
        {
        }

        public double IzracunajPostotakPrisustva(int korisnikId)
        {
            var korisnik = _dbContext.Korisnik.FirstOrDefault(k => k.Id == korisnikId);
            if (korisnik == null)
            {
                throw new ArgumentException("Korisnik ne postoji.");
            }

            var ukupnoNastava = _dbContext.Cas.Count(n => n.MektebId == korisnik.MektebId);
            var prisutnoNastava = _dbContext.Prisustvo.Count(p => p.KorisnikId == korisnikId && p.Prisutan == true);

            if (ukupnoNastava == 0)
            {
                return 0;
            }

            return (double)prisutnoNastava / ukupnoNastava * 100;
        }

        public double IzracunajPrisustvoZaKorisnika(int korisnikId)
        {
            // Ukupan broj časova
            int ukupanBrojCasova = _dbContext.Cas.Count();

            // Broj prisustvovanih časova
            int brojPrisustvovanihCasova = _dbContext.Prisustvo
                .Count(p => p.KorisnikId == korisnikId && p.Prisutan == true);

            // Izračunavanje procenta prisustva
            if (ukupanBrojCasova == 0)
            {
                return 0; // Ako nema časova, procenat prisustva je 0
            }

            return (double)brojPrisustvovanihCasova / ukupanBrojCasova * 100;
        }



        public async Task<PagedResult<PrisustvoM>> GetByCasId(int casId)
        {


            var items = await _dbContext.Set<Prisustvo>()
                                   .Where(y => y.CasId == casId)
                                   .ToListAsync();

            PagedResult<PrisustvoM> result = new PagedResult<PrisustvoM>();
            result.Count = items.Count();


            var tmp = _mapper.Map<List<PrisustvoM>>(items);
            result.Result = tmp;

            return result;
        }


        public async Task<PagedResult<PrisustvoM>> GetByKorisnikId(int korisnikId)
        {
            var items = await _dbContext.Set<Prisustvo>()
                                    .Where(y => y.KorisnikId == korisnikId)
                                    .ToListAsync();
            PagedResult<PrisustvoM> result = new PagedResult<PrisustvoM>();
            result.Count = items.Count();


            var tmp = _mapper.Map<List<PrisustvoM>>(items);
            result.Result = tmp;

            return result;
        }

    }
}
