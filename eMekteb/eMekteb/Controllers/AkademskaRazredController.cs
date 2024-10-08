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
    public class AkademskaRazredController : BaseCRUDController<AkademskaRazredM, BaseSearchObject, AkademskaRazredInsert, AkademskaRazredUpdate>
    {
        IAkademskaRazredService service1;
        public AkademskaRazredController(ILogger<BaseController<AkademskaRazredM, BaseSearchObject>> logger, IAkademskaRazredService
            service) : base(logger, service)
        {
            service1 = service;
        }


    }
}
