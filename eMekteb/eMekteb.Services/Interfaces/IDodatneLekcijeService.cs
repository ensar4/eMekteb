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
    public interface IDodatneLekcijeService : ICRUDService<DodatneLekcijeM, BaseSearchObject, DodatneLekcijeInsert, DodatneLekcijeUpdate>
    {
        Task<PagedResult<DodatneLekcijeM>> GetByMektebId(int mektebId);
        Task<DodatneLekcijeM> Update(DodatneLekcijeM takmicar);

    }
}
