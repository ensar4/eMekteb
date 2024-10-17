using eMekteb.Services.Database;
using Microsoft.EntityFrameworkCore.Metadata.Builders;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eMekteb.Services.Seed
{
    public static class ZadacaData
    {
        public static void SeedData(this EntityTypeBuilder<Zadaca> entity)
        {
            entity.HasData(
               new Zadaca
               {
                   Id = 1,
                   DatumDodjele = new DateTime(2024, 09, 12),
                   KorisnikId = 3,
                   RazredId = 1,
                   OcjeneId = 3,
                   ZaZadacu = "Fatiha",
                   Lekcija = "Krupno R"
               },
               new Zadaca
               {
                   Id = 2,
                   DatumDodjele = new DateTime(2024, 09, 12),
                   KorisnikId = 3,
                   RazredId = 3,
                   OcjeneId = 1,
                   ZaZadacu = "Subhaneke",
                   Lekcija = "Ja Sin"
               },
               new Zadaca
               {
                   Id = 3,
                   DatumDodjele = new DateTime(2024, 09, 12),
                   KorisnikId = 3,
                   RazredId = 2,
                   OcjeneId = 4,
                   ZaZadacu = "Ja Sin",
                   Lekcija = "Fatiha"
               },
               new Zadaca
               {
                   Id = 4,
                   DatumDodjele = new DateTime(2024, 09, 12),
                   KorisnikId = 3,
                   RazredId = 2,
                   OcjeneId = 2,
                   ZaZadacu = "Fatiha",
                   Lekcija = "Subhaneke"
               },
               new Zadaca
               {
                   Id = 5,
                   DatumDodjele = new DateTime(2024, 09, 12),
                   KorisnikId = 3,
                   RazredId = 3,
                   OcjeneId = 5,
                   ZaZadacu = "Subhaneke",
                   Lekcija = "Krupno R"
               },
               new Zadaca
               {
                   Id = 6,
                   DatumDodjele = new DateTime(2024, 09, 12),
                   KorisnikId = 3,
                   RazredId = 2,
                   OcjeneId = 1,
                   ZaZadacu = "Rabbijesir",
                   Lekcija = "Ja Sin"
               },
               new Zadaca
               {
                   Id = 7,
                   DatumDodjele = new DateTime(2024, 09, 12),
                   KorisnikId = 3,
                   RazredId = 1,
                   OcjeneId = 4,
                   ZaZadacu = "Ja Sin",
                   Lekcija = "Subhaneke"
               },
               new Zadaca
               {
                   Id = 8,
                   DatumDodjele = new DateTime(2024, 09, 12),
                   KorisnikId = 3,
                   RazredId = 1,
                   OcjeneId = 3,
                   ZaZadacu = "Fatiha",
                   Lekcija = "Rabbijesir"
               },
               new Zadaca
               {
                   Id = 9,
                   DatumDodjele = new DateTime(2024, 09, 12),
                   KorisnikId = 3,
                   RazredId = 2,
                   OcjeneId = 2,
                   ZaZadacu = "Rabbijesir",
                   Lekcija = "Krupno R"
               },
               new Zadaca
               {
                   Id = 10,
                   DatumDodjele = new DateTime(2024, 09, 12),
                   KorisnikId = 3,
                   RazredId = 3,
                   OcjeneId = 5,
                   ZaZadacu = "Subhaneke",
                   Lekcija = "Fatiha"
               },
               new Zadaca
               {
                   Id = 11,
                   DatumDodjele = new DateTime(2024, 09, 12),
                   KorisnikId = 6,
                   RazredId = 4,
                   OcjeneId = 3,
                   ZaZadacu = "Fatiha",
                   Lekcija = "Ja Sin"
               },
               new Zadaca
               {
                   Id = 12,
                   DatumDodjele = new DateTime(2024, 09, 12),
                   KorisnikId = 19,
                   RazredId = 4,
                   OcjeneId = 4,
                   ZaZadacu = "Krupno R",
                   Lekcija = "Rabbijesir"
               },
               new Zadaca
               {
                   Id = 13,
                   DatumDodjele = new DateTime(2024, 09, 12),
                   KorisnikId = 20,
                   RazredId = 4,
                   OcjeneId = 2,
                   ZaZadacu = "Ja Sin",
                   Lekcija = "Subhaneke"
               },
               new Zadaca
               {
                   Id = 14,
                   DatumDodjele = new DateTime(2023, 09, 12),
                   KorisnikId = 36,
                   RazredId = 1,
                   OcjeneId = 1,
                   ZaZadacu = "Subhaneke",
                   Lekcija = "Krupno R"
               },
               new Zadaca
               {
                   Id = 15,
                   DatumDodjele = new DateTime(2024, 09, 12),
                   KorisnikId = 37,
                   RazredId = 2,
                   OcjeneId = 3,
                   ZaZadacu = "Fatiha",
                   Lekcija = "Rabbijesir"
               },
               new Zadaca
               {
                   Id = 16,
                   DatumDodjele = new DateTime(2024, 09, 12),
                   KorisnikId = 37,
                   RazredId = 1,
                   OcjeneId = 5,
                   ZaZadacu = "Rabbijesir",
                   Lekcija = "Ja Sin"
               },
               new Zadaca
               {
                   Id = 17,
                   DatumDodjele = new DateTime(2023, 09, 12),
                   KorisnikId = 8,
                   RazredId = 9,
                   OcjeneId = 2,
                   ZaZadacu = "Ja Sin",
                   Lekcija = "Subhaneke"
               },
               new Zadaca
               {
                   Id = 18,
                   DatumDodjele = new DateTime(2024, 09, 12),
                   KorisnikId = 9,
                   RazredId = 10,
                   OcjeneId = 5,
                   ZaZadacu = "Fatiha",
                   Lekcija = "Subhaneke"
               },
               new Zadaca
               {
                   Id = 19,
                   DatumDodjele = new DateTime(2024, 09, 12),
                   KorisnikId = 10,
                   RazredId = 10,
                   OcjeneId = 3,
                   ZaZadacu = "Rabbijesir",
                   Lekcija = "Fatiha"
               },
               new Zadaca
               {
                   Id = 20,
                   DatumDodjele = new DateTime(2024, 09, 12),
                   KorisnikId = 16,
                   RazredId = 7,
                   OcjeneId = 4,
                   ZaZadacu = "Subhaneke",
                   Lekcija = "Ja Sin"
               },
               new Zadaca
               {
                   Id = 21,
                   DatumDodjele = new DateTime(2024, 09, 12),
                   KorisnikId = 17,
                   RazredId = 7,
                   OcjeneId = 1,
                   ZaZadacu = "Krupno R",
                   Lekcija = "Rabbijesir"
               },
               new Zadaca
               {
                   Id = 22,
                   DatumDodjele = new DateTime(2024, 09, 12),
                   KorisnikId = 17,
                   RazredId = 8,
                   OcjeneId = 5,
                   ZaZadacu = "Ja Sin",
                   Lekcija = "Subhaneke"
               },
               new Zadaca
               {
                   Id = 23,
                   DatumDodjele = new DateTime(2024, 09, 12),
                   KorisnikId = 23,
                   RazredId = 15,
                   OcjeneId = 3,
                   ZaZadacu = "Fatiha",
                   Lekcija = "Krupno R"
               },
               new Zadaca
               {
                   Id = 24,
                   DatumDodjele = new DateTime(2024, 09, 12),
                   KorisnikId = 22,
                   RazredId = 16,
                   OcjeneId = 4,
                   ZaZadacu = "Rabbijesir",
                   Lekcija = "Ja Sin"
               },
               new Zadaca
               {
                   Id = 25,
                   DatumDodjele = new DateTime(2024, 09, 12),
                   KorisnikId = 14,
                   RazredId = 16,
                   OcjeneId = 5,
                   ZaZadacu = "Subhaneke",
                   Lekcija = "Rabbijesir"
               },
               new Zadaca
               {
                   Id = 26,
                   DatumDodjele = new DateTime(2024, 09, 12),
                   KorisnikId = 13,
                   RazredId = 13,
                   OcjeneId = 3,
                   ZaZadacu = "Fatiha",
                   Lekcija = "Krupno R"
               },
               new Zadaca
               {
                   Id = 27,
                   DatumDodjele = new DateTime(2024, 09, 12),
                   KorisnikId = 12,
                   RazredId = 14,
                   OcjeneId = 4,
                   ZaZadacu = "Krupno R",
                   Lekcija = "Rabbijesir"
               },
               new Zadaca
               {
                   Id = 28,
                   DatumDodjele = new DateTime(2024, 09, 12),
                   KorisnikId = 24,
                   RazredId = 21,
                   OcjeneId = 2,
                   ZaZadacu = "Krupno R",
                   Lekcija = "Rabbijesir"
               },
               new Zadaca
               {
                   Id = 29,
                   DatumDodjele = new DateTime(2024, 09, 12),
                   KorisnikId = 25,
                   RazredId = 21,
                   OcjeneId = 3,
                   ZaZadacu = "Krupno R",
                   Lekcija = "Rabbijesir"
               },
               new Zadaca
               {
                   Id = 30,
                   DatumDodjele = new DateTime(2024, 09, 12),
                   KorisnikId = 26,
                   RazredId = 21,
                   OcjeneId = 2,
                   ZaZadacu = "Krupno R",
                   Lekcija = "Rabbijesir"
               },
               new Zadaca
               {
                   Id = 31,
                   DatumDodjele = new DateTime(2024, 09, 12),
                   KorisnikId = 28,
                   RazredId = 27,
                   OcjeneId = 1,
                   ZaZadacu = "Krupno R",
                   Lekcija = "Rabbijesir"
               },
               new Zadaca
               {
                   Id = 32,
                   DatumDodjele = new DateTime(2024, 09, 12),
                   KorisnikId = 29,
                   RazredId = 33,
                   OcjeneId = 1,
                   ZaZadacu = "Krupno R",
                   Lekcija = "Rabbijesir"
               },
               new Zadaca
               {
                   Id = 33,
                   DatumDodjele = new DateTime(2024, 09, 12),
                   KorisnikId = 30,
                   RazredId = 35,
                   OcjeneId = 1,
                   ZaZadacu = "Krupno R",
                   Lekcija = "Rabbijesir"
               }


            );
        }
    }
}
