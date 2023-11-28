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
    public interface IKorisnikService : ICRUDService<KorisnikM, KorisnikSearchObject, KorisnikInsert, KorisnikUpdate>
    {
        Task<KorisnikM> Login(string username, string password);
    }
}
