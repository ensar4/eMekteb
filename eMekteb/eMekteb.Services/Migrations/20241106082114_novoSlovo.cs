using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace eMekteb.Services.Migrations
{
    /// <inheritdoc />
    public partial class novoSlovo : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.RenameColumn(
                name: "VrijemePočetka",
                table: "Takmicenje",
                newName: "VrijemePocetka");

            migrationBuilder.UpdateData(
                table: "Korisnik",
                keyColumn: "Id",
                keyValue: 4,
                columns: new[] { "LozinkaHash", "LozinkaSalt" },
                values: new object[] { "AtSGH/z7qvkVdWoRnHgpVjtiw+M=", "XPD7niYAxH0Rify963NJDA==" });

            migrationBuilder.UpdateData(
                table: "Korisnik",
                keyColumn: "Id",
                keyValue: 33,
                columns: new[] { "Prezime", "Username" },
                values: new object[] { "Hasić", "muhamed.hasic" });

            migrationBuilder.UpdateData(
                table: "Razred",
                keyColumn: "Id",
                keyValue: 5,
                column: "Naziv",
                value: "Tedžvid");

            migrationBuilder.UpdateData(
                table: "Razred",
                keyColumn: "Id",
                keyValue: 11,
                column: "Naziv",
                value: "Tedžvid");

            migrationBuilder.UpdateData(
                table: "Razred",
                keyColumn: "Id",
                keyValue: 17,
                column: "Naziv",
                value: "Tedžvid");

            migrationBuilder.UpdateData(
                table: "Razred",
                keyColumn: "Id",
                keyValue: 23,
                column: "Naziv",
                value: "Tedžvid");

            migrationBuilder.UpdateData(
                table: "Razred",
                keyColumn: "Id",
                keyValue: 29,
                column: "Naziv",
                value: "Tedžvid");

            migrationBuilder.UpdateData(
                table: "Razred",
                keyColumn: "Id",
                keyValue: 35,
                column: "Naziv",
                value: "Tedžvid");

            migrationBuilder.UpdateData(
                table: "Takmicar",
                keyColumn: "Id",
                keyValue: 9,
                column: "UkupnoBodova",
                value: 14);

            migrationBuilder.UpdateData(
                table: "Takmicar",
                keyColumn: "Id",
                keyValue: 10,
                column: "UkupnoBodova",
                value: 15);

            migrationBuilder.UpdateData(
                table: "Takmicar",
                keyColumn: "Id",
                keyValue: 11,
                column: "UkupnoBodova",
                value: 16);

            migrationBuilder.UpdateData(
                table: "Takmicar",
                keyColumn: "Id",
                keyValue: 12,
                column: "UkupnoBodova",
                value: 17);

            migrationBuilder.UpdateData(
                table: "Takmicar",
                keyColumn: "Id",
                keyValue: 14,
                column: "UkupnoBodova",
                value: 15);

            migrationBuilder.UpdateData(
                table: "Takmicar",
                keyColumn: "Id",
                keyValue: 15,
                column: "UkupnoBodova",
                value: 16);

            migrationBuilder.UpdateData(
                table: "Takmicar",
                keyColumn: "Id",
                keyValue: 16,
                column: "UkupnoBodova",
                value: 14);

            migrationBuilder.UpdateData(
                table: "Takmicar",
                keyColumn: "Id",
                keyValue: 17,
                column: "UkupnoBodova",
                value: 15);

            migrationBuilder.UpdateData(
                table: "Takmicar",
                keyColumn: "Id",
                keyValue: 18,
                column: "UkupnoBodova",
                value: 11);

            migrationBuilder.UpdateData(
                table: "Takmicar",
                keyColumn: "Id",
                keyValue: 19,
                column: "UkupnoBodova",
                value: 12);

            migrationBuilder.UpdateData(
                table: "Takmicar",
                keyColumn: "Id",
                keyValue: 20,
                column: "UkupnoBodova",
                value: 14);
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.RenameColumn(
                name: "VrijemePocetka",
                table: "Takmicenje",
                newName: "VrijemePočetka");

            migrationBuilder.UpdateData(
                table: "Korisnik",
                keyColumn: "Id",
                keyValue: 4,
                columns: new[] { "LozinkaHash", "LozinkaSalt" },
                values: new object[] { "AM3voFixj70K2UEq0c+7KnPEoaU=", "jmK1d1xnmg2DC0svh3UvRw==" });

            migrationBuilder.UpdateData(
                table: "Korisnik",
                keyColumn: "Id",
                keyValue: 33,
                columns: new[] { "Prezime", "Username" },
                values: new object[] { "Crnomerović", "muhamed.crnomerovic" });

            migrationBuilder.UpdateData(
                table: "Razred",
                keyColumn: "Id",
                keyValue: 5,
                column: "Naziv",
                value: "Tedzvid");

            migrationBuilder.UpdateData(
                table: "Razred",
                keyColumn: "Id",
                keyValue: 11,
                column: "Naziv",
                value: "Tedzvid");

            migrationBuilder.UpdateData(
                table: "Razred",
                keyColumn: "Id",
                keyValue: 17,
                column: "Naziv",
                value: "Tedzvid");

            migrationBuilder.UpdateData(
                table: "Razred",
                keyColumn: "Id",
                keyValue: 23,
                column: "Naziv",
                value: "Tedzvid");

            migrationBuilder.UpdateData(
                table: "Razred",
                keyColumn: "Id",
                keyValue: 29,
                column: "Naziv",
                value: "Tedzvid");

            migrationBuilder.UpdateData(
                table: "Razred",
                keyColumn: "Id",
                keyValue: 35,
                column: "Naziv",
                value: "Tedzvid");

            migrationBuilder.UpdateData(
                table: "Takmicar",
                keyColumn: "Id",
                keyValue: 9,
                column: "UkupnoBodova",
                value: 0);

            migrationBuilder.UpdateData(
                table: "Takmicar",
                keyColumn: "Id",
                keyValue: 10,
                column: "UkupnoBodova",
                value: 0);

            migrationBuilder.UpdateData(
                table: "Takmicar",
                keyColumn: "Id",
                keyValue: 11,
                column: "UkupnoBodova",
                value: 0);

            migrationBuilder.UpdateData(
                table: "Takmicar",
                keyColumn: "Id",
                keyValue: 12,
                column: "UkupnoBodova",
                value: 0);

            migrationBuilder.UpdateData(
                table: "Takmicar",
                keyColumn: "Id",
                keyValue: 14,
                column: "UkupnoBodova",
                value: 0);

            migrationBuilder.UpdateData(
                table: "Takmicar",
                keyColumn: "Id",
                keyValue: 15,
                column: "UkupnoBodova",
                value: 0);

            migrationBuilder.UpdateData(
                table: "Takmicar",
                keyColumn: "Id",
                keyValue: 16,
                column: "UkupnoBodova",
                value: 0);

            migrationBuilder.UpdateData(
                table: "Takmicar",
                keyColumn: "Id",
                keyValue: 17,
                column: "UkupnoBodova",
                value: 0);

            migrationBuilder.UpdateData(
                table: "Takmicar",
                keyColumn: "Id",
                keyValue: 18,
                column: "UkupnoBodova",
                value: 0);

            migrationBuilder.UpdateData(
                table: "Takmicar",
                keyColumn: "Id",
                keyValue: 19,
                column: "UkupnoBodova",
                value: 0);

            migrationBuilder.UpdateData(
                table: "Takmicar",
                keyColumn: "Id",
                keyValue: 20,
                column: "UkupnoBodova",
                value: 0);
        }
    }
}
