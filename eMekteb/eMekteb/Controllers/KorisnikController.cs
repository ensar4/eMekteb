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
    public class KorisnikController : BaseCRUDController<KorisnikM, KorisnikSearchObject, KorisnikInsert, KorisnikUpdate>
    { 

        protected new IKorisnikService service1;
        public KorisnikController(ILogger<BaseController<KorisnikM, KorisnikSearchObject>> logger, IKorisnikService service) : base(logger, service)
        {
            service1 = service;
        }

        [HttpGet("{Roditeljid}")]
        public async Task<PagedResult<KorisnikM>> GetByRoditeljId(int Roditeljid)
        {
            return await service1.GetByRoditeljId(Roditeljid);
        }
        [HttpGet("/Ucenici")]
        public async Task<PagedResult<KorisnikM>> GetUcenici(int? MektebId, int? MedzlisId)
        {
            return await service1.GetUcenici(MektebId, MedzlisId);
        }

        [HttpGet("/Ucenici/{MektebId}")]
        public async Task<PagedResult<KorisnikM>> GetUceniciByMektebId(int? MektebId, int? MedzlisId)
        {
            return await service1.GetUcenici(MektebId, MedzlisId);
        }


        [HttpGet("/UcenikHistory/{ucenikId}")]
        public async Task<PagedResult<KorisnikM>> GetUceniHistory(int? ucenikId)
        {

            return await service1.GetUcenikHistory(ucenikId);
        }

        [HttpGet("/Mualimi")]
        public async Task<PagedResult<KorisnikM>> GetMualimi(int? MektebId, int? MedzlisId, int? MuftijstvoId)
        {

            return await service1.GetMualimi(MektebId, MedzlisId, MuftijstvoId);
        }


        [HttpGet("/Mualimi/{MektebId}")]
        public async Task<PagedResult<KorisnikM>> GetMualimiByMektebId(int? MektebId, int? MedzlisId, int? MuftijstvoId)
        {

            return await service1.GetMualimi(MektebId, MedzlisId, MuftijstvoId);
        }

        [HttpGet("/Komisija")]
        public async Task<PagedResult<KorisnikM>> GetKomisija(int? MektebId, int? MedzlisId)
        {

            return await service1.GetKomisija(MektebId, MedzlisId);
        }

        [HttpGet("/Admin")]
        public async Task<PagedResult<KorisnikM>> GetAdmin(int? MektebId, int? MedzlisId, int? MuftijstvoId)
        {

            return await service1.GetAdmin(MektebId, MedzlisId, MuftijstvoId);
        }   
        
        [HttpGet("/SuperAdmin")]
        public async Task<PagedResult<KorisnikM>> GetSuperAdmin(int? MektebId, int? MuftijstvoId)
        {

            return await service1.GetSuperAdmin(MektebId, MuftijstvoId);
        }



        [HttpPost("change-password")]
        public async Task<IActionResult> ChangePassword([FromBody] ChangePasswordRequest request)
        {
            try
            {
                bool result = await service1.ChangePassword(request);
                if (result)
                {
                    return Ok("Password changed successfully.");
                }
                else
                {
                    return BadRequest("Failed to change password.");
                }
            }
            catch (Exception ex)
            {
                return BadRequest(ex.Message);
            }
        }

        [HttpPost("create-student-with-parent")]
        public async Task<IActionResult> CreateStudentWithParent([FromBody] UcenikRoditelj dto)
        {
            if (dto == null) return BadRequest("Invalid data.");

            var studentInsert = new KorisnikInsert
            {
                Ime = dto.UcenikIme,
                Prezime = dto.UcenikPrezime,
                Username = dto.UcenikUsername, Password = dto.UcenikPassword, 
                PasswordPotvrda = dto.UcenikPasswordPotvrda,
                Telefon = dto.UcenikTelefon,
                Mail = dto.UcenikMail,
                Spol = dto.UcenikSpol,
                Status = dto.UcenikStatus,
                DatumRodjenja = dto.UcenikDatumRodjenja,
                ImeRoditelja = dto.UcenikImeRoditelja,
                MektebId = dto.UcenikMektebId,
               // RazredId = dto.UcenikRazredId
            };

            var parentInsert = new KorisnikInsert
            {
                Ime = dto.RoditeljIme,
                Prezime = dto.RoditeljPrezime,
                Username = dto.RoditeljUsername,
                Password = dto.RoditeljPassword,
                PasswordPotvrda = dto.RoditeljPasswordPotvrda,
                Telefon = dto.RoditeljTelefon,
                Mail = dto.RoditeljMail,
                Spol = dto.RoditeljSpol,
                Status = dto.RoditeljStatus,
                DatumRodjenja = dto.RoditeljDatumRodjenja,
                ImeRoditelja = dto.RoditeljImeRoditelja,
                MektebId = dto.RoditeljMektebId,
                //RazredId = dto.RoditeljRazredId

            };

            var result = await service1.CreateStudentWithParentAsync(studentInsert, parentInsert);

            return Ok(result);
        }



    }
}
