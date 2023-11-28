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
    public class BodoviController : BaseCRUDController<BodoviM, BaseSearchObject, BodoviInsert, object>
    { 
        public BodoviController(ILogger<BaseController<BodoviM, BaseSearchObject>> logger, IBodoviService service) : base(logger, service)
        {

        }
    }
}
