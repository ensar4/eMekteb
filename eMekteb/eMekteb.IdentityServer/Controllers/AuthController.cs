using eMekteb.Services.Interfaces;
using eMekteb.Services;
using Microsoft.AspNetCore.Mvc;
using Microsoft.IdentityModel.Tokens;
using System.IdentityModel.Tokens.Jwt;
using System.Net;
using System.Security.Claims;
using System.Text;
using eMekteb.Services.Database;
using AutoMapper;
using Microsoft.OpenApi.Writers;

namespace eMekteb.IdentityServer.Controllers;

[ApiController]
[Route("[action]")]
public class AuthController : ControllerBase
{
    private readonly IConfiguration Configuration;
    private readonly IKorisnikService KorisnikService;
    private readonly IMapper _mapper;    //++++++


    public AuthController(
        IConfiguration configuration,
        IKorisnikService korisnikService,
        IMapper mapper)
    {
        Configuration = configuration;
        KorisnikService = korisnikService;
        _mapper = mapper;//++++++
    }

    [HttpGet]
    public async Task<string> Login(string username, string lozinka)
    {
        var employee = await KorisnikService.GetByUsernameAndLozinkaAsync(username, lozinka);

        if (employee is null)
        {
            Response.StatusCode = (int)HttpStatusCode.NotFound;
            return String.Empty;
        }

        var secretKey = new SymmetricSecurityKey(Encoding.UTF8.GetBytes(Configuration.GetValue<string>("JWTSecret")!));

        var signingCredentials = new SigningCredentials(secretKey, SecurityAlgorithms.HmacSha256Signature);



        var claims = new List<Claim>                    //secretKey, SecurityAlgorithms.HmacSha256Signature
                                                     //secretKey, SecurityAlgorithms.HmacSha256         ---->  STARI
        {
            new Claim(ClaimTypes.Sid, employee.Id.ToString()),
            new Claim(ClaimTypes.NameIdentifier, employee.Username),
            new Claim(ClaimTypes.Name, employee.Ime + ' ' + employee.Prezime),
           // new Claim(ClaimTypes.Email, employee.Email)
        };


        employee.KorisniciUloge
                .Select(ku => ku.Uloga)  
                .ToList()                
                .ForEach(uloga => claims.Add(new Claim(ClaimTypes.Role, uloga.Naziv))); 


        var token = new JwtSecurityToken(
            issuer: "https://localhost:7049",
            audience: null,
            claims: claims,
            expires: DateTime.Now.AddHours(1),
            signingCredentials: signingCredentials
        );

        return new JwtSecurityTokenHandler().WriteToken(token);
    }
}//na prvom dependecy manageru(eMekteb) dodao i IS
//na drugom(IS) dodao i drugi strihir