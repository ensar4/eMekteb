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
    public class TakmicenjeKategorijaController : BaseCRUDController<TakmicenjeKategorijaM, BaseSearchObject, TakmicenjeKategorijaInsert, object>
    {
       // ITakmicenjeKategorijaService service1;
        public TakmicenjeKategorijaController(ILogger<BaseController<TakmicenjeKategorijaM, BaseSearchObject>> logger, ITakmicenjeKategorijaService service) : base(logger, service)
        {
         //   service1 = service;
        }

        //[HttpGet("{Takmicenjeid}")]
        //public async Task<PagedResult<TakmicenjeKategorijaM>> GetByTakmicenjeId(int Takmicenjeid)
        //{
        //    return await service1.GetByTakmicenjeId(Takmicenjeid);
        //}
    }
}
