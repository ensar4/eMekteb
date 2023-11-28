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
    public class KampController : BaseCRUDController<KampM, BaseSearchObject, KampInsert, KampUpdate>
    { 
        public KampController(ILogger<BaseController<KampM, BaseSearchObject>> logger, IKampService service) : base(logger, service)
        {

        }
    }
}
