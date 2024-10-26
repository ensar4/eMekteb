
using eMekteb.Services.Database;
using Microsoft.EntityFrameworkCore.Metadata.Builders;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eMekteb.Services.Seed
{
    public static class KampData
    {
        public static void SeedData(this EntityTypeBuilder<Kamp> entity)
        {
            entity.HasData(
                new Kamp
                {
                    Id = 1,
                    Naziv = "Kamp 2023",
                    Opis = "Kamp za sve polaznike mekteba. Bujrum!",
                    DatumPocetka = new DateTime(2023, 08, 12),
                    DatumZavrsetka = new DateTime(2023, 08, 20),
                    MektebId = 1,
                    Voditelj = "Imam dzemata"
                },
                new Kamp
                {
                    Id = 2,
                    Naziv = "Kamp 2024",
                    Opis = "Kamp za sve polaznike mekteba. Bujrum!",
                    DatumPocetka = new DateTime(2024, 08, 12),
                    DatumZavrsetka = new DateTime(2024, 08, 20),
                    MektebId = 1,
                    Voditelj = "Imam dzemata"
                }
               
            );
        }
    }
}
