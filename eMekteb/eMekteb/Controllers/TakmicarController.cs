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
    public class TakmicarController : BaseCRUDController<TakmicarM, TakmicarSearchObject, TakmicarInsert, TakmicarUpdate>
    {
        ITakmicarService service1;
        public TakmicarController(ILogger<BaseController<TakmicarM, TakmicarSearchObject>> logger, ITakmicarService service) : base(logger, service)
        {
            service1 = service;
        }

        [HttpGet("{Kategorijaid}")]
        public async Task<PagedResult<TakmicarM>> GetByKategorijaId(int Kategorijaid)
        {
            return await service1.GetByKategorijaId(Kategorijaid);
        }

        [HttpPut("{id}/points")]
        public async Task<IActionResult> UpdatePoints(int id, [FromBody] int points)
        {
            var takmicar = await service1.GetById(id);
            if (takmicar == null)
            {
                return NotFound();
            }

            takmicar.UkupnoBodova += points;
            await service1.Update(takmicar);

            return Ok(takmicar);
        }
    }
}
