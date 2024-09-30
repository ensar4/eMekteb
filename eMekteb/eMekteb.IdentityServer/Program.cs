using Duende.IdentityServer.Test;
using eMekteb.Services.Interfaces;
using eMekteb.Services;
using eWorkshop.IdentityServer;
using Microsoft.AspNetCore.Identity;
using eMekteb.Services.Database;
using Microsoft.EntityFrameworkCore;
using Microsoft.AspNetCore.Hosting;
using AutoMapper;
using Microsoft.Extensions.Configuration;

var builder = WebApplication.CreateBuilder(args);



//builder.Services.AddTransient<IKorisnikService, KorisnikService>();              +++++++++++++
builder.Services.AddScoped<IKorisnikService, KorisnikService>();



// Add services to the container.

var connectionString = builder.Configuration.GetConnectionString("DefaultConnection"); //++++++++++

builder.Services.AddDbContext<eMektebContext>(options =>
            options.UseSqlServer(connectionString));

//builder.Services.AddDbContext<eMektebContext>(options =>
//    options.UseSqlServer(connectionString, sqlOptions => sqlOptions.MigrationsAssembly("eMekteb.Services")));

//AutoMaper
builder.Services.AddAutoMapper(typeof(MektebService));                                  //++++++

builder.Services.AddControllers();
// Learn more about configuring Swagger/OpenAPI at https://aka.ms/aspnetcore/swashbuckle
builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen();

builder.Services.AddIdentityServer(options =>
{
    options.Events.RaiseErrorEvents = true;
    options.Events.RaiseInformationEvents = true;
    options.Events.RaiseFailureEvents = true;
    options.Events.RaiseSuccessEvents = true;

    options.EmitStaticAudienceClaim = true;
})
.AddTestUsers(Config.Users)
//.AddAspNetIdentity<IdentityUser>()
.AddInMemoryClients(Config.Clients)
.AddInMemoryApiResources(Config.ApiResources)
  .AddInMemoryApiScopes(Config.ApiScopes)
  .AddInMemoryIdentityResources(Config.IdentityResources);

var app = builder.Build();

// Configure the HTTP request pipeline.
if (app.Environment.IsDevelopment())
{
    app.UseSwagger();
    app.UseSwaggerUI();
}

app.UseHttpsRedirection();

app.UseAuthorization();

app.UseIdentityServer();

app.MapControllers();

app.Run();
