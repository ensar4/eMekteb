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
    public class PrisustvoController : BaseCRUDController<PrisustvoM, BaseSearchObject, PrisustvoInsert, object>
    { 
        public PrisustvoController(ILogger<BaseController<PrisustvoM, BaseSearchObject>> logger, IPrisustvoService service) : base(logger, service)
        {

        }
    }
}
