using eMekteb.Services.Database;
using Microsoft.EntityFrameworkCore.Metadata.Builders;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eMekteb.Services.Seed
{
    public static class UlogaData
    {
        public static void SeedData(this EntityTypeBuilder<Uloga> entity)
        {
            entity.HasData(
                new Uloga
                {
                    Id = 1,
                    Naziv = "Admin"
                },
                new Uloga
                {
                    Id = 2,
                    Naziv = "Ucenik"
                },
                new Uloga
                {
                    Id = 3,
                    Naziv = "Imam"
                },
                new Uloga
                {
                    Id = 4,
                    Naziv = "Roditelj"
                },
                new Uloga
                {
                    Id = 5,
                    Naziv = "Komisija"
                },
                new Uloga
                {
                    Id = 6,
                    Naziv = "SuperAdmin"
                }
              
            );
        }
    }
}
