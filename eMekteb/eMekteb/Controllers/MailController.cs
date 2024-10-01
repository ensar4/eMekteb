using eMekteb.Model;
using eMekteb.Model.Request;
using eMekteb.Model.SearchObjects;
using eMekteb.Services;
using eMekteb.Services.Database;
using eMekteb.Services.Interfaces;
using Microsoft.AspNetCore.Mvc;

namespace eMekteb.Controllers
{
    [Route("[controller]")]
    [ApiController]
    public class MailController : ControllerBase
    {
        public IMailService _service;

        public MailController(IMailService service)
        {
            _service = service;


        }

        [HttpPost]
        public async Task sendMail([FromBody] MailObject obj)
        {
            await _service.startConnection(obj);
        }
    }
}
