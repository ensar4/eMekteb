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
    public class TakmicarController : BaseCRUDController<TakmicarM, TakmicarSearchObject, TakmicarInsert, TakmicarUpdate>
    { 
        public TakmicarController(ILogger<BaseController<TakmicarM, TakmicarSearchObject>> logger, ITakmicarService service) : base(logger, service)
        {

        }
    }
}
