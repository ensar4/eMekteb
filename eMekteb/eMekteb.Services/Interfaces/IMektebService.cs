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
    public interface IMektebService : ICRUDService<MektebM, MektebSearchObject, MektebInsert, MektebUpdate>
    {
       
    }
}
