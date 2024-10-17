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
                    Telefon= "036 585-964",
                    Naziv = "Mekteb Opine"
                },
                new Mekteb
                {
                    Id = 2,
                    MedzlisId = 1,
                    Adresa = "Mostar",
                    Telefon = "036 585-967",
                    Naziv = "Mekteb Zalik"
                },
                new Mekteb
                {
                    Id = 3,
                    MedzlisId = 1,
                    Adresa = "Mostar",
                    Telefon = "036 585-963",
                    Naziv = "Mekteb Luka"
                },
                new Mekteb
                {
                    Id = 4,
                    MedzlisId = 1,
                    Adresa = "Mostar",
                    Telefon = "036 585-962",
                    Naziv = "Mekteb Musala"
                },
                new Mekteb
                {
                    Id = 5,
                    MedzlisId = 1,
                    Adresa = "Mostar",
                    Telefon = "036 585-961",
                    Naziv = "Mekteb Blagaj"
                },
                new Mekteb
                {
                    Id = 6,
                    MedzlisId = 1,
                    Adresa = "Mostar",
                    Telefon = "036 585-965",
                    Naziv = "Mekteb Vrapčići"
                }
            );
        }
    }
}
