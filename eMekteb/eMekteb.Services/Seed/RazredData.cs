using eMekteb.Services.Database;
using Microsoft.EntityFrameworkCore.Metadata.Builders;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eMekteb.Services.Seed
{
    public static class RazredData
    {
        public static void SeedData(this EntityTypeBuilder<Razred> entity)
        {
            entity.HasData(
                new Razred
                {
                    Id = 1,
                    Naziv = "I nivo",
                    MektebId = 1,
                },
                new Razred
                {
                    Id = 2,
                    Naziv = "II nivo",
                    MektebId = 1,
                },
                new Razred
                {
                    Id = 3,
                    Naziv = "III nivo",
                    MektebId = 1,
                },
                new Razred
                {
                    Id = 4,
                    Naziv = "Sufara",
                    MektebId = 1,
                },
                new Razred
                {
                    Id = 5,
                    Naziv = "Tedžvid",
                    MektebId = 1,
                },
                new Razred
                {
                    Id = 6,
                    Naziv = "Hatma",
                    MektebId = 1,
                },   
                new Razred
                {
                    Id = 7,
                    Naziv = "I nivo",
                    MektebId = 2,
                },
                new Razred
                {
                    Id = 8,
                    Naziv = "II nivo",
                    MektebId = 2,
                },
                new Razred
                {
                    Id = 9,
                    Naziv = "III nivo",
                    MektebId = 2,
                },
                new Razred
                {
                    Id = 10,
                    Naziv = "Sufara",
                    MektebId = 2,
                },
                new Razred
                {
                    Id = 11,
                    Naziv = "Tedžvid",
                    MektebId = 2,
                },
                new Razred
                {
                    Id = 12,
                    Naziv = "Hatma",
                    MektebId = 2,
                },   
                new Razred
                {
                    Id = 13,
                    Naziv = "I nivo",
                    MektebId = 3,
                },
                new Razred
                {
                    Id = 14,
                    Naziv = "II nivo",
                    MektebId = 3,
                },
                new Razred
                {
                    Id = 15,
                    Naziv = "III nivo",
                    MektebId = 3,
                },
                new Razred
                {
                    Id = 16,
                    Naziv = "Sufara",
                    MektebId = 3,
                },
                new Razred
                {
                    Id = 17,
                    Naziv = "Tedžvid",
                    MektebId = 3,
                },
                new Razred
                {
                    Id = 18,
                    Naziv = "Hatma",
                    MektebId = 3,
                },   
                new Razred
                {
                    Id = 19,
                    Naziv = "I nivo",
                    MektebId = 4,
                },
                new Razred
                {
                    Id = 20,
                    Naziv = "II nivo",
                    MektebId = 4,
                },
                new Razred
                {
                    Id = 21,
                    Naziv = "III nivo",
                    MektebId = 4,
                },
                new Razred
                {
                    Id = 22,
                    Naziv = "Sufara",
                    MektebId = 4,
                },
                new Razred
                {
                    Id = 23,
                    Naziv = "Tedžvid",
                    MektebId = 4,
                },
                new Razred
                {
                    Id = 24,
                    Naziv = "Hatma",
                    MektebId = 4,
                },   
                new Razred
                {
                    Id = 25,
                    Naziv = "I nivo",
                    MektebId = 5,
                },
                new Razred
                {
                    Id = 26,
                    Naziv = "II nivo",
                    MektebId = 5,
                },
                new Razred
                {
                    Id = 27,
                    Naziv = "III nivo",
                    MektebId = 5,
                },
                new Razred
                {
                    Id = 28,
                    Naziv = "Sufara",
                    MektebId = 5,
                },
                new Razred
                {
                    Id = 29,
                    Naziv = "Tedžvid",
                    MektebId = 5,
                },
                new Razred
                {
                    Id = 30,
                    Naziv = "Hatma",
                    MektebId = 5,
                },   
                new Razred
                {
                    Id = 31,
                    Naziv = "I nivo",
                    MektebId = 6,
                },
                new Razred
                {
                    Id = 32,
                    Naziv = "II nivo",
                    MektebId = 6,
                },
                new Razred
                {
                    Id = 33,
                    Naziv = "III nivo",
                    MektebId = 6,
                },
                new Razred
                {
                    Id = 34,
                    Naziv = "Sufara",
                    MektebId = 6,
                },
                new Razred
                {
                    Id = 35,
                    Naziv = "Tedžvid",
                    MektebId = 6,
                },
                new Razred
                {
                    Id = 36,
                    Naziv = "Hatma",
                    MektebId = 6,
                }
              
            );
        }
    }
}
