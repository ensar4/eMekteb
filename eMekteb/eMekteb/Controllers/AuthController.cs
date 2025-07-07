using eMekteb.Services.Interfaces;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.IdentityModel.Tokens;
using System.IdentityModel.Tokens.Jwt;
using System.Security.Claims;
using System.Text;

namespace eMekteb.Controllers
{
    [ApiController]
    [Route("[controller]")]
    public class AuthController : ControllerBase
    {
        private readonly IKorisnikService _korisnikService;
        private readonly IConfiguration _configuration;

        public AuthController(IKorisnikService korisnikService, IConfiguration configuration)
        {
            _korisnikService = korisnikService;
            _configuration = configuration;
        }

        // [HttpPost("login")]
        [HttpGet("/Login")]
        [AllowAnonymous]
        public async Task<IActionResult> Login(string username, string lozinka)
        {
            var korisnik = await _korisnikService.GetByUsernameAndLozinkaAsync(username, lozinka);
            if (korisnik == null)
                return Unauthorized();

            var claims = new List<Claim>
            {
                new Claim(ClaimTypes.Sid, korisnik.Id.ToString()),
                new Claim(ClaimTypes.NameIdentifier, korisnik.Username),
                new Claim(ClaimTypes.Name, $"{korisnik.Ime} {korisnik.Prezime}"),
                new Claim("MektebId", korisnik.MektebId.ToString())
            };

            if (korisnik.MedzlisId.HasValue)
                claims.Add(new Claim("MedzlisId", korisnik.MedzlisId.Value.ToString()));

            if (korisnik.MuftijstvoId.HasValue)
                claims.Add(new Claim("MuftijstvoId", korisnik.MuftijstvoId.Value.ToString()));

            korisnik.KorisniciUloge
                .Select(ku => ku.Uloga)
                .ToList()
                .ForEach(uloga => claims.Add(new Claim(ClaimTypes.Role, uloga.Naziv)));


            var key = new SymmetricSecurityKey(Encoding.UTF8.GetBytes(_configuration["JWTSecret"]!));
            var creds = new SigningCredentials(key, SecurityAlgorithms.HmacSha256);

            var token = new JwtSecurityToken(
                issuer: "https://localhost:7160",
                audience: null,
                claims: claims,
                expires: DateTime.Now.AddHours(48),
                signingCredentials: creds);

            var jwt = new JwtSecurityTokenHandler().WriteToken(token);

            return Ok(jwt);
        }
    }

    public class AuthLoginRequest
    {
        public string Username { get; set; } = null!;
        public string Lozinka { get; set; } = null!;
    }
}
