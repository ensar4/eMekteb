using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace eMekteb.Services.Migrations
{
    /// <inheritdoc />
    public partial class FixKeys : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.AddColumn<int>(
                name: "TakmicenjeId",
                table: "Kategorija",
                type: "int",
                nullable: false,
                defaultValue: 0);

            migrationBuilder.CreateIndex(
                name: "IX_Kategorija_TakmicenjeId",
                table: "Kategorija",
                column: "TakmicenjeId");

            migrationBuilder.AddForeignKey(
                name: "FK_Kategorija_Takmicenje_TakmicenjeId",
                table: "Kategorija",
                column: "TakmicenjeId",
                principalTable: "Takmicenje",
                principalColumn: "Id",
                onDelete: ReferentialAction.Cascade);
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_Kategorija_Takmicenje_TakmicenjeId",
                table: "Kategorija");

            migrationBuilder.DropIndex(
                name: "IX_Kategorija_TakmicenjeId",
                table: "Kategorija");

            migrationBuilder.DropColumn(
                name: "TakmicenjeId",
                table: "Kategorija");
        }
    }
}
