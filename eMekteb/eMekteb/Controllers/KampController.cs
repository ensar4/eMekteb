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
    public class KampController : BaseCRUDController<KampM, BaseSearchObject, KampInsert, KampUpdate>
    {
        IKampService service1;
        public KampController(ILogger<BaseController<KampM, BaseSearchObject>> logger, IKampService service) : base(logger, service)
        {
            service1 = service;
        }
        [HttpGet("{Mektebid}")]
        public async Task<PagedResult<KampM>> GetByTakmicenjeId(int Mektebid)
        {
            return await service1.GetByMektebId(Mektebid);
        }

        [HttpGet("last")]
        public async Task<IActionResult> GetLastKamp()
        {
            var result = await service1.GetLastKampAsync();
            if (result == null)
            {
                return NotFound();
            }
            return Ok(result);
        }
    }
}
