using eMekteb.Model;
using eMekteb.Model.Request;
using eMekteb.Model.SearchObjects;
using eMekteb.Services.Interfaces;
using Microsoft.AspNetCore.Mvc;

namespace eMekteb.Controllers
{

    [ApiController]
    public class MektebController : BaseCRUDController<MektebM, MektebSearchObject, MektebInsert, MektebUpdate>
    {
        public MektebController(ILogger<BaseController<MektebM, MektebSearchObject>> logger, IMektebService service) : base(logger, service)
        {
        }
    }
}
