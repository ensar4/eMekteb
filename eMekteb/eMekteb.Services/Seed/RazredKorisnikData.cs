using eMekteb.Services.Database;
using Microsoft.EntityFrameworkCore.Metadata.Builders;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eMekteb.Services.Seed
{
    public static class RazredKorisnikData
    {
        public static void SeedData(this EntityTypeBuilder<RazredKorisnik> entity)
        {
            entity.HasData(
                new RazredKorisnik
                {
                    Id = 1,
                    DatumUpisa= new DateTime(2024, 09, 12),
                    KorisnikId = 3,
                    RazredId = 1
                },
                new RazredKorisnik
                {
                    Id = 2,
                    DatumUpisa= new DateTime(2024, 09, 12),
                    KorisnikId = 3,
                    RazredId = 3
                },
                new RazredKorisnik
                {
                    Id = 3,
                    DatumUpisa= new DateTime(2024, 09, 12),
                    KorisnikId = 3,
                    RazredId = 2
                },
                new RazredKorisnik
                {
                    Id = 4,
                    DatumUpisa= new DateTime(2024, 09, 12),
                    KorisnikId = 6,
                    RazredId = 2
                },
                new RazredKorisnik
                {
                    Id = 5,
                    DatumUpisa= new DateTime(2024, 09, 12),
                    KorisnikId = 6,
                    RazredId = 3
                },
                new RazredKorisnik
                {
                    Id = 6,
                    DatumUpisa = new DateTime(2024, 09, 12),
                    KorisnikId = 6,
                    RazredId = 4
                },
                new RazredKorisnik
                {
                    Id = 7,
                    DatumUpisa = new DateTime(2024, 09, 12),
                    KorisnikId = 19,
                    RazredId = 3
                },
                new RazredKorisnik
                {
                    Id = 8,
                    DatumUpisa = new DateTime(2024, 09, 12),
                    KorisnikId = 19,
                    RazredId = 4
                },
                new RazredKorisnik
                {
                    Id = 9,
                    DatumUpisa = new DateTime(2024, 09, 12),
                    KorisnikId = 19,
                    RazredId = 5
                },
                new RazredKorisnik
                {
                    Id = 10,
                    DatumUpisa = new DateTime(2024, 09, 12),
                    KorisnikId = 20,
                    RazredId = 4
                },
                new RazredKorisnik
                {
                    Id = 11,
                    DatumUpisa = new DateTime(2024, 09, 12),
                    KorisnikId = 20,
                    RazredId = 5
                },
                new RazredKorisnik
                {
                    Id = 12,
                    DatumUpisa = new DateTime(2024, 09, 12),
                    KorisnikId = 20,
                    RazredId = 6
                },
                new RazredKorisnik
                {
                    Id = 13,
                    DatumUpisa = new DateTime(2024, 09, 12),
                    KorisnikId = 36,
                    RazredId = 1
                },
                new RazredKorisnik
                {
                    Id = 14,
                    DatumUpisa = new DateTime(2023, 09, 12),
                    KorisnikId = 37,
                    RazredId = 1
                },
                new RazredKorisnik
                {
                    Id = 15,
                    DatumUpisa = new DateTime(2024, 09, 12),
                    KorisnikId = 37,
                    RazredId = 2
                },
                new RazredKorisnik
                {
                    Id = 16,
                    DatumUpisa = new DateTime(2024, 09, 12),
                    KorisnikId = 8,
                    RazredId = 7
                },
                new RazredKorisnik
                {
                    Id = 17,
                    DatumUpisa = new DateTime(2023, 09, 12),
                    KorisnikId = 8,
                    RazredId = 8
                },
                new RazredKorisnik
                {
                    Id = 39,
                    DatumUpisa = new DateTime(2024, 09, 12),
                    KorisnikId = 8,
                    RazredId = 9
                },
                new RazredKorisnik
                {
                    Id = 18,
                    DatumUpisa = new DateTime(2024, 09, 12),
                    KorisnikId = 9,
                    RazredId = 9
                },
                new RazredKorisnik
                {
                    Id = 19,
                    DatumUpisa = new DateTime(2024, 09, 12),
                    KorisnikId = 9,
                    RazredId = 10
                },
                new RazredKorisnik
                {
                    Id = 20,
                    DatumUpisa = new DateTime(2024, 09, 12),
                    KorisnikId = 9,
                    RazredId = 11
                },
                new RazredKorisnik
                {
                    Id = 21,
                    DatumUpisa = new DateTime(2024, 09, 12),
                    KorisnikId = 10,
                    RazredId = 10
                },
                new RazredKorisnik
                {
                    Id = 22,
                    DatumUpisa = new DateTime(2024, 09, 12),
                    KorisnikId = 10,
                    RazredId = 11
                },
                new RazredKorisnik
                {
                    Id = 23,
                    DatumUpisa = new DateTime(2024, 09, 12),
                    KorisnikId = 10,
                    RazredId = 12
                },
                new RazredKorisnik
                {
                    Id = 24,
                    DatumUpisa = new DateTime(2024, 09, 12),
                    KorisnikId = 16,
                    RazredId = 7
                },
                new RazredKorisnik
                {
                    Id = 25,
                    DatumUpisa = new DateTime(2024, 09, 12),
                    KorisnikId = 17,
                    RazredId = 7
                },
                new RazredKorisnik
                {
                    Id = 26,
                    DatumUpisa = new DateTime(2024, 09, 12),
                    KorisnikId = 17,
                    RazredId = 8
                },
                new RazredKorisnik
                {
                    Id = 27,
                    DatumUpisa = new DateTime(2024, 09, 12),
                    KorisnikId = 23,
                    RazredId = 13
                },
                new RazredKorisnik
                {
                    Id = 28,
                    DatumUpisa = new DateTime(2024, 09, 12),
                    KorisnikId = 23,
                    RazredId = 14
                },
                new RazredKorisnik
                {
                    Id = 29,
                    DatumUpisa = new DateTime(2024, 09, 12),
                    KorisnikId = 23,
                    RazredId = 15
                },
                new RazredKorisnik
                {
                    Id = 30,
                    DatumUpisa = new DateTime(2024, 09, 12),
                    KorisnikId = 22,
                    RazredId = 15
                },
                new RazredKorisnik
                {
                    Id = 31,
                    DatumUpisa = new DateTime(2024, 09, 12),
                    KorisnikId = 22,
                    RazredId = 16
                },
                new RazredKorisnik
                {
                    Id = 32,
                    DatumUpisa = new DateTime(2024, 09, 12),
                    KorisnikId = 22,
                    RazredId = 17
                },
                new RazredKorisnik
                {
                    Id = 33,
                    DatumUpisa = new DateTime(2024, 09, 12),
                    KorisnikId = 14,
                    RazredId = 16
                },
                new RazredKorisnik
                {
                    Id = 34,
                    DatumUpisa = new DateTime(2024, 09, 12),
                    KorisnikId = 14,
                    RazredId = 17
                },
                new RazredKorisnik
                {
                    Id = 35,
                    DatumUpisa = new DateTime(2024, 09, 12),
                    KorisnikId = 14,
                    RazredId = 18
                },
                new RazredKorisnik
                {
                    Id = 36,
                    DatumUpisa = new DateTime(2024, 09, 12),
                    KorisnikId = 13,
                    RazredId = 13
                },
                new RazredKorisnik
                {
                    Id = 37,
                    DatumUpisa = new DateTime(2024, 09, 12),
                    KorisnikId = 12,
                    RazredId = 13
                },
                new RazredKorisnik
                {
                    Id = 38,
                    DatumUpisa = new DateTime(2024, 09, 12),
                    KorisnikId = 12,
                    RazredId = 14
                },
                  new RazredKorisnik
                  {
                      Id = 40,
                      DatumUpisa = new DateTime(2024, 09, 12),
                      KorisnikId = 24,
                      RazredId = 19
                  },
                new RazredKorisnik
                {
                    Id = 41,
                    DatumUpisa = new DateTime(2024, 09, 12),
                    KorisnikId = 24,
                    RazredId = 20
                },
                new RazredKorisnik
                {
                    Id = 42,
                    DatumUpisa = new DateTime(2024, 09, 12),
                    KorisnikId = 24,
                    RazredId = 21
                },
                new RazredKorisnik
                {
                    Id = 43,
                    DatumUpisa = new DateTime(2024, 09, 12),
                    KorisnikId = 25,
                    RazredId = 20
                },
                new RazredKorisnik
                {
                    Id = 44,
                    DatumUpisa = new DateTime(2024, 09, 12),
                    KorisnikId = 25,
                    RazredId = 21
                },
                new RazredKorisnik
                {
                    Id = 45,
                    DatumUpisa = new DateTime(2024, 09, 12),
                    KorisnikId = 25,
                    RazredId = 22
                },
                new RazredKorisnik
                {
                    Id = 46,
                    DatumUpisa = new DateTime(2024, 09, 12),
                    KorisnikId = 26,
                    RazredId = 21
                },
                new RazredKorisnik
                {
                    Id = 47,
                    DatumUpisa = new DateTime(2024, 09, 12),
                    KorisnikId = 26,
                    RazredId = 22
                },
                new RazredKorisnik
                {
                    Id = 48,
                    DatumUpisa = new DateTime(2024, 09, 12),
                    KorisnikId = 26,
                    RazredId = 23
                },
                new RazredKorisnik
                {
                    Id = 49,
                    DatumUpisa = new DateTime(2024, 09, 12),
                    KorisnikId = 27,
                    RazredId = 22
                },
                new RazredKorisnik
                {
                    Id = 50,
                    DatumUpisa = new DateTime(2024, 09, 12),
                    KorisnikId = 27,
                    RazredId = 23
                },
                new RazredKorisnik
                {
                    Id = 51,
                    DatumUpisa = new DateTime(2024, 09, 12),
                    KorisnikId = 27,
                    RazredId = 24
                },
                new RazredKorisnik
                {
                    Id = 52,
                    DatumUpisa = new DateTime(2024, 09, 12),
                    KorisnikId = 28,
                    RazredId = 25
                },
                new RazredKorisnik
                {
                    Id = 53,
                    DatumUpisa = new DateTime(2023, 09, 12),
                    KorisnikId = 28,
                    RazredId = 26
                },
                new RazredKorisnik
                {
                    Id = 54,
                    DatumUpisa = new DateTime(2024, 09, 12),
                    KorisnikId = 28,
                    RazredId = 27
                },
                new RazredKorisnik
                {
                    Id = 55,
                    DatumUpisa = new DateTime(2024, 09, 12),
                    KorisnikId = 29,
                    RazredId = 31
                },
                new RazredKorisnik
                {
                    Id = 56,
                    DatumUpisa = new DateTime(2023, 09, 12),
                    KorisnikId = 29,
                    RazredId = 32
                },
                new RazredKorisnik
                {
                    Id = 57,
                    DatumUpisa = new DateTime(2024, 09, 12),
                    KorisnikId = 29,
                    RazredId = 33
                },
                new RazredKorisnik
                {
                    Id = 58,
                    DatumUpisa = new DateTime(2024, 09, 12),
                    KorisnikId = 30,
                    RazredId = 33
                },
                new RazredKorisnik
                {
                    Id = 59,
                    DatumUpisa = new DateTime(2024, 09, 12),
                    KorisnikId = 30,
                    RazredId = 34
                },
                new RazredKorisnik
                {
                    Id = 60,
                    DatumUpisa = new DateTime(2024, 09, 12),
                    KorisnikId = 30,
                    RazredId = 35
                }


            );
        }
    }
}
