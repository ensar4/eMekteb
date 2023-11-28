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
    public class AkademskaGodinaController : BaseCRUDController<AkademskaGodinaM, BaseSearchObject, AkademskaGodinaInsert, AkademskaGodinaUpdate>
    { 
        public AkademskaGodinaController(ILogger<BaseController<AkademskaGodinaM, BaseSearchObject>> logger, IAkademskaGodinaService service) : base(logger, service)
        {

        }
    }
}
