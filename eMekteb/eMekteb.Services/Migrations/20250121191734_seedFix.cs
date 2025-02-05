using System;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace eMekteb.Services.Migrations
{
    /// <inheritdoc />
    public partial class seedFix : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.InsertData(
                table: "KorisniciUloge",
                columns: new[] { "Id", "DatumIzmjene", "KorisnikId", "UlogaId" },
                values: new object[] { 40, new DateTime(2024, 8, 20, 0, 0, 0, 0, DateTimeKind.Unspecified), 39, 1 });

            migrationBuilder.UpdateData(
                table: "Korisnik",
                keyColumn: "Id",
                keyValue: 1,
                column: "MedzlisId",
                value: 1);
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DeleteData(
                table: "KorisniciUloge",
                keyColumn: "Id",
                keyValue: 40);

            migrationBuilder.UpdateData(
                table: "Korisnik",
                keyColumn: "Id",
                keyValue: 1,
                column: "MedzlisId",
                value: null);
        }
    }
}
