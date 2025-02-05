using eMekteb.Services.Database;
using Microsoft.EntityFrameworkCore.Metadata.Builders;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eMekteb.Services.Seed
{
    public static class KorisniciUlogeData
    {
        public static void SeedData(this EntityTypeBuilder<KorisniciUloge> entity)
        {
            entity.HasData(
                new KorisniciUloge
                {
                    Id = 1,
                    DatumIzmjene= new DateTime(2024, 08, 20),
                    KorisnikId = 1,
                    UlogaId = 1
                },
                new KorisniciUloge
                {
                    Id = 2,
                    DatumIzmjene= new DateTime(2024, 08, 20),
                    KorisnikId = 2,
                    UlogaId = 4
                },
                new KorisniciUloge
                {
                    Id = 3,
                    DatumIzmjene= new DateTime(2024, 08, 20),
                    KorisnikId = 3,
                    UlogaId = 2
                },
                new KorisniciUloge
                {
                    Id = 4,
                    DatumIzmjene= new DateTime(2024, 08, 20),
                    KorisnikId = 4,
                    UlogaId = 5
                },
                new KorisniciUloge
                {
                    Id = 5,
                    DatumIzmjene= new DateTime(2024, 08, 20),
                    KorisnikId = 5,
                    UlogaId = 3
                },
                new KorisniciUloge
                {
                    Id = 6,
                    DatumIzmjene = new DateTime(2024, 08, 20),
                    KorisnikId = 7,
                    UlogaId = 4
                },
                new KorisniciUloge
                {
                    Id = 7,
                    DatumIzmjene = new DateTime(2024, 08, 20),
                    KorisnikId = 11,
                    UlogaId = 4
                },
                new KorisniciUloge
                {
                    Id = 8,
                    DatumIzmjene = new DateTime(2024, 08, 20),
                    KorisnikId = 15,
                    UlogaId = 4
                },
                new KorisniciUloge
                {
                    Id = 9,
                    DatumIzmjene = new DateTime(2024, 08, 20),
                    KorisnikId = 18,
                    UlogaId = 4
                },
                new KorisniciUloge
                {
                    Id = 10,
                    DatumIzmjene = new DateTime(2024, 08, 20),
                    KorisnikId = 21,
                    UlogaId = 4
                },
                new KorisniciUloge
                {
                    Id = 11,
                    DatumIzmjene = new DateTime(2024, 08, 20),
                    KorisnikId = 6,
                    UlogaId = 2
                },
                new KorisniciUloge
                {
                    Id = 12,
                    DatumIzmjene = new DateTime(2024, 08, 20),
                    KorisnikId = 8,
                    UlogaId = 2
                },
                new KorisniciUloge
                {
                    Id = 13,
                    DatumIzmjene = new DateTime(2024, 08, 20),
                    KorisnikId = 9,
                    UlogaId = 2
                },
                new KorisniciUloge
                {
                    Id = 14,
                    DatumIzmjene = new DateTime(2024, 08, 20),
                    KorisnikId = 10,
                    UlogaId = 2
                },
                new KorisniciUloge
                {
                    Id = 15,
                    DatumIzmjene = new DateTime(2024, 08, 20),
                    KorisnikId = 12,
                    UlogaId = 2
                },
                new KorisniciUloge
                {
                    Id = 16,
                    DatumIzmjene = new DateTime(2024, 08, 20),
                    KorisnikId = 13,
                    UlogaId = 2
                },
                new KorisniciUloge
                {
                    Id = 17,
                    DatumIzmjene = new DateTime(2024, 08, 20),
                    KorisnikId = 14,
                    UlogaId = 2
                },
                new KorisniciUloge
                {
                    Id = 18,
                    DatumIzmjene = new DateTime(2024, 08, 20),
                    KorisnikId = 16,
                    UlogaId = 2
                },
                new KorisniciUloge
                {
                    Id = 19,
                    DatumIzmjene = new DateTime(2024, 08, 20),
                    KorisnikId = 17,
                    UlogaId = 2
                },
                new KorisniciUloge
                {
                    Id = 20,
                    DatumIzmjene = new DateTime(2024, 08, 20),
                    KorisnikId = 19,
                    UlogaId = 2
                },
                new KorisniciUloge
                {
                    Id = 21,
                    DatumIzmjene = new DateTime(2024, 08, 20),
                    KorisnikId = 20,
                    UlogaId = 2
                },
                new KorisniciUloge
                {
                    Id = 22,
                    DatumIzmjene = new DateTime(2024, 08, 20),
                    KorisnikId = 22,
                    UlogaId = 2
                },
                new KorisniciUloge
                {
                    Id = 23,
                    DatumIzmjene = new DateTime(2024, 08, 20),
                    KorisnikId = 23,
                    UlogaId = 2
                },
                new KorisniciUloge
                {
                    Id = 24,
                    DatumIzmjene = new DateTime(2024, 08, 20),
                    KorisnikId = 24,
                    UlogaId = 2
                },
                new KorisniciUloge
                {
                    Id = 25,
                    DatumIzmjene = new DateTime(2024, 08, 20),
                    KorisnikId = 25,
                    UlogaId = 2
                },
                new KorisniciUloge
                {
                    Id = 26,
                    DatumIzmjene = new DateTime(2024, 08, 20),
                    KorisnikId = 26,
                    UlogaId = 2
                },
                new KorisniciUloge
                {
                    Id = 27,
                    DatumIzmjene = new DateTime(2024, 08, 20),
                    KorisnikId = 27,
                    UlogaId = 2
                },
                new KorisniciUloge
                {
                    Id = 28,
                    DatumIzmjene = new DateTime(2024, 08, 20),
                    KorisnikId = 28,
                    UlogaId = 2
                },
                new KorisniciUloge
                {
                    Id = 29,
                    DatumIzmjene = new DateTime(2024, 08, 20),
                    KorisnikId = 29,
                    UlogaId = 2
                },
                new KorisniciUloge
                {
                    Id = 30,
                    DatumIzmjene = new DateTime(2024, 08, 20),
                    KorisnikId = 30,
                    UlogaId = 2
                },
                new KorisniciUloge
                {
                    Id = 31,
                    DatumIzmjene = new DateTime(2024, 08, 20),
                    KorisnikId = 31,
                    UlogaId = 3
                },
                new KorisniciUloge
                {
                    Id = 32,
                    DatumIzmjene = new DateTime(2024, 08, 20),
                    KorisnikId = 32,
                    UlogaId = 3
                },
                new KorisniciUloge
                {
                    Id = 33,
                    DatumIzmjene = new DateTime(2024, 08, 20),
                    KorisnikId = 33,
                    UlogaId = 3
                },
                new KorisniciUloge
                {
                    Id = 34,
                    DatumIzmjene = new DateTime(2024, 08, 20),
                    KorisnikId = 34,
                    UlogaId = 3
                },
                new KorisniciUloge
                {
                    Id = 35,
                    DatumIzmjene = new DateTime(2024, 08, 20),
                    KorisnikId = 35,
                    UlogaId = 3
                },
                new KorisniciUloge
                {
                    Id = 36,
                    DatumIzmjene = new DateTime(2024, 08, 20),
                    KorisnikId = 36,
                    UlogaId = 2
                },
                new KorisniciUloge
                {
                    Id = 37,
                    DatumIzmjene = new DateTime(2024, 08, 20),
                    KorisnikId = 37,
                    UlogaId = 2
                },
                new KorisniciUloge
                {
                    Id = 38,
                    DatumIzmjene = new DateTime(2024, 08, 20),
                    KorisnikId = 38,
                    UlogaId = 6
                },
                new KorisniciUloge
                {
                    Id = 39,
                    DatumIzmjene = new DateTime(2024, 08, 20),
                    KorisnikId = 39,
                    UlogaId = 6
                },
                new KorisniciUloge
                {
                    Id = 40,
                    DatumIzmjene = new DateTime(2024, 08, 20),
                    KorisnikId = 39,
                    UlogaId = 1
                },
                new KorisniciUloge
                {
                    Id = 41,
                    DatumIzmjene = new DateTime(2024, 08, 20),
                    KorisnikId = 41,
                    UlogaId = 1
                }
                ,
                new KorisniciUloge
                {
                    Id = 42,
                    DatumIzmjene = new DateTime(2024, 08, 20),
                    KorisnikId = 42,
                    UlogaId = 6
                }


            );
        }
    }
}
