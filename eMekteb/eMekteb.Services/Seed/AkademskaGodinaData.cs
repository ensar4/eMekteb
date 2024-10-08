
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
                    DatumPocetka = DateTime.Now,
                    DatumZavrsetka=DateTime.Now,
                    isAktivna = false

                },
                new AkademskaGodina
                {
                    Id = 2,
                    Naziv = "2023/24",
                    DatumPocetka = DateTime.Now,
                    DatumZavrsetka = DateTime.Now,
                    isAktivna = false


                }

            );
        }
    }
}
