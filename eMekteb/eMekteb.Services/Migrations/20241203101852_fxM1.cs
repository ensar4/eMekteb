using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace eMekteb.Services.Migrations
{
    /// <inheritdoc />
    public partial class fxM1 : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
      name: "FK_Cas_AkademskaGodina_AkademskaGodinaId",
      table: "Cas");

            migrationBuilder.AddForeignKey(
                name: "FK_Cas_AkademskaGodina_AkademskaGodinaId",
                table: "Cas",
                column: "AkademskaGodinaId",
                principalTable: "AkademskaGodina",
                principalColumn: "Id",
                onDelete: ReferentialAction.Cascade); // Enable Cascade Delete

            // Update the foreign key for Mekteb
            migrationBuilder.DropForeignKey(
                name: "FK_Cas_Mekteb_MektebId",
                table: "Cas");

            migrationBuilder.AddForeignKey(
                name: "FK_Cas_Mekteb_MektebId",
                table: "Cas",
                column: "MektebId",
                principalTable: "Mekteb",
                principalColumn: "Id",
                onDelete: ReferentialAction.Cascade); // Enable Cascade Delete
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {

        }
    }
}
