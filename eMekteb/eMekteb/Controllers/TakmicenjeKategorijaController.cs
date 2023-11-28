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
        public TakmicenjeKategorijaController(ILogger<BaseController<TakmicenjeKategorijaM, BaseSearchObject>> logger, ITakmicenjeKategorijaService service) : base(logger, service)
        {

        }
    }
}
