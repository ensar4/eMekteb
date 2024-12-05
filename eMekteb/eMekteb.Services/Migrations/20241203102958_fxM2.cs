using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace eMekteb.Services.Migrations
{
    /// <inheritdoc />
    public partial class fxM2 : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
           name: "FK_Prisustvo_Cas_CasId",
           table: "Prisustvo");

            migrationBuilder.AddForeignKey(
                name: "FK_Prisustvo_Cas_CasId",
                table: "Prisustvo",
                column: "CasId",
                principalTable: "Cas",
                principalColumn: "Id",
                onDelete: ReferentialAction.Cascade); // Enable Cascade Delete

            // Fix Razred -> Mekteb
            migrationBuilder.DropForeignKey(
                name: "FK_Razred_Mekteb_MektebId",
                table: "Razred");

            migrationBuilder.AddForeignKey(
                name: "FK_Razred_Mekteb_MektebId",
                table: "Razred",
                column: "MektebId",
                principalTable: "Mekteb",
                principalColumn: "Id",
                onDelete: ReferentialAction.Cascade); // Enable Cascade Delete
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
             migrationBuilder.DropForeignKey(
            name: "FK_Prisustvo_Cas_CasId",
            table: "Prisustvo");

        migrationBuilder.AddForeignKey(
            name: "FK_Prisustvo_Cas_CasId",
            table: "Prisustvo",
            column: "CasId",
            principalTable: "Cas",
            principalColumn: "Id",
            onDelete: ReferentialAction.Restrict); // Default to Restrict

        // Revert Razred -> Mekteb
        migrationBuilder.DropForeignKey(
            name: "FK_Razred_Mekteb_MektebId",
            table: "Razred");

        migrationBuilder.AddForeignKey(
            name: "FK_Razred_Mekteb_MektebId",
            table: "Razred",
            column: "MektebId",
            principalTable: "Mekteb",
            principalColumn: "Id",
            onDelete: ReferentialAction.Restrict); // Default to Restrict
        }
    }
}
