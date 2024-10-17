using eMekteb.Services.Database;
using Microsoft.EntityFrameworkCore.Metadata.Builders;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eMekteb.Services.Seed
{
    public static class KampKorisnikData
    {
        public static void SeedData(this EntityTypeBuilder<KampKorisnik> entity)
        {
            entity.HasData(
                new KampKorisnik
                {
                    Id = 1,
                    DatumDodavanja= new DateTime(2024, 08, 15),
                    KorisnikId = 6,
                    KampId = 1
                },
                new KampKorisnik
                {
                    Id = 2,
                    DatumDodavanja= new DateTime(2024, 08, 15),
                    KorisnikId = 19,
                    KampId = 1
                },
                new KampKorisnik
                {
                    Id = 3,
                    DatumDodavanja= new DateTime(2024, 08, 15),
                    KorisnikId = 20,
                    KampId = 1
                },
                new KampKorisnik
                {
                    Id = 4,
                    DatumDodavanja= new DateTime(2024, 08, 15),
                    KorisnikId = 36,
                    KampId = 1
                },
                new KampKorisnik
                {
                    Id = 5,
                    DatumDodavanja= new DateTime(2024, 08, 15),
                    KorisnikId = 37,
                    KampId = 1
                },
                new KampKorisnik
                {
                    Id = 6,
                    DatumDodavanja = new DateTime(2024, 08, 15),
                    KorisnikId = 6,
                    KampId = 2
                },
                new KampKorisnik
                {
                    Id = 7,
                    DatumDodavanja = new DateTime(2024, 08, 15),
                    KorisnikId = 19,
                    KampId = 2
                },
                new KampKorisnik
                {
                    Id = 8,
                    DatumDodavanja = new DateTime(2024, 08, 15),
                    KorisnikId = 20,
                    KampId = 2
                },
                new KampKorisnik
                {
                    Id = 9,
                    DatumDodavanja = new DateTime(2024, 08, 15),
                    KorisnikId = 36,
                    KampId = 2
                },
                new KampKorisnik
                {
                    Id = 10,
                    DatumDodavanja = new DateTime(2024, 08, 15),
                    KorisnikId = 37,
                    KampId = 2
                }
            );
        }
    }
}
