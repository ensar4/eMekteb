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
        public KategorijaController(ILogger<BaseController<KategorijaM, BaseSearchObject>> logger, IKategorijaService service) : base(logger, service)
        {

        }
    }
}
