
using eMekteb.Services.Database;
using Microsoft.EntityFrameworkCore.Metadata.Builders;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eMekteb.Services.Seed
{
    public static class ObavijestData
    {
        public static void SeedData(this EntityTypeBuilder<Obavijest> entity)
        {
            entity.HasData(
                new Obavijest
                {
                    Id = 1,
                    Naslov = "eMekteb aplikacija ",
                    Opis = "Dobrodošli na novu platformu za mektebsku nastavu, nadamo se da cete uzivati u koristenju i da će vam koristiti u sticanju korisnog znanja. \r\nHairli vam bila nova mektebska godina!",
                    DatumObjave = new DateTime(2024, 09, 12),
                    VrstaObjave = "Obavijest",
                    MektebId = 1,
                    StateMachine = "active"
                },
                new Obavijest
                {
                    Id = 2,
                    Naslov = "Promijeni password!",
                    Opis= "Radi sigurnosti i pristupa aplikaciji napravite novi password.",
                    DatumObjave = new DateTime(2024, 09, 12),
                    VrstaObjave = "Obavijest",
                    MektebId = 1,
                    StateMachine = "active"
                },        
                new Obavijest
                {
                    Id = 3,
                    Naslov = "eMekteb aplikacija ",
                    Opis = "Dobrodošli na novu platformu za mektebsku nastavu, nadamo se da cete uzivati u koristenju i da će vam koristiti u sticanju korisnog znanja. \r\nHairli vam bila nova mektebska godina!",
                    DatumObjave = new DateTime(2024, 09, 12),
                    VrstaObjave = "Obavijest",
                    MektebId = 2,
                    StateMachine = "active"
                },
                new Obavijest
                {
                    Id = 4,
                    Naslov = "Promijeni password!",
                    Opis= "Radi sigurnosti i pristupa aplikaciji napravite novi password.",
                    DatumObjave = new DateTime(2024, 09, 12),
                    VrstaObjave = "Obavijest",
                    MektebId = 2,
                    StateMachine = "active"
                },        
                new Obavijest
                {
                    Id = 5,
                    Naslov = "eMekteb aplikacija ",
                    Opis = "Dobrodošli na novu platformu za mektebsku nastavu, nadamo se da cete uzivati u koristenju i da će vam koristiti u sticanju korisnog znanja. \r\nHairli vam bila nova mektebska godina!",
                    DatumObjave = new DateTime(2024, 09, 12),
                    VrstaObjave = "Obavijest",
                    MektebId = 3,
                    StateMachine = "active"
                },
                new Obavijest
                {
                    Id = 6,
                    Naslov = "Promijeni password!",
                    Opis= "Radi sigurnosti i pristupa aplikaciji napravite novi password.",
                    DatumObjave = new DateTime(2024, 09, 12),
                    VrstaObjave = "Obavijest",
                    MektebId = 3,
                    StateMachine = "active"
                },        
                new Obavijest
                {
                    Id = 7,
                    Naslov = "eMekteb aplikacija ",
                    Opis = "Dobrodošli na novu platformu za mektebsku nastavu, nadamo se da cete uzivati u koristenju i da će vam koristiti u sticanju korisnog znanja. \r\nHairli vam bila nova mektebska godina!",
                    DatumObjave = new DateTime(2024, 09, 12),
                    VrstaObjave = "Obavijest",
                    MektebId = 4,
                    StateMachine = "active"
                },
                new Obavijest
                {
                    Id = 8,
                    Naslov = "Promijeni password!",
                    Opis= "Radi sigurnosti i pristupa aplikaciji napravite novi password.",
                    DatumObjave = new DateTime(2024, 09, 12),
                    VrstaObjave = "Obavijest",
                    MektebId = 4,
                    StateMachine = "active"
                },        
                new Obavijest
                {
                    Id = 9,
                    Naslov = "eMekteb aplikacija ",
                    Opis = "Dobrodošli na novu platformu za mektebsku nastavu, nadamo se da cete uzivati u koristenju i da će vam koristiti u sticanju korisnog znanja. \r\nHairli vam bila nova mektebska godina!",
                    DatumObjave = new DateTime(2024, 09, 12),
                    VrstaObjave = "Obavijest",
                    MektebId = 5,
                    StateMachine = "active"
                },
                new Obavijest
                {
                    Id = 10,
                    Naslov = "Promijeni password!",
                    Opis= "Radi sigurnosti i pristupa aplikaciji napravite novi password.",
                    DatumObjave = new DateTime(2024, 09, 12),
                    VrstaObjave = "Obavijest",
                    MektebId = 5,
                    StateMachine = "active"
                },        
                new Obavijest
                {
                    Id = 11,
                    Naslov = "eMekteb aplikacija ",
                    Opis = "Dobrodošli na novu platformu za mektebsku nastavu, nadamo se da cete uzivati u koristenju i da će vam koristiti u sticanju korisnog znanja. \r\nHairli vam bila nova mektebska godina!",
                    DatumObjave = new DateTime(2024, 09, 12),
                    VrstaObjave = "Obavijest",
                    MektebId = 6,
                    StateMachine = "active"
                },
                new Obavijest
                {
                    Id = 12,
                    Naslov = "Promijeni password!",
                    Opis= "Radi sigurnosti i pristupa aplikaciji napravite novi password.",
                    DatumObjave = new DateTime(2024, 09, 12),
                    VrstaObjave = "Obavijest",
                    MektebId = 6,
                    StateMachine = "active"
                }
            );
        }
    }
}
