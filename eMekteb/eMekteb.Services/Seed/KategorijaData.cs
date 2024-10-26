
using eMekteb.Services.Database;
using Microsoft.EntityFrameworkCore.Metadata.Builders;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eMekteb.Services.Seed
{
    public static class KategorijaData
    {
        public static void SeedData(this EntityTypeBuilder<Kategorija> entity)
        {
            entity.HasData(
                new Kategorija
                {
                    Id = 1,
                    Naziv = "Hifz",
                    Nivo = "1",
                    TakmicenjeId = 1,
                },
                new Kategorija
                {
                    Id = 2,
                    Naziv = "Hifz",
                    Nivo = "2",
                    TakmicenjeId = 1,
                },
                new Kategorija
                {
                    Id = 3,
                    Naziv = "Hifz",
                    Nivo = "3",
                    TakmicenjeId = 1,
                },new Kategorija
                {
                    Id = 4,
                    Naziv = "Opće znanje",
                    Nivo = "1",
                    TakmicenjeId = 1,
                },
                new Kategorija
                {
                    Id = 5,
                    Naziv = "Opće znanje",
                    Nivo = "2",
                    TakmicenjeId = 1,
                },
                new Kategorija
                {
                    Id = 6,
                    Naziv = "Opće znanje",
                    Nivo = "3",
                    TakmicenjeId = 1,
                },
                new Kategorija
                {
                    Id = 7,
                    Naziv = "Hifz",
                    Nivo = "1",
                    TakmicenjeId = 2,
                },
                new Kategorija
                {
                    Id = 8,
                    Naziv = "Hifz",
                    Nivo = "2",
                    TakmicenjeId = 2,
                },
                new Kategorija
                {
                    Id = 9,
                    Naziv = "Hifz",
                    Nivo = "3",
                    TakmicenjeId = 2,
                },
                new Kategorija
                {
                    Id = 10,
                    Naziv = "Opće znanje",
                    Nivo = "1",
                    TakmicenjeId = 2,
                },
                new Kategorija
                {
                    Id = 11,
                    Naziv = "Opće znanje",
                    Nivo = "2",
                    TakmicenjeId = 2,
                },
                new Kategorija
                {
                    Id = 12,
                    Naziv = "Opće znanje",
                    Nivo = "3",
                    TakmicenjeId = 2,
                }
               
            );
        }
    }
}
