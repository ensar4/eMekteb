
using eMekteb.Services.Database;
using Microsoft.EntityFrameworkCore.Metadata.Builders;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eMekteb.Services.Seed
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
                    Mail = "medzlismostar@gmail.com",
                    MuftijstvoId = 1
                },
                new Medzlis
                {
                    Id = 3,
                    Adresa = "Čiče Miličevića, Stolac 88000",
                    Telefon= "036 550-727",
                    Naziv = "Medzlis Stolac",
                    Mail = "medzlisstolac@gmail.com",
                    MuftijstvoId = 1
                },
                new Medzlis
                {
                    Id = 4,
                    Adresa = "Čiče Miličevića, Čapljina 88000",
                    Telefon= "036 550-727",
                    Naziv = "Medzlis Čapljina",
                    Mail = "medzlisca@gmail.com",
                    MuftijstvoId = 1
                },
                new Medzlis
                {
                    Id = 2,
                    Adresa = "Čiče Miličevića, Sarajevo 88000",
                    Telefon= "036 550-727",
                    Naziv = "Medzlis Sarajevo",
                    Mail = "medzlisdarajevo@gmail.com",
                    MuftijstvoId = 2
                }
              
            );
        }
    }
}
