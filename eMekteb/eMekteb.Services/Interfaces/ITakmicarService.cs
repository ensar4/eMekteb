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
    public interface ITakmicarService : ICRUDService<TakmicarM, TakmicarSearchObject, TakmicarInsert, TakmicarUpdate>
    {
        Task<PagedResult<TakmicarM>> GetByKategorijaId(int kategorijaId);
        Task<TakmicarM> Update(TakmicarM takmicar);
        Task<TakmicarM> UpdatePoints(int id, int points);
    }

}
