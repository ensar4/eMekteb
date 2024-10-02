using eMekteb.Services.Database;
using Microsoft.EntityFrameworkCore.Metadata.Builders;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eMekteb.Services.Seed
{
    public static class MektebData
    {
        public static void SeedData(this EntityTypeBuilder<Mekteb> entity)
        {
            entity.HasData(
                new Mekteb
                {
                    Id = 1,
                    MedzlisId = 1,
                    Adresa = "Mostar",
                    Telefon= "08464634",
                    Naziv = "Mekteb Opine"
                },
                new Mekteb
                {
                    Id = 2,
                    MedzlisId = 1,
                    Adresa = "Mostar",
                    Telefon = "08464634",
                    Naziv = "Mekteb Zalik"
                },
                new Mekteb
                {
                    Id = 3,
                    MedzlisId = 1,
                    Adresa = "Mostar",
                    Telefon = "08464634",
                    Naziv = "Mekteb Luka"
                },
                new Mekteb
                {
                    Id = 4,
                    MedzlisId = 1,
                    Adresa = "Mostar",
                    Telefon = "08464634",
                    Naziv = "Mekteb Musala"
                }
              
            );
        }
    }
}
