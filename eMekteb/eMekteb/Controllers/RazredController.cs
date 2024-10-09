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
    public class RazredController : BaseCRUDController<RazredM, BaseSearchObject, RazredInsert, object>
    {
        IRazredService service1;
        public RazredController(ILogger<BaseController<RazredM, BaseSearchObject>> logger, IRazredService service) : base(logger, service)
        {
            service1 = service;
        }

        [HttpGet("{Mektebid}")]
        public async Task<PagedResult<RazredM>> GetByMektebId(int Mektebid)
        {
            return await service1.GetByMektebId(Mektebid);
        }
    }
}
