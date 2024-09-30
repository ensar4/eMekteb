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
    public interface IKampService : ICRUDService<KampM, BaseSearchObject, KampInsert, KampUpdate>
    {
        Task<PagedResult<KampM>> GetByMektebId(int mektebId);
        public Task<KampM?> GetLastKampAsync();
    }
}
