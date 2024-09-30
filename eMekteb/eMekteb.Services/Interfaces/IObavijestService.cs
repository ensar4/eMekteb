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
    public interface IObavijestService : ICRUDService<ObavijestM, ObavijestSearchObject, ObavijestInsert, ObavijestUpdate>
    {
        Task<PagedResult<ObavijestM>> GetByMektebId(int mektebId);
        Task<ObavijestM> Activate(int id);
        Task<ObavijestM> Hide(int id);
        Task<List<string>> AllowedActions(int id);
    }
}
