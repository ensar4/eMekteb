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
    public class SlikaController : BaseCRUDController<SlikaM, BaseSearchObject, SlikaInsert, SlikaUpdate>
    {
        ISlikaService service1;
        public SlikaController(ILogger<BaseController<SlikaM, BaseSearchObject>> logger, ISlikaService service) : base(logger, service)
        {
            service1 = service;
        }

        [HttpGet("{Korisnikid}")]
        public async Task<PagedResult<SlikaM>> GetByMektebId(int Korisnikid)
        {
            return await service1.GetByKorisnikId(Korisnikid);
        }
    }
}
