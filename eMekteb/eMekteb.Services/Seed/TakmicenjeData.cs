
using eMekteb.Services.Database;
using Microsoft.EntityFrameworkCore.Metadata.Builders;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eMekteb.Services.Seed
{
    public static class TakmicenjeData
    {
        public static void SeedData(this EntityTypeBuilder<Takmicenje> entity)
        {
            entity.HasData(
                new Takmicenje
                {
                    Id = 1,
                    Godina = "2023",
                    Info = "Takmicenje za sve polaznike mekteba. Bujrum!",
                    DatumOdrzavanja = new DateTime(2023, 06, 12),
                    Lokacija = "Medresa",
                    MedzlisId = 1,
                    VrijemePočetka = "10:00"
                },
                new Takmicenje
                {
                    Id = 2,
                    Godina = "2024",
                    Info = "Takmicenje za sve polaznike mekteba. Bujrum!",
                    DatumOdrzavanja = new DateTime(2024, 06, 12),
                    Lokacija = "Medresa",
                    MedzlisId = 1,
                    VrijemePočetka = "10:00"
                }
               
            );
        }
    }
}
