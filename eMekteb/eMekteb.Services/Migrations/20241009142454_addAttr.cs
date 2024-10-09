using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace eMekteb.Services.Migrations
{
    /// <inheritdoc />
    public partial class addAttr : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_Cas_AkademskaGodina_AkademskaGodinaId",
                table: "Cas");

            migrationBuilder.DropForeignKey(
                name: "FK_Prisustvo_Razred_RazredId",
                table: "Prisustvo");

            migrationBuilder.DropForeignKey(
                name: "FK_Razred_Mekteb_MektebId",
                table: "Razred");

            migrationBuilder.AlterColumn<int>(
                name: "MektebId",
                table: "Razred",
                type: "int",
                nullable: true,
                oldClrType: typeof(int),
                oldType: "int");

            migrationBuilder.AlterColumn<int>(
                name: "RazredId",
                table: "Prisustvo",
                type: "int",
                nullable: true,
                oldClrType: typeof(int),
                oldType: "int");

            migrationBuilder.AddColumn<int>(
                name: "IdRazreda",
                table: "Korisnik",
                type: "int",
                nullable: true);

            migrationBuilder.AlterColumn<int>(
                name: "AkademskaGodinaId",
                table: "Cas",
                type: "int",
                nullable: true,
                oldClrType: typeof(int),
                oldType: "int");

            migrationBuilder.AddForeignKey(
                name: "FK_Cas_AkademskaGodina_AkademskaGodinaId",
                table: "Cas",
                column: "AkademskaGodinaId",
                principalTable: "AkademskaGodina",
                principalColumn: "Id");

            migrationBuilder.AddForeignKey(
                name: "FK_Prisustvo_Razred_RazredId",
                table: "Prisustvo",
                column: "RazredId",
                principalTable: "Razred",
                principalColumn: "Id");

            migrationBuilder.AddForeignKey(
                name: "FK_Razred_Mekteb_MektebId",
                table: "Razred",
                column: "MektebId",
                principalTable: "Mekteb",
                principalColumn: "Id");
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_Cas_AkademskaGodina_AkademskaGodinaId",
                table: "Cas");

            migrationBuilder.DropForeignKey(
                name: "FK_Prisustvo_Razred_RazredId",
                table: "Prisustvo");

            migrationBuilder.DropForeignKey(
                name: "FK_Razred_Mekteb_MektebId",
                table: "Razred");

            migrationBuilder.DropColumn(
                name: "IdRazreda",
                table: "Korisnik");

            migrationBuilder.AlterColumn<int>(
                name: "MektebId",
                table: "Razred",
                type: "int",
                nullable: false,
                defaultValue: 0,
                oldClrType: typeof(int),
                oldType: "int",
                oldNullable: true);

            migrationBuilder.AlterColumn<int>(
                name: "RazredId",
                table: "Prisustvo",
                type: "int",
                nullable: false,
                defaultValue: 0,
                oldClrType: typeof(int),
                oldType: "int",
                oldNullable: true);

            migrationBuilder.AlterColumn<int>(
                name: "AkademskaGodinaId",
                table: "Cas",
                type: "int",
                nullable: false,
                defaultValue: 0,
                oldClrType: typeof(int),
                oldType: "int",
                oldNullable: true);

            migrationBuilder.AddForeignKey(
                name: "FK_Cas_AkademskaGodina_AkademskaGodinaId",
                table: "Cas",
                column: "AkademskaGodinaId",
                principalTable: "AkademskaGodina",
                principalColumn: "Id",
                onDelete: ReferentialAction.Cascade);

            migrationBuilder.AddForeignKey(
                name: "FK_Prisustvo_Razred_RazredId",
                table: "Prisustvo",
                column: "RazredId",
                principalTable: "Razred",
                principalColumn: "Id",
                onDelete: ReferentialAction.Cascade);

            migrationBuilder.AddForeignKey(
                name: "FK_Razred_Mekteb_MektebId",
                table: "Razred",
                column: "MektebId",
                principalTable: "Mekteb",
                principalColumn: "Id",
                onDelete: ReferentialAction.Cascade);
        }
    }
}
