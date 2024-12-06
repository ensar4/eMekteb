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
    public class TakmicenjeController : BaseCRUDController<TakmicenjeM, TakmicenjeSearchObject, TakmicenjeInsert, TakmicenjeUpdate>
    {
        ITakmicenjeService service1;
        public TakmicenjeController(ILogger<BaseController<TakmicenjeM, TakmicenjeSearchObject>> logger, ITakmicenjeService service) : base(logger, service)
        {
            service1 = service;
        }
        [HttpGet("last")]
        public async Task<IActionResult> GetLastTakmicenje()
        {
            var result = await service1.GetLastTakmicenjeAsync();
            if (result == null)
            {
                return NotFound();
            }
            return Ok(result);
        }
    }
}
