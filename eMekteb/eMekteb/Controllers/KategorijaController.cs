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
    public class KategorijaController : BaseCRUDController<KategorijaM, BaseSearchObject, KategorijaInsert, object>
    {
        IKategorijaService service1;
        public KategorijaController(ILogger<BaseController<KategorijaM, BaseSearchObject>> logger, IKategorijaService service) : base(logger, service)
        {
            service1 = service;
        }

        [HttpGet("{Takmicenjeid}")]
        public async Task<PagedResult<KategorijaM>> GetByTakmicenjeId(int Takmicenjeid)
        {
            return await service1.GetByTakmicenjeId(Takmicenjeid);
        }

    }
}
