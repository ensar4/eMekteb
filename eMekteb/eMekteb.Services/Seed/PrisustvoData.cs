using eMekteb.Services.Database;
using Microsoft.EntityFrameworkCore.Metadata.Builders;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eMekteb.Services.Seed
{
    public static class PrisustvoData
    {
        public static void SeedData(this EntityTypeBuilder<Prisustvo> entity)
        {
            entity.HasData(
               new Prisustvo
               {
                   Id = 1,
                   Datum = new DateTime(2024, 09, 12),
                   KorisnikId = 3,
                   RazredId = 1,
                   CasId = 1,
                   Prisutan = true,
               },
               new Prisustvo
               {
                   Id = 2,
                   Datum = new DateTime(2024, 09, 13),
                   KorisnikId = 3,
                   RazredId = 1,
                   CasId = 2,
                   Prisutan = true,
               },
               new Prisustvo
               {
                   Id = 3,
                   Datum = new DateTime(2024, 09, 18),
                   KorisnikId = 3,
                   RazredId = 1,
                   CasId = 3,
                   Prisutan = true,
               },
               new Prisustvo
               {
                   Id = 4,
                   Datum = new DateTime(2024, 09, 19),
                   KorisnikId = 3,
                   RazredId = 2,
                   CasId = 4,
                   Prisutan = true,
               },
               new Prisustvo
               {
                   Id = 5,
                   Datum = new DateTime(2024, 09, 20),
                   KorisnikId = 3,
                   RazredId = 2,
                   CasId = 5,
                   Prisutan = true,
               },
               new Prisustvo
               {
                   Id = 6,
                   Datum = new DateTime(2024, 09, 27),
                   KorisnikId = 3,
                   RazredId = 2,
                   CasId = 6,
                   Prisutan = true,
               },
               new Prisustvo
               {
                   Id = 7,
                   Datum = new DateTime(2024, 09, 28),
                   KorisnikId = 3,
                   RazredId = 2,
                   CasId = 7,
                   Prisutan = false,
               },
               new Prisustvo
               {
                   Id = 8,
                   Datum = new DateTime(2024, 09, 12),
                   KorisnikId = 3,
                   RazredId = 3,
                   CasId = 3,
                   Prisutan = true,
               },
               new Prisustvo
               {
                   Id = 9,
                   Datum = new DateTime(2024, 09, 12),
                   KorisnikId = 3,
                   RazredId = 3,
                   CasId = 2,
                   Prisutan = true,
               },
               new Prisustvo
               {
                   Id = 10,
                   Datum = new DateTime(2024, 09, 12),
                   KorisnikId = 3,
                   RazredId = 3,
                   CasId = 5,
                   Prisutan = true,
               },
               new Prisustvo
               {
                   Id = 11,
                   Datum = new DateTime(2024, 09, 12),
                   KorisnikId = 6,
                   RazredId = 3,
                   CasId = 3,
                   Prisutan = false,
               },
               new Prisustvo
               {
                   Id = 12,
                   Datum = new DateTime(2024, 09, 12),
                   KorisnikId = 19,
                   RazredId = 3,
                   CasId = 4,
                   Prisutan = true,
               },
               new Prisustvo
               {
                   Id = 13,
                   Datum = new DateTime(2024, 09, 12),
                   KorisnikId = 20,
                   RazredId = 4,
                   CasId = 2,
                   Prisutan = true,
               },
               new Prisustvo
               {
                   Id = 14,
                   Datum = new DateTime(2023, 09, 12),
                   KorisnikId = 36,
                   RazredId = 1,
                   CasId = 2,
                   Prisutan = false,
               },
               new Prisustvo
               {
                   Id = 15,
                   Datum = new DateTime(2024, 09, 12),
                   KorisnikId = 37,
                   RazredId = 2,
                   CasId = 3,
                   Prisutan = true,
               },
               new Prisustvo
               {
                   Id = 16,
                   Datum = new DateTime(2024, 09, 12),
                   KorisnikId = 37,
                   RazredId = 1,
                   CasId = 6,
                   Prisutan = false,
               },
               new Prisustvo
               {
                   Id = 17,
                   Datum = new DateTime(2023, 09, 12),
                   KorisnikId = 8,
                   RazredId = 9,
                   CasId = 11,
                   Prisutan = true,
               },
               new Prisustvo
               {
                   Id = 18,
                   Datum = new DateTime(2024, 09, 12),
                   KorisnikId = 9,
                   RazredId = 9,
                   CasId = 11,
                   Prisutan = true,
               },
               new Prisustvo
               {
                   Id = 19,
                   Datum = new DateTime(2024, 09, 12),
                   KorisnikId = 10,
                   RazredId = 10,
                   CasId = 11,
                   Prisutan = true,
               },
               new Prisustvo
               {
                   Id = 20,
                   Datum = new DateTime(2024, 09, 12),
                   KorisnikId = 16,
                   RazredId = 7,
                   CasId = 12,
                   Prisutan = true,
               },
               new Prisustvo
               {
                   Id = 21,
                   Datum = new DateTime(2024, 09, 12),
                   KorisnikId = 17,
                   RazredId = 7,
                   CasId = 13,
                   Prisutan = true,
               },
               new Prisustvo
               {
                   Id = 22,
                   Datum = new DateTime(2024, 09, 12),
                   KorisnikId = 23,
                   RazredId = 8,
                   CasId = 13,
                   Prisutan = true,
               },
               new Prisustvo
               {
                   Id = 23,
                   Datum = new DateTime(2024, 09, 12),
                   KorisnikId = 22,
                   RazredId = 15,
                   CasId = 16,
                   Prisutan = true,
               },
               new Prisustvo
               {
                   Id = 24,
                   Datum = new DateTime(2024, 09, 12),
                   KorisnikId = 14,
                   RazredId = 16,
                   CasId = 16,
                   Prisutan = true,
               },
               new Prisustvo
               {
                   Id = 25,
                   Datum = new DateTime(2024, 09, 12),
                   KorisnikId = 13,
                   RazredId = 13,
                   CasId = 16,
                   Prisutan = true,
               },
               new Prisustvo
               {
                   Id = 26,
                   Datum = new DateTime(2024, 09, 12),
                   KorisnikId = 12,
                   RazredId = 13,
                   CasId = 16,
                   Prisutan = true,
               },
               new Prisustvo
               {
                   Id = 27,
                   Datum = new DateTime(2024, 09, 12),
                   KorisnikId = 12,
                   RazredId = 14,
                   CasId = 17,
                   Prisutan = false,
               },
               new Prisustvo
               {
                   Id = 28,
                   Datum = new DateTime(2024, 09, 12),
                   KorisnikId = 24,
                   RazredId = 21,
                   CasId = 19,
                   Prisutan = true,
               },
               new Prisustvo
               {
                   Id = 29,
                   Datum = new DateTime(2024, 09, 12),
                   KorisnikId = 25,
                   RazredId = 21,
                   CasId = 19,
                   Prisutan = true,
               },
               new Prisustvo
               {
                   Id = 30,
                   Datum = new DateTime(2024, 09, 12),
                   KorisnikId = 26,
                   RazredId = 21,
                   CasId = 19,
                   Prisutan = true,
               },
               new Prisustvo
               {
                   Id = 31,
                   Datum = new DateTime(2024, 09, 12),
                   KorisnikId = 27,
                   RazredId = 22,
                   CasId = 19,
                   Prisutan = true,
               },
               new Prisustvo
               {
                   Id = 34,
                   Datum = new DateTime(2024, 09, 12),
                   KorisnikId = 28,
                   RazredId = 27,
                   CasId = 19,
                   Prisutan = true,
               },
               new Prisustvo
               {
                   Id = 32,
                   Datum = new DateTime(2024, 09, 12),
                   KorisnikId = 29,
                   RazredId = 33,
                   CasId = 20,
                   Prisutan = true,
               },
               new Prisustvo
               {
                   Id = 33,
                   Datum = new DateTime(2024, 09, 12),
                   KorisnikId = 30,
                   RazredId = 35,
                   CasId = 21,
                   Prisutan = true,
               }


            );
        }
    }
}
