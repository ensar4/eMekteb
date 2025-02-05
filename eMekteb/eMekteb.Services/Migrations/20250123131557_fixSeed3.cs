using System;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace eMekteb.Services.Migrations
{
    /// <inheritdoc />
    public partial class fixSeed3 : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.InsertData(
                table: "Muftijstvo",
                columns: new[] { "Id", "Adresa", "Mail", "Naziv", "Telefon" },
                values: new object[] { 2, "Čiče Miličevića, Sarajevo 88000", "muftijstvosarajevo@gmail.com", "Muftijstvo Sarajevsko", "036 550-727" });

            migrationBuilder.InsertData(
                table: "Medzlis",
                columns: new[] { "Id", "Adresa", "Mail", "MuftijstvoId", "Naziv", "Telefon" },
                values: new object[] { 2, "Čiče Miličevića, Sarajevo 88000", "medzlisdarajevo@gmail.com", 2, "Medzlis Sarajevo", "036 550-727" });

            migrationBuilder.InsertData(
                table: "Mekteb",
                columns: new[] { "Id", "Adresa", "MedzlisId", "Naziv", "Telefon" },
                values: new object[] { 17, "Sarajevo", 2, "Mekteb Alipasino C", "036 585-965" });

            migrationBuilder.InsertData(
                table: "Korisnik",
                columns: new[] { "Id", "DatumRodjenja", "IdRazreda", "Ime", "ImeRoditelja", "LozinkaHash", "LozinkaSalt", "Mail", "MedzlisId", "MektebId", "MuftijstvoId", "NazivRazreda", "Prezime", "Prisustvo", "Prosjek", "RazredId", "RoditeljId", "Spol", "Status", "Telefon", "Username" },
                values: new object[] { 41, new DateTime(1954, 9, 12, 0, 0, 0, 0, DateTimeKind.Unspecified), null, "Kenan", "Omer", "dP9XoZcTTTU8f4ddDbNLJalRQqQ=", "jmK1d1xnmg2DC0svh3UvRw==", "zamjenik@gmail.com", 2, 17, null, null, "Music", null, null, null, null, "M", "Aktivan", "061222555", "kenan.music" });

            migrationBuilder.InsertData(
                table: "KorisniciUloge",
                columns: new[] { "Id", "DatumIzmjene", "KorisnikId", "UlogaId" },
                values: new object[] { 41, new DateTime(2024, 8, 20, 0, 0, 0, 0, DateTimeKind.Unspecified), 41, 1 });
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DeleteData(
                table: "KorisniciUloge",
                keyColumn: "Id",
                keyValue: 41);

            migrationBuilder.DeleteData(
                table: "Korisnik",
                keyColumn: "Id",
                keyValue: 41);

            migrationBuilder.DeleteData(
                table: "Mekteb",
                keyColumn: "Id",
                keyValue: 17);

            migrationBuilder.DeleteData(
                table: "Medzlis",
                keyColumn: "Id",
                keyValue: 2);

            migrationBuilder.DeleteData(
                table: "Muftijstvo",
                keyColumn: "Id",
                keyValue: 2);
        }
    }
}
