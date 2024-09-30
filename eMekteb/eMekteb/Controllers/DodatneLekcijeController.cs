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
    public class DodatneLekcijeController : BaseCRUDController<DodatneLekcijeM, BaseSearchObject, DodatneLekcijeInsert, DodatneLekcijeUpdate>
    {
        IDodatneLekcijeService service1;
        public DodatneLekcijeController(ILogger<BaseController<DodatneLekcijeM, BaseSearchObject>> logger, IDodatneLekcijeService service) : base(logger, service)
        {
            service1 = service;
        }

        [HttpGet("{Mektebid}")]
        public async Task<PagedResult<DodatneLekcijeM>> GetByMektebId(int Mektebid)
        {
            return await service1.GetByMektebId(Mektebid);
        }

        [HttpPut("{id}/likes")]
        public async Task<IActionResult> UpdateLike(int id, [FromBody] int like)
        {
            var lekcija = await service1.GetById(id);
            if (lekcija == null)
            {
                return NotFound();
            }

            lekcija.Likes += like;
            await service1.Update(lekcija);

            return Ok(lekcija);
        }
        [HttpPut("{id}/dislikes")]
        public async Task<IActionResult> UpdateDislike(int id, [FromBody] int dislike)
        {
            var lekcija = await service1.GetById(id);
            if (lekcija == null)
            {
                return NotFound();
            }

            lekcija.Dislikes += dislike;
            await service1.Update(lekcija);

            return Ok(lekcija);
        }
    }
}
