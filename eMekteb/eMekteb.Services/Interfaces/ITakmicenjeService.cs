using eMekteb.Model;
using eMekteb.Model.DTOs;
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
    public interface ITakmicenjeService : ICRUDService<TakmicenjeM, TakmicenjeSearchObject, TakmicenjeInsert, TakmicenjeUpdate>
    {
        public Task<TakmicenjeM?> GetLastTakmicenjeAsync();
        Task<List<MektebBodoviDto>> GetUkupniBodoviPoMektebu(int takmicenjeId);

    }
}
