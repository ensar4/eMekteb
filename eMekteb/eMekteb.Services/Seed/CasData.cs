using eMekteb.Services.Database;
using Microsoft.EntityFrameworkCore.Metadata.Builders;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eMekteb.Services.Seed
{
    public static class CasData
    {
        public static void SeedData(this EntityTypeBuilder<Cas> entity)
        {
            entity.HasData(
               new Cas
               {
                   Id = 1,
                   Datum = new DateTime(2022, 09, 12),
                   MektebId = 1,
                   AkademskaGodinaId = 1,
                   Razred = "I nivo",
                   Lekcija = "Rabbijesir"
               },
               new Cas
               {
                   Id = 2,
                   Datum = new DateTime(2022, 09, 13),
                   MektebId = 1,
                   AkademskaGodinaId = 1,
                   Razred = "I nivo",
                   Lekcija = "Subhaneke"
               },
               new Cas
               {
                   Id = 3,
                   Datum = new DateTime(2022, 09, 18),
                   MektebId = 1,
                   AkademskaGodinaId = 1,
                   Razred = "I nivo",
                   Lekcija = "Fatiha"
               },
               new Cas
               {
                   Id = 4,
                   Datum = new DateTime(2023, 09, 12),
                   MektebId = 1,
                   AkademskaGodinaId = 2,
                   Razred = "II nivo",
                   Lekcija = "Subhaneke"
               },
               new Cas
               {
                   Id = 5,
                   Datum = new DateTime(2023, 09, 13),
                   MektebId = 1,
                   AkademskaGodinaId = 2,
                   Razred = "II nivo",
                   Lekcija = "Krupno R"
               },
               new Cas
               {
                   Id = 6,
                   Datum = new DateTime(2023, 09, 18),
                   MektebId = 1,
                   AkademskaGodinaId = 2,
                   Razred = "II nivo",
                   Lekcija = "Ja Sin"
               },
               new Cas
               {
                   Id = 7,
                   Datum = new DateTime(2023, 09, 19),
                   MektebId = 1,
                   AkademskaGodinaId = 2,
                   Razred = "II nivo",
                   Lekcija = "Subhaneke"
               },
               new Cas
               {
                   Id = 8,
                   Datum = new DateTime(2024, 09, 12),
                   MektebId = 1,
                   AkademskaGodinaId = 3,
                   Razred = "III nivo",
                   Lekcija = "Podne namaz"
               },
               new Cas
               {
                   Id = 9,
                   Datum = new DateTime(2024, 09, 13),
                   MektebId = 1,
                   AkademskaGodinaId = 3,
                   Razred = "III nivo",
                   Lekcija = "Sabah namaz"
               },
               new Cas
               {
                   Id = 10,
                   Datum = new DateTime(2024, 09, 18),
                   MektebId = 1,
                   AkademskaGodinaId = 3,
                   Razred = "III nivo",
                   Lekcija = "Jacija namaz"
               },
               new Cas
               {
                   Id = 11,
                   Datum = new DateTime(2024, 09, 12),
                   MektebId = 2,
                   AkademskaGodinaId = 1,
                   Razred = "III nivo",
                   Lekcija = "Ja Sin"
               },
               new Cas
               {
                   Id = 12,
                   Datum = new DateTime(2024, 09, 12),
                   MektebId = 2,
                   AkademskaGodinaId = 2,
                   Razred = "II nivo",
                   Lekcija = "Rabbijesir"
               },
               new Cas
               {
                   Id = 13,
                   Datum = new DateTime(2024, 09, 12),
                   MektebId = 2,
                   AkademskaGodinaId = 3,
                   Razred = "II nivo",
                   Lekcija = "Subhaneke"
               },
               new Cas
               {
                   Id = 14,
                   Datum = new DateTime(2023, 09, 12),
                   MektebId = 3,
                   AkademskaGodinaId = 1,
                   Razred = "Sufara",
                   Lekcija = "Krupno R"
               },
               new Cas
               {
                   Id = 15,
                   Datum = new DateTime(2024, 09, 12),
                   MektebId = 3,
                   AkademskaGodinaId = 2,
                   Razred = "Sufara",
                   Lekcija = "Rabbijesir"
               },
               new Cas
               {
                   Id = 16,
                   Datum = new DateTime(2024, 09, 12),
                   MektebId = 3,
                   AkademskaGodinaId = 3,
                   Razred = "III nivo",
                   Lekcija = "Ja Sin"
               },
               new Cas
               {
                   Id = 17,
                   Datum = new DateTime(2023, 09, 12),
                   MektebId = 4,
                   AkademskaGodinaId = 2,
                   Razred = "III nivo",
                   Lekcija = "Subhaneke"
               },
               new Cas
               {
                   Id = 18,
                   Datum = new DateTime(2024, 09, 12),
                   MektebId = 4,
                   AkademskaGodinaId = 3,
                   Razred = "II nivo",
                   Lekcija = "Subhaneke"
               },
               new Cas
               {
                   Id = 19,
                   Datum = new DateTime(2024, 09, 12),
                   MektebId = 5,
                   AkademskaGodinaId = 3,
                   Razred = "Sufara",
                   Lekcija = "Fatiha"
               },
               new Cas
               {
                   Id = 20,
                   Datum = new DateTime(2024, 09, 12),
                   MektebId = 6,
                   AkademskaGodinaId = 3,
                   Razred = "Sufara",
                   Lekcija = "Ja Sin"
               },
               new Cas
               {
                   Id = 21,
                   Datum = new DateTime(2024, 09, 12),
                   MektebId = 6,
                   AkademskaGodinaId = 3,
                   Razred = "Hatma",
                   Lekcija = "Rabbijesir"
               }
            );
        }
    }
}
