using eMekteb.Model;
using eMekteb.Model.Request;
using eMekteb.Model.SearchObjects;
using eMekteb.Services.Database;
using eMekteb.Services.Interfaces;
using Microsoft.AspNetCore.Mvc;

namespace eMekteb.Controllers
{

    [ApiController]
    public class MuftijstvoController : BaseCRUDController<MuftijstvoM, MuftijstvoSearchObject, MuftijstvoInsert, MuftijstvoUpdate>
    {
        public MuftijstvoController(ILogger<BaseController<MuftijstvoM, MuftijstvoSearchObject>> logger, IMuftijstvoService service) : base(logger, service)
        {
        }
    }
}
