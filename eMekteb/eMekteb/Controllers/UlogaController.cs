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
    public class UlogaController : BaseCRUDController<UlogaM, BaseSearchObject, UlogaInsert, object>
    { 
        public UlogaController(ILogger<BaseController<UlogaM, BaseSearchObject>> logger, IUlogaService service) : base(logger, service)
        {

        }
    }
}
