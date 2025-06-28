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
        Task<PagedResult<KorisnikM>> GetUcenici(int? id, int? MedzlisId);

        Task<PagedResult<KorisnikM>> GetSuperAdmin(int? Id, int? MuftijstvoId);
        Task<PagedResult<KorisnikM>> GetMualimi(int ? id, int? MedzlisId, int? MuftijstvoId);
        Task<PagedResult<KorisnikM>> GetKomisija(int? id, int? MedzlisId);
        Task<PagedResult<KorisnikM>> GetAdmin(int? id, int? MedzlisId, int? MuftijstvoId);
        Task<bool> ChangePassword(ChangePasswordRequest request);
        Task<UcenikRoditeljResponse> CreateStudentWithParentAsync(KorisnikInsert studentInsert, KorisnikInsert parentInsert);
        Task<PagedResult<KorisnikM>> GetByRoditeljId(int roditeljId);
        Task<PagedResult<KorisnikM>> GetUcenikHistory(int? ucenikId);

        Task<bool> ResetPassword(string email);


    }
}
