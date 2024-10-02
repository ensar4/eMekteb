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
                    DatumIzmjene= DateTime.Now,
                    KorisnikId = 1,
                    UlogaId = 1
                },
                new KorisniciUloge
                {
                    Id = 2,
                    DatumIzmjene= DateTime.Now,
                    KorisnikId = 2,
                    UlogaId = 4
                },
                new KorisniciUloge
                {
                    Id = 3,
                    DatumIzmjene= DateTime.Now,
                    KorisnikId = 3,
                    UlogaId = 2
                },
                new KorisniciUloge
                {
                    Id = 4,
                    DatumIzmjene= DateTime.Now,
                    KorisnikId = 4,
                    UlogaId = 5
                },
                new KorisniciUloge
                {
                    Id = 5,
                    DatumIzmjene= DateTime.Now,
                    KorisnikId = 5,
                    UlogaId = 3
                }
    

            );
        }
    }
}
