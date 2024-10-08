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
    public class RazredKorisnikController : BaseCRUDController<RazredKorisnikM, BaseSearchObject, RazredKorisnikInsert, RazredKorisnikUpdate>
    {
        IRazredKorisnikService service1;
        public RazredKorisnikController(ILogger<BaseController<RazredKorisnikM, BaseSearchObject>> logger, IRazredKorisnikService
            service) : base(logger, service)
        {
            service1 = service;
        }


    }
}
