using eMekteb.Services.Database;
using Microsoft.EntityFrameworkCore.Metadata.Builders;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eMekteb.Services.Seed
{
    public static class KorisnikData
    {
        public static void SeedData(this EntityTypeBuilder<Korisnik> entity)
        {
            entity.HasData(
                new Korisnik
                {
                    Id = 1,
                    Ime = "Dino",
                    Prezime = "Maksumic",
                    Username = "admin",
                    Telefon = "123456789",
                    Mail = "johndoe@example.com",
                    Spol = "M",
                    Status = "Active",
                    DatumRodjenja = DateTime.Now,
                    ImeRoditelja = "Mujo",
                    MektebId = 1,
                   // RazredId = 1,
                    LozinkaHash = "dP9XoZcTTTU8f4ddDbNLJalRQqQ=",
                    LozinkaSalt = "jmK1d1xnmg2DC0svh3UvRw=="
                },
                new Korisnik
                {
                    Id = 2,
                    Ime = "Zijad",
                    Prezime = "Maric",
                    Username = "roditelj",
                    Telefon = "987654321",
                    Mail = "alicesmith@example.com",
                    Spol = "M",
                    Status = "Active",
                    DatumRodjenja = DateTime.Now,
                    ImeRoditelja = "Bob Smith",
                    MektebId = 1,
                   // RazredId = 1,
                    LozinkaHash = "z/sT0B+tdXeEL9SHGZRnuwLTq24=",
                    LozinkaSalt = "TojKLl0mMwNiLEbjjO9oZg==",
                
                },
                new Korisnik
                {
                    Id = 3,
                    Ime = "Lejla",
                    Prezime = "Maric",
                    Username = "ucenik",
                    Telefon = "456789123",
                    Mail = "bobjohnson@example.com",
                    Spol = "Male",
                    Status = "Aktive",
                    DatumRodjenja = DateTime.Now,
                    ImeRoditelja = "Alice Johnson",
                    MektebId = 1,
                   // RazredId = 1,
                    LozinkaHash = "YumKKJBN/A/I4N5FUZAQiS+GsKU=",
                    LozinkaSalt = "sDj4ejrFF0VUWuf3Z86EAg==",
                    RoditeljId = 2
                },
                new Korisnik
                {
                    Id = 4,
                    Ime = "Armin",
                    Prezime = "Abaza",
                    Username = "komisija",
                    Telefon = "456789123",
                    Mail = "armin@example.com",
                    Spol = "M",
                    Status = "Inactive",
                    DatumRodjenja = DateTime.Now,
                    ImeRoditelja = "Alice",
                    MektebId = 2,
                   // RazredId = 1,
                    LozinkaHash = "AM3voFixj70K2UEq0c+7KnPEoaU=",
                    LozinkaSalt = "jmK1d1xnmg2DC0svh3UvRw=="
                },
                new Korisnik
                {
                    Id = 5,
                    Ime = "Atif",
                    Prezime = "Mujkic",
                    Username = "imam",
                    Telefon = "456789123",
                    Mail = "bobjohnson@example.com",
                    Spol = "M",
                    Status = "Inactive",
                    DatumRodjenja = DateTime.Now,
                    ImeRoditelja = "Alic",
                    MektebId = 1,
                  //  RazredId = 1,
                    LozinkaHash = "cKnCCVJWJjRXqM7XevrbN6B3RbM=",
                    LozinkaSalt = "cLnMQzMpSBWfc9nVetCRnw=="
                }
               
            );
        }
    }
}
