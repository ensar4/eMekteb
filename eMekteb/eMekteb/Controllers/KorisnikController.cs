﻿using eMekteb.Model;
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
        public async Task<PagedResult<KorisnikM>> GetUcenici(int? MektebId)
        {

            return await service1.GetUcenici(MektebId);
        }

        [HttpGet("/Ucenici/{MektebId}")]
        public async Task<PagedResult<KorisnikM>> GetUceniciByMektebId(int? MektebId)
        {

            return await service1.GetUcenici(MektebId);
        }

        [HttpGet("/Mualimi")]
        public async Task<PagedResult<KorisnikM>> GetMualimi(int? MektebId)
        {

            return await service1.GetMualimi(MektebId);
        }


        [HttpGet("/Mualimi/{MektebId}")]
        public async Task<PagedResult<KorisnikM>> GetMualimiByMektebId(int? MektebId)
        {

            return await service1.GetMualimi(MektebId);
        }

        [HttpGet("/Komisija")]
        public async Task<PagedResult<KorisnikM>> GetKomisija(int? MektebId)
        {

            return await service1.GetKomisija(MektebId);
        }

        [HttpGet("/Admin")]
        public async Task<PagedResult<KorisnikM>> GetAdmin(int? MektebId)
        {

            return await service1.GetAdmin(MektebId);
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

            // Map the DTOs to insert objects
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
                RazredId = dto.UcenikRazredId
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
                RazredId = dto.RoditeljRazredId

            };

            var result = await service1.CreateStudentWithParentAsync(studentInsert, parentInsert);

            return Ok(result);
        }



    }
}