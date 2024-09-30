using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace eMekteb.Services.Migrations
{
    /// <inheritdoc />
    public partial class roditelj : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.AddColumn<int>(
                name: "RoditeljId",
                table: "Korisnik",
                type: "int",
                nullable: true);

            migrationBuilder.CreateIndex(
                name: "IX_Korisnik_RoditeljId",
                table: "Korisnik",
                column: "RoditeljId");

            migrationBuilder.AddForeignKey(
                name: "FK_Korisnik_Korisnik_RoditeljId",
                table: "Korisnik",
                column: "RoditeljId",
                principalTable: "Korisnik",
                principalColumn: "Id");
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_Korisnik_Korisnik_RoditeljId",
                table: "Korisnik");

            migrationBuilder.DropIndex(
                name: "IX_Korisnik_RoditeljId",
                table: "Korisnik");

            migrationBuilder.DropColumn(
                name: "RoditeljId",
                table: "Korisnik");
        }
    }
}
