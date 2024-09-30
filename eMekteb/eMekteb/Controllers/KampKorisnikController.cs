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
    public class KampKorisnikController : BaseCRUDController<KampKorisnikM, BaseSearchObject, KampKorisnikInsert, KampKorisnikUpdate>
    {
        IKampKorisnikService service1;
        public KampKorisnikController(ILogger<BaseController<KampKorisnikM, BaseSearchObject>> logger, IKampKorisnikService service) : base(logger, service)
        {
            service1 = service;
        }
        [HttpGet("{Kampid}")]
        public async Task<PagedResult<KampKorisnikM>> GetByTakmicenjeId(int Kampid)
        {
            return await service1.GetByKampId(Kampid);
        }

    }
}
