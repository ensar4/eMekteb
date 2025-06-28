
using eMekteb.Services.Database;
using Microsoft.EntityFrameworkCore.Metadata.Builders;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eMekteb.Services.Seed
{
    public static class TakmicarData
    {
        public static void SeedData(this EntityTypeBuilder<Takmicar> entity)
        {
            entity.HasData(
                new Takmicar
                {
                    Id = 1,
                    Ime = "Lejla",
                    Prezime = "Marić",
                    DatumRodjenja = new DateTime(2000, 02, 01),
                    UkupnoBodova = 15,
                    KategorijaId = 1,
                    MektebId = 1,
                },
                new Takmicar
                {
                    Id = 13,
                    Ime = "Hasan",
                    Prezime = "Gološ",
                    DatumRodjenja = new DateTime(2000, 02, 01),
                    UkupnoBodova = 14,
                    KategorijaId = 1,
                    MektebId = 2,
                },
                new Takmicar
                {
                    Id = 2,
                    Ime = "Zejd",
                    Prezime = "Marić",
                    DatumRodjenja = new DateTime(2001, 02, 01),
                    UkupnoBodova = 17,
                    KategorijaId = 2,
                    MektebId = 3,
                },
                new Takmicar
                {
                    Id = 3,
                    Ime = "Sadzid",
                    Prezime = "Marić",
                    DatumRodjenja = new DateTime(2001, 02, 01),
                    UkupnoBodova = 15,
                    KategorijaId = 2,
                    MektebId = 1,
                },
                new Takmicar
                {
                    Id = 4,
                    Ime = "Amna",
                    Prezime = "Baralija",
                    DatumRodjenja = new DateTime(2002, 02, 01),
                    UkupnoBodova = 17,
                    KategorijaId = 3,
                    MektebId = 5,
                },
                new Takmicar
                {
                    Id = 5,
                    Ime = "Selma",
                    Prezime = "Bučuk",
                    DatumRodjenja = new DateTime(2002, 02, 01),
                    UkupnoBodova = 16,
                    KategorijaId = 3,
                    MektebId = 4,
                },
                new Takmicar
                {
                    Id = 6,
                    Ime = "Kenan",
                    Prezime = "Baralija",
                    DatumRodjenja = new DateTime(2000, 02, 01),
                    UkupnoBodova = 15,
                    KategorijaId = 4,
                    MektebId = 3,
                },
                new Takmicar
                {
                    Id = 7,
                    Ime = "Osman",
                    Prezime = "Brkan",
                    DatumRodjenja = new DateTime(2001, 02, 01),
                    UkupnoBodova = 14,
                    KategorijaId = 5,
                    MektebId = 3,
                },
                new Takmicar
                {
                    Id = 8,
                    Ime = "Amar",
                    Prezime = "Brkan",
                    DatumRodjenja = new DateTime(2002, 02, 01),
                    UkupnoBodova = 13,
                    KategorijaId = 6,
                    MektebId = 2,
                },
                new Takmicar
                {
                    Id = 9,
                    Ime = "Lejla",
                    Prezime = "Marić",
                    DatumRodjenja = new DateTime(2000, 02, 01),
                    UkupnoBodova = 14,
                    KategorijaId = 7,
                    MektebId = 1,
                },
                new Takmicar
                {
                    Id = 10,
                    Ime = "Hasan",
                    Prezime = "Gološ",
                    DatumRodjenja = new DateTime(2000, 02, 01),
                    UkupnoBodova = 15,
                    KategorijaId = 7,
                    MektebId = 2,
                },
                new Takmicar
                {
                    Id = 11,
                    Ime = "Zejd",
                    Prezime = "Marić",
                    DatumRodjenja = new DateTime(2001, 02, 01),
                    UkupnoBodova = 16,
                    KategorijaId = 8,
                    MektebId = 3,
                },
                new Takmicar
                {
                    Id = 12,
                    Ime = "Sadzid",
                    Prezime = "Marić",
                    DatumRodjenja = new DateTime(2001, 02, 01),
                    UkupnoBodova = 17,
                    KategorijaId = 8,
                    MektebId = 1,
                },
                new Takmicar
                {
                    Id = 20,
                    Ime = "Amna",
                    Prezime = "Baralija",
                    DatumRodjenja = new DateTime(2002, 02, 01),
                    UkupnoBodova = 14,
                    KategorijaId = 9,
                    MektebId = 4,
                },
                new Takmicar
                {
                    Id = 14,
                    Ime = "Selma",
                    Prezime = "Bučuk",
                    DatumRodjenja = new DateTime(2002, 02, 01),
                    UkupnoBodova = 15,
                    KategorijaId = 9,
                    MektebId = 5,
                },
                new Takmicar
                {
                    Id = 15,
                    Ime = "Kenan",
                    Prezime = "Baralija",
                    DatumRodjenja = new DateTime(2000, 02, 01),
                    UkupnoBodova = 16,
                    KategorijaId = 10,
                    MektebId = 2,
                },
                new Takmicar
                {
                    Id = 16,
                    Ime = "Osman",
                    Prezime = "Brkan",
                    DatumRodjenja = new DateTime(2001, 02, 01),
                    UkupnoBodova = 14,
                    KategorijaId = 10,
                    MektebId = 3,
                },
                new Takmicar
                {
                    Id = 17,
                    Ime = "Amar",
                    Prezime = "Brkan",
                    DatumRodjenja = new DateTime(2002, 02, 01),
                    UkupnoBodova = 15,
                    KategorijaId = 11,
                    MektebId = 3,
                },
                new Takmicar
                {
                    Id = 18,
                    Ime = "Salih",
                    Prezime = "Marić",
                    DatumRodjenja = new DateTime(2002, 02, 01),
                    UkupnoBodova = 11,
                    KategorijaId = 12,
                    MektebId = 3,
                },
                new Takmicar
                {
                    Id = 19,
                    Ime = "Ruvejda",
                    Prezime = "Kaminić",
                    DatumRodjenja = new DateTime(2000, 02, 01),
                    UkupnoBodova = 12,
                    KategorijaId = 7,
                    MektebId = 5,
                },
                new Takmicar
                {
                    Id = 35,
                    Ime = "Selma",
                    Prezime = "Čavčić",
                    DatumRodjenja = new DateTime(2000, 02, 01),
                    UkupnoBodova = 12,
                    KategorijaId = 7,
                    MektebId = 5,
                },
                new Takmicar
                {
                    Id = 21,
                    Ime = "Ejla",
                    Prezime = "Kodrić",
                    DatumRodjenja = new DateTime(2000, 02, 01),
                    UkupnoBodova = 12,
                    KategorijaId = 7,
                    MektebId = 5,
                },
                new Takmicar
                {
                    Id = 22,
                    Ime = "Amna",
                    Prezime = "Hasić",
                    DatumRodjenja = new DateTime(2000, 02, 01),
                    UkupnoBodova = 12,
                    KategorijaId = 7,
                    MektebId = 5,
                },
                new Takmicar
                {
                    Id = 23,
                    Ime = "Sanela",
                    Prezime = "Čevra",
                    DatumRodjenja = new DateTime(2000, 02, 01),
                    UkupnoBodova = 12,
                    KategorijaId = 7,
                    MektebId = 5,
                },
                new Takmicar
                {
                    Id = 24,
                    Ime = "Sajra",
                    Prezime = "Penava",
                    DatumRodjenja = new DateTime(2000, 02, 01),
                    UkupnoBodova = 16,
                    KategorijaId = 7,
                    MektebId = 5,
                },
                new Takmicar
                {
                    Id = 25,
                    Ime = "Emina",
                    Prezime = "Gosto",
                    DatumRodjenja = new DateTime(2000, 02, 01),
                    UkupnoBodova = 17,
                    KategorijaId = 7,
                    MektebId = 5,
                },
                new Takmicar
                {
                    Id = 26,
                    Ime = "Emela",
                    Prezime = "Karadža",
                    DatumRodjenja = new DateTime(2000, 02, 01),
                    UkupnoBodova = 18,
                    KategorijaId = 7,
                    MektebId = 5,
                },
                new Takmicar
                {
                    Id = 27,
                    Ime = "Ela",
                    Prezime = "Memić",
                    DatumRodjenja = new DateTime(2000, 02, 01),
                    UkupnoBodova = 13,
                    KategorijaId = 7,
                    MektebId = 13,
                },
                new Takmicar
                {
                    Id = 28,
                    Ime = "Enisa",
                    Prezime = "Mulać",
                    DatumRodjenja = new DateTime(2000, 02, 01),
                    UkupnoBodova = 15,
                    KategorijaId = 7,
                    MektebId = 12,
                },
                new Takmicar
                {
                    Id = 29,
                    Ime = "Zijada",
                    Prezime = "Mustafić",
                    DatumRodjenja = new DateTime(2000, 02, 01),
                    UkupnoBodova = 19,
                    KategorijaId = 7,
                    MektebId = 11,
                },
                new Takmicar
                {
                    Id = 30,
                    Ime = "Ilhana",
                    Prezime = "Mahinić",
                    DatumRodjenja = new DateTime(2000, 02, 01),
                    UkupnoBodova = 18,
                    KategorijaId = 7,
                    MektebId = 10,
                },
                new Takmicar
                {
                    Id = 31,
                    Ime = "Ilma",
                    Prezime = "Merzić",
                    DatumRodjenja = new DateTime(2000, 02, 01),
                    UkupnoBodova = 17,
                    KategorijaId = 7,
                    MektebId = 9,
                },
                new Takmicar
                {
                    Id = 32,
                    Ime = "Inela",
                    Prezime = "Maksumić",
                    DatumRodjenja = new DateTime(2000, 02, 01),
                    UkupnoBodova = 15,
                    KategorijaId = 7,
                    MektebId = 8,
                },
                new Takmicar
                {
                    Id = 33,
                    Ime = "Irnela",
                    Prezime = "Memić",
                    DatumRodjenja = new DateTime(2000, 02, 01),
                    UkupnoBodova = 13,
                    KategorijaId = 7,
                    MektebId = 7,
                },
                new Takmicar
                {
                    Id = 34,
                    Ime = "Ismihana",
                    Prezime = "Marić",
                    DatumRodjenja = new DateTime(2000, 02, 01),
                    UkupnoBodova = 14,
                    KategorijaId = 7,
                    MektebId = 6,
                }
            );
        }
    }
}
