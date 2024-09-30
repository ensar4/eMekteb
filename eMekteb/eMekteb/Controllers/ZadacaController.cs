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
    public class ZadacaController : BaseCRUDController<ZadacaM, BaseSearchObject, ZadacaInsert, ZadacaUpdate>
    {
        IZadacaService service1;
        public ZadacaController(ILogger<BaseController<ZadacaM, BaseSearchObject>> logger, IZadacaService service) : base(logger, service)
        {
            service1 = service;
        }

        [HttpGet("{Korisnikid}")]
        public async Task<PagedResult<ZadacaM>> GetByKorisnikId(int Korisnikid)
        {
            return await service1.GetByKorisnikId(Korisnikid);
        }
    }
}
