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
    public class KorisnikController : BaseCRUDController<KorisnikM, KorisnikSearchObject, KorisnikInsert, KorisnikUpdate>
    { 
        public KorisnikController(ILogger<BaseController<KorisnikM, KorisnikSearchObject>> logger, IKorisnikService service) : base(logger, service)
        {

        }
    }
}
