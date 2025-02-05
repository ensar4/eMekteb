using eMekteb.Model;
using eMekteb.Model.Request;
using eMekteb.Model.SearchObjects;
using eMekteb.Services.Database;
using eMekteb.Services.Interfaces;
using Microsoft.AspNetCore.Mvc;

namespace eMekteb.Controllers
{

    [ApiController]
    public class MedzlisController : BaseCRUDController<MedzlisM, MedzlisSearchObject, MedzlisInsert, MedzlisUpdate>
    {
        public MedzlisController(ILogger<BaseController<MedzlisM, MedzlisSearchObject>> logger, IMedzlisService service) : base(logger, service)
        {
        }
    }
}
