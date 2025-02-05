using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

#pragma warning disable CA1814 // Prefer jagged arrays over multidimensional

namespace eMekteb.Services.Migrations
{
    /// <inheritdoc />
    public partial class fixSeed4 : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.InsertData(
                table: "Medzlis",
                columns: new[] { "Id", "Adresa", "Mail", "MuftijstvoId", "Naziv", "Telefon" },
                values: new object[,]
                {
                    { 3, "Čiče Miličevića, Stolac 88000", "medzlisstolac@gmail.com", 1, "Medzlis Stolac", "036 550-727" },
                    { 4, "Čiče Miličevića, Čapljina 88000", "medzlisca@gmail.com", 1, "Medzlis Čapljina", "036 550-727" }
                });
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DeleteData(
                table: "Medzlis",
                keyColumn: "Id",
                keyValue: 3);

            migrationBuilder.DeleteData(
                table: "Medzlis",
                keyColumn: "Id",
                keyValue: 4);
        }
    }
}
