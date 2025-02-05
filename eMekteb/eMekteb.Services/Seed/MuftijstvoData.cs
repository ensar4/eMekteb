
using eMekteb.Services.Database;
using Microsoft.EntityFrameworkCore.Metadata.Builders;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eMekteb.Services.Seed
{
    public static class MuftijstvoData
    {
        public static void SeedData(this EntityTypeBuilder<Muftijstvo> entity)
        {
            entity.HasData(
                new Muftijstvo
                {
                    Id = 1,
                    Adresa = "Čiče Miličevića, Mostar 88000",
                    Telefon= "036 550-727",
                    Naziv = "Muftijstvo Mostarsko",
                    Mail = "muftijstvomostar@gmail.com",
                },
                new Muftijstvo
                {
                    Id = 2,
                    Adresa = "Čiče Miličevića, Sarajevo 88000",
                    Telefon= "036 550-727",
                    Naziv = "Muftijstvo Sarajevsko",
                    Mail = "muftijstvosarajevo@gmail.com",
                }
              
            );
        }
    }
}
