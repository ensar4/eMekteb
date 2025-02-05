using eMekteb.Model;
using eMekteb.Model.Request;
using eMekteb.Model.SearchObjects;
using eMekteb.Services.Database;
using eMekteb.Services.Interfaces;
using Microsoft.AspNetCore.Mvc;

namespace eMekteb.Controllers
{

    [ApiController]
    public class MektebController : BaseCRUDController<MektebM, MektebSearchObject, MektebInsert, MektebUpdate>
    {
        IMektebService _mektebService;
        public MektebController(ILogger<BaseController<MektebM, MektebSearchObject>> logger, IMektebService service) : base(logger, service)
        {
            _mektebService = service;
        }

        [HttpGet("{MedzlisId}")]
        public async Task<PagedResult<MektebM>> GetByMedzlisId(int MedzlisId)
        {
            return await _mektebService.GetByMedzlisId(MedzlisId);
        }
    }
}
