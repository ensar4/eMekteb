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
    public class DodatneLekcijeController : BaseCRUDController<DodatneLekcijeM, BaseSearchObject, DodatneLekcijeInsert, DodatneLekcijeUpdate>
    { 
        public DodatneLekcijeController(ILogger<BaseController<DodatneLekcijeM, BaseSearchObject>> logger, IDodatneLekcijeService service) : base(logger, service)
        {

        }
    }
}
