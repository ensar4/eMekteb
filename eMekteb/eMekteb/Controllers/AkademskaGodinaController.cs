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
    public class AkademskaGodinaController : BaseCRUDController<AkademskaGodinaM, AkademskaGodSearchObject, AkademskaGodinaInsert, AkademskaGodinaUpdate>
    {
        IAkademskaGodinaService service1;
        public AkademskaGodinaController(ILogger<BaseController<AkademskaGodinaM, AkademskaGodSearchObject>> logger, IAkademskaGodinaService service) : base(logger, service)
        {
            service1 = service;
        }
        [HttpGet("active")]
        public async Task<IActionResult> GetLastAkG()
        {
            var result = await service1.GetLastAkGAsync();
            if (result == null)
            {
                return NotFound();
            }
            return Ok(result);
        }
    }
}
