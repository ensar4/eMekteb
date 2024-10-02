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
                    Naziv = "I nivo"
                },
                new Razred
                {
                    Id = 2,
                    Naziv = "II nivo"
                },
                new Razred
                {
                    Id = 3,
                    Naziv = "III nivo"
                },
                new Razred
                {
                    Id = 4,
                    Naziv = "Sufara"
                },
                new Razred
                {
                    Id = 5,
                    Naziv = "Tedzvid"
                },
                new Razred
                {
                    Id = 6,
                    Naziv = "Hatma"
                }
              
            );
        }
    }
}
