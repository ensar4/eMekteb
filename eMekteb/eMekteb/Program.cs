using eMekteb;
using eMekteb.Controllers;
using eMekteb.Filters;
using eMekteb.Model;
using eMekteb.Model.SearchObjects;
using eMekteb.Services;
using eMekteb.Services.Database;
using eMekteb.Services.Interfaces;
using eMekteb.Services.ObavijestStateMachine;
using Microsoft.AspNetCore.Authentication;
using Microsoft.AspNetCore.Authentication.JwtBearer;
using Microsoft.EntityFrameworkCore;
using Microsoft.IdentityModel.Tokens;
using Microsoft.OpenApi.Models;
using System.Text;

var builder = WebApplication.CreateBuilder(args);

// Add services to the container.

builder.Services.AddTransient<IMektebService, MektebService>();
builder.Services.AddTransient<IService<MektebM, BaseSearchObject>, BaseService<MektebM, Mekteb, BaseSearchObject>>();

builder.Services.AddTransient<IMedzlisService, MedzlisService>();
builder.Services.AddTransient<IObavijestService, ObavijestService>();
builder.Services.AddTransient<IOcjeneService, OcjeneService>(); 
builder.Services.AddTransient<IPrisustvoService, PrisustvoService>();
builder.Services.AddTransient<IRazredService, RazredService>();
builder.Services.AddTransient<ITakmicarService, TakmicarService>();
builder.Services.AddTransient<ITakmicenjeService, TakmicenjeService>();
builder.Services.AddTransient<IKategorijaService, KategorijaService>();
builder.Services.AddTransient<IUlogaService, UlogaService>();
builder.Services.AddTransient<IZadacaService, ZadacaService>();
builder.Services.AddTransient<IAkademskaGodinaService, AkademskaGodinaService>();
builder.Services.AddTransient<IDodatneLekcijeService, DodatneLekcijeService>();
builder.Services.AddTransient<IKampService, KampService>();
builder.Services.AddTransient<ICasService, CasService>();
builder.Services.AddTransient<IKorisnikService, KorisnikService>();
builder.Services.AddTransient<IKorisniciUlogeService, KorisniciUlogeService>();
builder.Services.AddTransient<IKampKorisnikService, KampKorisnikService>();
builder.Services.AddTransient<ISlikaService, SlikaService>();
builder.Services.AddTransient<IMailService, MailService>();
builder.Services.AddTransient<IAkademskaMektebService, AkademskaMektebService>();
builder.Services.AddTransient<IAkademskaRazredService, AkademskaRazredService>();
builder.Services.AddTransient<IRazredKorisnikService, RazredKorisnikService>();

builder.Services.AddTransient<BaseState>();
builder.Services.AddTransient<InitialState>();
builder.Services.AddTransient<DraftState>();
builder.Services.AddTransient<ActiveState>();



builder.Services.AddControllers(x=>x.Filters.Add<ErrorFilter>());
// Learn more about configuring Swagger/OpenAPI at https://aka.ms/aspnetcore/swashbuckle
builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen();


var connectionString = builder.Configuration.GetConnectionString("DefaultConnection");
builder.Services.AddDbContext<eMektebContext>(options =>
            options.UseSqlServer(connectionString));


//AutoMaper
builder.Services.AddAutoMapper(typeof(MektebService));
builder.Services.AddControllersWithViews();

//builder.Services.AddAuthentication("BasicAuthentication")
//    .AddScheme<AuthenticationSchemeOptions, BasicAuthenticationHandler>("BasicAuthentication", null);

//builder.Services.AddAuthentication(JwtBearerDefaults.AuthenticationScheme)
//    .AddJwtBearer(options =>
//    {
//        options.Authority = "https://localhost:7049";
//        options.Audience = "weatherapi";
//        options.TokenValidationParameters.ValidTypes = new[] { "at+jwt" };
//    });


builder.Services.AddAuthentication(JwtBearerDefaults.AuthenticationScheme)
    .AddJwtBearer(options =>
    {
        // Korišćenje IConfiguration objekta
        var configuration = builder.Services.BuildServiceProvider().GetService<IConfiguration>();

        options.Authority = configuration.GetValue<string>("IdentityServerUrl")!;
        options.MetadataAddress = configuration.GetValue<string>("IdentityServerMetaDataUrl")!;
        options.RequireHttpsMetadata = false;

        var secretKey = new SymmetricSecurityKey(Encoding.UTF8.GetBytes(configuration.GetValue<string>("IdentityServerJWTSecret")!));

        options.TokenValidationParameters.ValidateAudience = false;
        options.TokenValidationParameters.ValidateIssuer = false;
        options.TokenValidationParameters.ValidateLifetime = true;
        options.TokenValidationParameters.ValidateIssuerSigningKey = true;
        options.TokenValidationParameters.IssuerSigningKey = secretKey;
    });


var app = builder.Build();




// Configure the HTTP request pipeline.
if (app.Environment.IsDevelopment())
{
    app.UseSwagger();
    app.UseSwaggerUI();
}

app.UseHttpsRedirection();
app.UseCors(x => x.AllowAnyOrigin().AllowAnyMethod().AllowAnyHeader());
app.UseAuthentication();
app.UseAuthorization();

app.MapControllers();

//using (var scope = app.Services.CreateScope())
//{
//    var context = scope.ServiceProvider.GetRequiredService<eMektebContext>();
//    context.Database.Migrate();
//}

app.Run();
