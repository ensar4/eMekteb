using System;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

#pragma warning disable CA1814 // Prefer jagged arrays over multidimensional

namespace eMekteb.Services.Migrations
{
    /// <inheritdoc />
    public partial class fixSeed7 : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.InsertData(
                table: "Takmicar",
                columns: new[] { "Id", "DatumRodjenja", "Ime", "KategorijaId", "MektebId", "Prezime", "UkupnoBodova" },
                values: new object[,]
                {
                    { 21, new DateTime(2000, 2, 1, 0, 0, 0, 0, DateTimeKind.Unspecified), "Ejla", 7, 5, "Kodrić", 12 },
                    { 22, new DateTime(2000, 2, 1, 0, 0, 0, 0, DateTimeKind.Unspecified), "Amna", 7, 5, "Hasić", 12 },
                    { 23, new DateTime(2000, 2, 1, 0, 0, 0, 0, DateTimeKind.Unspecified), "Sanela", 7, 5, "Čevra", 12 },
                    { 24, new DateTime(2000, 2, 1, 0, 0, 0, 0, DateTimeKind.Unspecified), "Sajra", 7, 5, "Penava", 16 },
                    { 25, new DateTime(2000, 2, 1, 0, 0, 0, 0, DateTimeKind.Unspecified), "Emina", 7, 5, "Gosto", 17 },
                    { 26, new DateTime(2000, 2, 1, 0, 0, 0, 0, DateTimeKind.Unspecified), "Emela", 7, 5, "Karadža", 18 },
                    { 27, new DateTime(2000, 2, 1, 0, 0, 0, 0, DateTimeKind.Unspecified), "Ela", 7, 13, "Memić", 13 },
                    { 28, new DateTime(2000, 2, 1, 0, 0, 0, 0, DateTimeKind.Unspecified), "Enisa", 7, 12, "Mulać", 15 },
                    { 29, new DateTime(2000, 2, 1, 0, 0, 0, 0, DateTimeKind.Unspecified), "Zijada", 7, 11, "Mustafić", 19 },
                    { 30, new DateTime(2000, 2, 1, 0, 0, 0, 0, DateTimeKind.Unspecified), "Ilhana", 7, 10, "Mahinić", 18 },
                    { 31, new DateTime(2000, 2, 1, 0, 0, 0, 0, DateTimeKind.Unspecified), "Ilma", 7, 9, "Merzić", 17 },
                    { 32, new DateTime(2000, 2, 1, 0, 0, 0, 0, DateTimeKind.Unspecified), "Inela", 7, 8, "Maksumić", 15 },
                    { 33, new DateTime(2000, 2, 1, 0, 0, 0, 0, DateTimeKind.Unspecified), "Irnela", 7, 7, "Memić", 13 },
                    { 34, new DateTime(2000, 2, 1, 0, 0, 0, 0, DateTimeKind.Unspecified), "Ismihana", 7, 6, "Marić", 14 },
                    { 35, new DateTime(2000, 2, 1, 0, 0, 0, 0, DateTimeKind.Unspecified), "Selma", 7, 5, "Čavčić", 12 }
                });
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DeleteData(
                table: "Takmicar",
                keyColumn: "Id",
                keyValue: 21);

            migrationBuilder.DeleteData(
                table: "Takmicar",
                keyColumn: "Id",
                keyValue: 22);

            migrationBuilder.DeleteData(
                table: "Takmicar",
                keyColumn: "Id",
                keyValue: 23);

            migrationBuilder.DeleteData(
                table: "Takmicar",
                keyColumn: "Id",
                keyValue: 24);

            migrationBuilder.DeleteData(
                table: "Takmicar",
                keyColumn: "Id",
                keyValue: 25);

            migrationBuilder.DeleteData(
                table: "Takmicar",
                keyColumn: "Id",
                keyValue: 26);

            migrationBuilder.DeleteData(
                table: "Takmicar",
                keyColumn: "Id",
                keyValue: 27);

            migrationBuilder.DeleteData(
                table: "Takmicar",
                keyColumn: "Id",
                keyValue: 28);

            migrationBuilder.DeleteData(
                table: "Takmicar",
                keyColumn: "Id",
                keyValue: 29);

            migrationBuilder.DeleteData(
                table: "Takmicar",
                keyColumn: "Id",
                keyValue: 30);

            migrationBuilder.DeleteData(
                table: "Takmicar",
                keyColumn: "Id",
                keyValue: 31);

            migrationBuilder.DeleteData(
                table: "Takmicar",
                keyColumn: "Id",
                keyValue: 32);

            migrationBuilder.DeleteData(
                table: "Takmicar",
                keyColumn: "Id",
                keyValue: 33);

            migrationBuilder.DeleteData(
                table: "Takmicar",
                keyColumn: "Id",
                keyValue: 34);

            migrationBuilder.DeleteData(
                table: "Takmicar",
                keyColumn: "Id",
                keyValue: 35);
        }
    }
}
