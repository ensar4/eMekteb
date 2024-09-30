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
    public class AkademskaMektebController : BaseCRUDController<AkademskaMektebM, BaseSearchObject, AkademskaMektebInsert, AkademskaMektebUpdate>
    {
        IAkademskaMektebService service1;
        public AkademskaMektebController(ILogger<BaseController<AkademskaMektebM, BaseSearchObject>> logger, IAkademskaMektebService service) : base(logger, service)
        {
            service1 = service;
        }


    }
}
