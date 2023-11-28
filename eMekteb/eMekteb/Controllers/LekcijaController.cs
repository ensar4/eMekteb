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
    public class LekcijaController : BaseCRUDController<LekcijaM, BaseSearchObject, LekcijaInsert, LekcijaUpdate>
    { 
        public LekcijaController(ILogger<BaseController<LekcijaM, BaseSearchObject>> logger, ILekcijaService service) : base(logger, service)
        {

        }
    }
}
