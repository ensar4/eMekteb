
using eMekteb.Services.Database;
using Microsoft.EntityFrameworkCore.Metadata.Builders;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eObavijest.Services.Seed
{
    public static class ObavijestData
    {
        public static void SeedData(this EntityTypeBuilder<Obavijest> entity)
        {
            entity.HasData(
                new Obavijest
                {
                    Id = 1,
                    Naslov="Izlet",
                    DatumObjave = DateTime.Now,
                    VrstaObjave = "Vijest",
                    MektebId = 1

                },
                new Obavijest
                {
                    Id = 2,
                    Naslov = "Odgoda nastave",
                    DatumObjave = DateTime.Now,
                    VrstaObjave = "Vijest",
                    MektebId = 1

                }

            );
        }
    }
}
