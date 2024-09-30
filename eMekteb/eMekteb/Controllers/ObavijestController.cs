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
    public class ObavijestController : BaseCRUDController<ObavijestM, ObavijestSearchObject, ObavijestInsert, ObavijestUpdate>
    {
        protected IObavijestService service1;
        public ObavijestController(ILogger<BaseController<ObavijestM, ObavijestSearchObject>> logger, IObavijestService service) : base(logger, service)
        {
           service1=service;
        }

        [HttpGet("{Mektebid}")]
        public async Task<PagedResult<ObavijestM>> GetByMektebId(int Mektebid)
        {
            return await service1.GetByMektebId(Mektebid);
        }

        [HttpPut("{id}/activate")]
        public async Task<ObavijestM> Activate(int id)
        {
            return await (_service as IObavijestService).Activate(id);
        }

        [HttpPut("{id}/hide")]
        public async Task<ObavijestM> Hide(int id)
        {
            return await (_service as IObavijestService).Hide(id);
        }

        [HttpGet("{id}/allowedActions")]
        public virtual async Task<List<string>> AllowedActions(int id)
        {
            return await service1.AllowedActions(id);
        }
    }
}
