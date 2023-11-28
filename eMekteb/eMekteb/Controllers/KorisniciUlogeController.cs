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
    public class KorisniciUlogeController : BaseCRUDController<KorisniciUlogeM, BaseSearchObject, KorisniciUlogeInsert, KorisniciUlogeUpdate>
    { 
        public KorisniciUlogeController(ILogger<BaseController<KorisniciUlogeM, BaseSearchObject>> logger, IKorisniciUlogeService service) : base(logger, service)
        {

        }
    }
}
