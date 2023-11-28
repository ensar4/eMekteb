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
    public class RazredController : BaseCRUDController<RazredM, BaseSearchObject, RazredInsert, object>
    { 
        public RazredController(ILogger<BaseController<RazredM, BaseSearchObject>> logger, IRazredService service) : base(logger, service)
        {

        }
    }
}
