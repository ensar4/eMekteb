using eMekteb.Model;
using eMekteb.Model.Request;
using eMekteb.Model.SearchObjects;
using eMekteb.Services;
using eMekteb.Services.Database;
using eMekteb.Services.Interfaces;
using Microsoft.AspNetCore.Mvc;

namespace eMekteb.Controllers
{

    [ApiController]
    public class TakmicenjeController : BaseCRUDController<TakmicenjeM, BaseSearchObject, TakmicenjeInsert, TakmicenjeUpdate>
    { 
        public TakmicenjeController(ILogger<BaseController<TakmicenjeM, BaseSearchObject>> logger, ITakmicenjeService service) : base(logger, service)
        {

        }
    }
}
