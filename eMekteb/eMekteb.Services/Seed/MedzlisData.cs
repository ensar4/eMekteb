
using eMekteb.Services.Database;
using Microsoft.EntityFrameworkCore.Metadata.Builders;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eMedzlis.Services.Seed
{
    public static class MedzlisData
    {
        public static void SeedData(this EntityTypeBuilder<Medzlis> entity)
        {
            entity.HasData(
                new Medzlis
                {
                    Id = 1,
                    Adresa = "Mostar",
                    Telefon= "08464634",
                    Naziv = "Medzlis Mostar"
                }
              
            );
        }
    }
}
