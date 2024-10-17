
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
                    Adresa = "Čiče Miličevića, Mostar 88000",
                    Telefon= "036 550-727",
                    Naziv = "Medzlis Mostar",
                    Mail = "medzlismostar@gmail.com"
                }
              
            );
        }
    }
}
