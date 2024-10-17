
using eMekteb.Services.Database;
using Microsoft.EntityFrameworkCore.Metadata.Builders;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eAkademskaGodina.Services.Seed
{
    public static class AkademskaGodinaData
    {
        public static void SeedData(this EntityTypeBuilder<AkademskaGodina> entity)
        {
            entity.HasData(
                new AkademskaGodina
                {
                    Id = 1,
                    Naziv = "2022/23",
                    DatumPocetka = new DateTime(2022, 09, 12),
                    DatumZavrsetka = new DateTime(2023, 06, 12),
                    isAktivna = false
                },
                new AkademskaGodina
                {
                    Id = 2,
                    Naziv = "2023/24",
                    DatumPocetka = new DateTime(2023, 09, 12),
                    DatumZavrsetka = new DateTime(2024, 06, 12),
                    isAktivna = false
                },
                new AkademskaGodina
                {
                    Id = 3,
                    Naziv = "2024/25",
                    DatumPocetka = new DateTime(2024, 09, 12),
                    DatumZavrsetka = new DateTime(2025, 06, 12),
                    isAktivna = true
                }
            );
        }
    }
}
