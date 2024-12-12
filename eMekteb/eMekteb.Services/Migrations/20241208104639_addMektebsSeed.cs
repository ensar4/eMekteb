using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

#pragma warning disable CA1814 // Prefer jagged arrays over multidimensional

namespace eMekteb.Services.Migrations
{
    /// <inheritdoc />
    public partial class addMektebsSeed : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.InsertData(
                table: "Mekteb",
                columns: new[] { "Id", "Adresa", "MedzlisId", "Naziv", "Telefon" },
                values: new object[,]
                {
                    { 7, "Mostar", 1, "Mekteb Zalik 2", "036 585-967" },
                    { 8, "Mostar", 1, "Mekteb Luka 2", "036 585-963" },
                    { 9, "Mostar", 1, "Mekteb Ričina", "036 585-962" },
                    { 10, "Mostar", 1, "Mekteb Podhum", "036 585-961" },
                    { 11, "Mostar", 1, "Mekteb Pijesak", "036 585-965" },
                    { 12, "Mostar", 1, "Mekteb Balinovac", "036 585-961" },
                    { 13, "Mostar", 1, "Mekteb Jasenica", "036 585-965" },
                    { 14, "Mostar", 1, "Mekteb Kočine", "036 585-961" },
                    { 15, "Mostar", 1, "Mekteb Brankovac", "036 585-965" }
                });
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DeleteData(
                table: "Mekteb",
                keyColumn: "Id",
                keyValue: 7);

            migrationBuilder.DeleteData(
                table: "Mekteb",
                keyColumn: "Id",
                keyValue: 8);

            migrationBuilder.DeleteData(
                table: "Mekteb",
                keyColumn: "Id",
                keyValue: 9);

            migrationBuilder.DeleteData(
                table: "Mekteb",
                keyColumn: "Id",
                keyValue: 10);

            migrationBuilder.DeleteData(
                table: "Mekteb",
                keyColumn: "Id",
                keyValue: 11);

            migrationBuilder.DeleteData(
                table: "Mekteb",
                keyColumn: "Id",
                keyValue: 12);

            migrationBuilder.DeleteData(
                table: "Mekteb",
                keyColumn: "Id",
                keyValue: 13);

            migrationBuilder.DeleteData(
                table: "Mekteb",
                keyColumn: "Id",
                keyValue: 14);

            migrationBuilder.DeleteData(
                table: "Mekteb",
                keyColumn: "Id",
                keyValue: 15);
        }
    }
}
