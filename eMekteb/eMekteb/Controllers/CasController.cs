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
    public class CasController : BaseCRUDController<CasM, BaseSearchObject, CasInsert, CasUpdate>
    {
        ICasService service1;
        public CasController(ILogger<BaseController<CasM, BaseSearchObject>> logger, ICasService service) : base(logger, service)
        {
            service1 = service;
        }

        [HttpGet("{Mektebid}")]
        public async Task<PagedResult<CasM>> GetByMektebId(int Mektebid)
        {
            return await service1.GetByMektebId(Mektebid);
        }
    }
}
