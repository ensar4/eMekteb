using eMekteb.Model;
using eMekteb.Model.Request;
using eMekteb.Model.SearchObjects;
using eMekteb.Services.Database;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eMekteb.Services.Interfaces
{
    public interface IPrisustvoService : ICRUDService<PrisustvoM, BaseSearchObject, PrisustvoInsert, object>
    {
        public double IzracunajPostotakPrisustva(int korisnikId);
        Task<PagedResult<PrisustvoM>> GetByCasId(int casId);
        Task<PagedResult<PrisustvoM>> GetByKorisnikId(int korisnikId);


    }
}
