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
        Task<KorisnikM> GetByUsernameAndLozinkaAsync(string username, string password);
        Task<PagedResult<KorisnikM>> GetUcenici(int ? id);
        Task<PagedResult<KorisnikM>> GetMualimi(int ? id);
        Task<PagedResult<KorisnikM>> GetKomisija(int? id);
        Task<PagedResult<KorisnikM>> GetAdmin(int? id);
        Task<bool> ChangePassword(ChangePasswordRequest request);
        Task<UcenikRoditeljResponse> CreateStudentWithParentAsync(KorisnikInsert studentInsert, KorisnikInsert parentInsert);
        Task<PagedResult<KorisnikM>> GetByRoditeljId(int roditeljId);



    }
}
