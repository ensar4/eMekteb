using System;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

#pragma warning disable CA1814 // Prefer jagged arrays over multidimensional

namespace eMekteb.Services.Migrations
{
    /// <inheritdoc />
    public partial class addedTakmicarsMektebAndSeedFix : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.AddColumn<int>(
                name: "MektebId",
                table: "Takmicar",
                type: "int",
                nullable: true);

            migrationBuilder.InsertData(
                table: "Korisnik",
                columns: new[] { "Id", "DatumRodjenja", "IdRazreda", "Ime", "ImeRoditelja", "LozinkaHash", "LozinkaSalt", "Mail", "MedzlisId", "MektebId", "MuftijstvoId", "NazivRazreda", "Prezime", "Prisustvo", "Prosjek", "RazredId", "RoditeljId", "Spol", "Status", "Telefon", "Username" },
                values: new object[,]
                {
                    { 39, new DateTime(1954, 9, 12, 0, 0, 0, 0, DateTimeKind.Unspecified), null, "Sefko", "Omer", "dP9XoZcTTTU8f4ddDbNLJalRQqQ=", "jmK1d1xnmg2DC0svh3UvRw==", "muftija@gmail.com", null, 6, 1, null, "Tinjak", null, null, null, null, "M", "Aktivan", "061222555", "muftija" },
                    { 40, new DateTime(1954, 9, 12, 0, 0, 0, 0, DateTimeKind.Unspecified), null, "Kenan", "Omer", "dP9XoZcTTTU8f4ddDbNLJalRQqQ=", "jmK1d1xnmg2DC0svh3UvRw==", "zamjenik@gmail.com", 1, 6, null, null, "Ovcina", null, null, null, null, "M", "Aktivan", "061222555", "zamjenik" }
                });

            migrationBuilder.UpdateData(
                table: "Takmicar",
                keyColumn: "Id",
                keyValue: 1,
                column: "MektebId",
                value: 1);

            migrationBuilder.UpdateData(
                table: "Takmicar",
                keyColumn: "Id",
                keyValue: 2,
                column: "MektebId",
                value: 3);

            migrationBuilder.UpdateData(
                table: "Takmicar",
                keyColumn: "Id",
                keyValue: 3,
                column: "MektebId",
                value: 1);

            migrationBuilder.UpdateData(
                table: "Takmicar",
                keyColumn: "Id",
                keyValue: 4,
                column: "MektebId",
                value: 5);

            migrationBuilder.UpdateData(
                table: "Takmicar",
                keyColumn: "Id",
                keyValue: 5,
                column: "MektebId",
                value: 4);

            migrationBuilder.UpdateData(
                table: "Takmicar",
                keyColumn: "Id",
                keyValue: 6,
                column: "MektebId",
                value: 3);

            migrationBuilder.UpdateData(
                table: "Takmicar",
                keyColumn: "Id",
                keyValue: 7,
                column: "MektebId",
                value: 3);

            migrationBuilder.UpdateData(
                table: "Takmicar",
                keyColumn: "Id",
                keyValue: 8,
                column: "MektebId",
                value: 2);

            migrationBuilder.UpdateData(
                table: "Takmicar",
                keyColumn: "Id",
                keyValue: 9,
                column: "MektebId",
                value: 1);

            migrationBuilder.UpdateData(
                table: "Takmicar",
                keyColumn: "Id",
                keyValue: 10,
                column: "MektebId",
                value: 2);

            migrationBuilder.UpdateData(
                table: "Takmicar",
                keyColumn: "Id",
                keyValue: 11,
                column: "MektebId",
                value: 3);

            migrationBuilder.UpdateData(
                table: "Takmicar",
                keyColumn: "Id",
                keyValue: 12,
                column: "MektebId",
                value: 1);

            migrationBuilder.UpdateData(
                table: "Takmicar",
                keyColumn: "Id",
                keyValue: 13,
                column: "MektebId",
                value: 2);

            migrationBuilder.UpdateData(
                table: "Takmicar",
                keyColumn: "Id",
                keyValue: 14,
                column: "MektebId",
                value: 5);

            migrationBuilder.UpdateData(
                table: "Takmicar",
                keyColumn: "Id",
                keyValue: 15,
                column: "MektebId",
                value: 2);

            migrationBuilder.UpdateData(
                table: "Takmicar",
                keyColumn: "Id",
                keyValue: 16,
                column: "MektebId",
                value: 3);

            migrationBuilder.UpdateData(
                table: "Takmicar",
                keyColumn: "Id",
                keyValue: 17,
                column: "MektebId",
                value: 3);

            migrationBuilder.UpdateData(
                table: "Takmicar",
                keyColumn: "Id",
                keyValue: 18,
                column: "MektebId",
                value: 3);

            migrationBuilder.UpdateData(
                table: "Takmicar",
                keyColumn: "Id",
                keyValue: 19,
                column: "MektebId",
                value: 5);

            migrationBuilder.UpdateData(
                table: "Takmicar",
                keyColumn: "Id",
                keyValue: 20,
                column: "MektebId",
                value: 4);

            migrationBuilder.InsertData(
                table: "KorisniciUloge",
                columns: new[] { "Id", "DatumIzmjene", "KorisnikId", "UlogaId" },
                values: new object[] { 39, new DateTime(2024, 8, 20, 0, 0, 0, 0, DateTimeKind.Unspecified), 39, 6 });

            migrationBuilder.CreateIndex(
                name: "IX_Takmicar_MektebId",
                table: "Takmicar",
                column: "MektebId");

            migrationBuilder.AddForeignKey(
                name: "FK_Takmicar_Mekteb_MektebId",
                table: "Takmicar",
                column: "MektebId",
                principalTable: "Mekteb",
                principalColumn: "Id");
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_Takmicar_Mekteb_MektebId",
                table: "Takmicar");

            migrationBuilder.DropIndex(
                name: "IX_Takmicar_MektebId",
                table: "Takmicar");

            migrationBuilder.DeleteData(
                table: "KorisniciUloge",
                keyColumn: "Id",
                keyValue: 39);

            migrationBuilder.DeleteData(
                table: "Korisnik",
                keyColumn: "Id",
                keyValue: 40);

            migrationBuilder.DeleteData(
                table: "Korisnik",
                keyColumn: "Id",
                keyValue: 39);

            migrationBuilder.DropColumn(
                name: "MektebId",
                table: "Takmicar");
        }
    }
}
