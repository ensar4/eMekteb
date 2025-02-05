using System;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace eMekteb.Services.Migrations
{
    /// <inheritdoc />
    public partial class fixSeed5 : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.InsertData(
                table: "Korisnik",
                columns: new[] { "Id", "DatumRodjenja", "IdRazreda", "Ime", "ImeRoditelja", "LozinkaHash", "LozinkaSalt", "Mail", "MedzlisId", "MektebId", "MuftijstvoId", "NazivRazreda", "Prezime", "Prisustvo", "Prosjek", "RazredId", "RoditeljId", "Spol", "Status", "Telefon", "Username" },
                values: new object[] { 42, new DateTime(1954, 9, 12, 0, 0, 0, 0, DateTimeKind.Unspecified), null, "Nedzad", "Omer", "dP9XoZcTTTU8f4ddDbNLJalRQqQ=", "jmK1d1xnmg2DC0svh3UvRw==", "superadmin@gmail.com", null, 6, 2, null, "Grabus", null, null, null, null, "M", "Aktivan", "061222555", "sarajevo" });
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DeleteData(
                table: "Korisnik",
                keyColumn: "Id",
                keyValue: 42);
        }
    }
}
