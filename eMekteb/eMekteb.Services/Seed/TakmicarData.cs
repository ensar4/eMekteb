
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
                },
                new Takmicar
                {
                    Id = 13,
                    Ime = "Hasan",
                    Prezime = "Gološ",
                    DatumRodjenja = new DateTime(2000, 02, 01),
                    UkupnoBodova = 14,
                    KategorijaId = 1,
                },
                new Takmicar
                {
                    Id = 2,
                    Ime = "Zejd",
                    Prezime = "Marić",
                    DatumRodjenja = new DateTime(2001, 02, 01),
                    UkupnoBodova = 17,
                    KategorijaId = 2,
                },
                new Takmicar
                {
                    Id = 3,
                    Ime = "Sadzid",
                    Prezime = "Marić",
                    DatumRodjenja = new DateTime(2001, 02, 01),
                    UkupnoBodova = 15,
                    KategorijaId = 2,
                },
                new Takmicar
                {
                    Id = 4,
                    Ime = "Amna",
                    Prezime = "Baralija",
                    DatumRodjenja = new DateTime(2002, 02, 01),
                    UkupnoBodova = 17,
                    KategorijaId = 3,
                },
                new Takmicar
                {
                    Id = 5,
                    Ime = "Selma",
                    Prezime = "Bučuk",
                    DatumRodjenja = new DateTime(2002, 02, 01),
                    UkupnoBodova = 16,
                    KategorijaId = 3,
                },
                new Takmicar
                {
                    Id = 6,
                    Ime = "Kenan",
                    Prezime = "Baralija",
                    DatumRodjenja = new DateTime(2000, 02, 01),
                    UkupnoBodova = 15,
                    KategorijaId = 4,
                },
                new Takmicar
                {
                    Id = 7,
                    Ime = "Osman",
                    Prezime = "Brkan",
                    DatumRodjenja = new DateTime(2001, 02, 01),
                    UkupnoBodova = 14,
                    KategorijaId = 5,
                },
                new Takmicar
                {
                    Id = 8,
                    Ime = "Amar",
                    Prezime = "Brkan",
                    DatumRodjenja = new DateTime(2002, 02, 01),
                    UkupnoBodova = 13,
                    KategorijaId = 6,
                },
                new Takmicar
                {
                    Id = 9,
                    Ime = "Lejla",
                    Prezime = "Marić",
                    DatumRodjenja = new DateTime(2000, 02, 01),
                    UkupnoBodova = 0,
                    KategorijaId = 7,
                },
                new Takmicar
                {
                    Id = 10,
                    Ime = "Hasan",
                    Prezime = "Gološ",
                    DatumRodjenja = new DateTime(2000, 02, 01),
                    UkupnoBodova = 0,
                    KategorijaId = 7,
                },
                new Takmicar
                {
                    Id = 11,
                    Ime = "Zejd",
                    Prezime = "Marić",
                    DatumRodjenja = new DateTime(2001, 02, 01),
                    UkupnoBodova = 0,
                    KategorijaId = 8,
                },
                new Takmicar
                {
                    Id = 12,
                    Ime = "Sadzid",
                    Prezime = "Marić",
                    DatumRodjenja = new DateTime(2001, 02, 01),
                    UkupnoBodova = 0,
                    KategorijaId = 8,
                },
                new Takmicar
                {
                    Id = 20,
                    Ime = "Amna",
                    Prezime = "Baralija",
                    DatumRodjenja = new DateTime(2002, 02, 01),
                    UkupnoBodova = 0,
                    KategorijaId = 9,
                },
                new Takmicar
                {
                    Id = 14,
                    Ime = "Selma",
                    Prezime = "Bučuk",
                    DatumRodjenja = new DateTime(2002, 02, 01),
                    UkupnoBodova = 0,
                    KategorijaId = 9,
                },
                new Takmicar
                {
                    Id = 15,
                    Ime = "Kenan",
                    Prezime = "Baralija",
                    DatumRodjenja = new DateTime(2000, 02, 01),
                    UkupnoBodova = 0,
                    KategorijaId = 10,
                },
                new Takmicar
                {
                    Id = 16,
                    Ime = "Osman",
                    Prezime = "Brkan",
                    DatumRodjenja = new DateTime(2001, 02, 01),
                    UkupnoBodova = 0,
                    KategorijaId = 10,
                },
                new Takmicar
                {
                    Id = 17,
                    Ime = "Amar",
                    Prezime = "Brkan",
                    DatumRodjenja = new DateTime(2002, 02, 01),
                    UkupnoBodova = 0,
                    KategorijaId = 11,
                },
                new Takmicar
                {
                    Id = 18,
                    Ime = "Salih",
                    Prezime = "Marić",
                    DatumRodjenja = new DateTime(2002, 02, 01),
                    UkupnoBodova = 0,
                    KategorijaId = 12,
                },
                new Takmicar
                {
                    Id = 19,
                    Ime = "Ruvejda",
                    Prezime = "Kaminić",
                    DatumRodjenja = new DateTime(2000, 02, 01),
                    UkupnoBodova = 0,
                    KategorijaId = 7,
                }
            );
        }
    }
}
