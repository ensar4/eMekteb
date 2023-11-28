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
    public class OcjeneController : BaseCRUDController<OcjeneM, BaseSearchObject, OcjeneInsert, OcjeneUpdate> { 
        public OcjeneController(ILogger<BaseController<OcjeneM, BaseSearchObject>> logger, IOcjeneService service) : base(logger, service)
        {

        }
    }
}
