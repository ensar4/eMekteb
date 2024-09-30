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
    public class PrisustvoController : BaseCRUDController<PrisustvoM, BaseSearchObject, PrisustvoInsert, object>
    {
        protected new IPrisustvoService service1;
        public PrisustvoController(ILogger<BaseController<PrisustvoM, BaseSearchObject>> logger, IPrisustvoService service) : base(logger, service)
        {
            service1 = service;
        }

        [HttpGet("postotak-prisustva/{korisnikId}")]
        public ActionResult<double> IzracunajPostotakPrisustva(int korisnikId)
        {
            try
            {
                var postotak = service1.IzracunajPostotakPrisustva(korisnikId);
                return Ok(postotak);
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "Greška prilikom izračuna postotka prisutnosti za korisnika s ID-om {KorisnikId}", korisnikId);
                return StatusCode(500, "Dogodila se pogreška prilikom izračuna postotka prisutnosti.");
            }
        }

        [HttpGet("{Casid}")]
        public async Task<PagedResult<PrisustvoM>> GetByKategorijaId(int Casid)
        {
            return await service1.GetByCasId(Casid);
        }

        [HttpGet("byKorisnikId/{Korisnikid}")]
        public async Task<PagedResult<PrisustvoM>> GetByKorisnikId(int Korisnikid)
        {
            return await service1.GetByKorisnikId(Korisnikid);
        }
    }
}
