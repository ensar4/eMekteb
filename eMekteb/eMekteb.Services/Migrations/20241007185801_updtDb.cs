using System;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace eMekteb.Services.Migrations
{
    /// <inheritdoc />
    public partial class updtDb : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.AddColumn<int>(
                name: "RazredId",
                table: "Zadaca",
                type: "int",
                nullable: true,
                defaultValue: 0);

            migrationBuilder.AddColumn<int>(
                name: "MektebId",
                table: "Razred",
                type: "int",
                nullable: true,
                defaultValue: 0);

            migrationBuilder.AddColumn<int>(
                name: "RazredId",
                table: "Prisustvo",
                type: "int",
                nullable: true,
                defaultValue: 0);

            migrationBuilder.AddColumn<int>(
                name: "AkademskaGodinaId",
                table: "Cas",
                type: "int",
                nullable: true,
                defaultValue: 0);

            migrationBuilder.AddColumn<bool>(
                name: "isAktivna",
                table: "AkademskaGodina",
                type: "bit",
                nullable: true);

            migrationBuilder.CreateTable(
                name: "AkademskaRazred",
                columns: table => new
                {
                    Id = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    AkademskaGodinaId = table.Column<int>(type: "int", nullable: false),
                    RazredId = table.Column<int>(type: "int", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_AkademskaRazred", x => x.Id);
                    table.ForeignKey(
                        name: "FK_AkademskaRazred_AkademskaGodina_AkademskaGodinaId",
                        column: x => x.AkademskaGodinaId,
                        principalTable: "AkademskaGodina",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                    table.ForeignKey(
                        name: "FK_AkademskaRazred_Razred_RazredId",
                        column: x => x.RazredId,
                        principalTable: "Razred",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.NoAction);
                });

            migrationBuilder.CreateTable(
                name: "RazredKorisnik",
                columns: table => new
                {
                    Id = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    DatumUpisa = table.Column<DateTime>(type: "datetime2", nullable: false),
                    RazredId = table.Column<int>(type: "int", nullable: false),
                    KorisnikId = table.Column<int>(type: "int", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_RazredKorisnik", x => x.Id);
                    table.ForeignKey(
                        name: "FK_RazredKorisnik_Korisnik_KorisnikId",
                        column: x => x.KorisnikId,
                        principalTable: "Korisnik",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                    table.ForeignKey(
                        name: "FK_RazredKorisnik_Razred_RazredId",
                        column: x => x.RazredId,
                        principalTable: "Razred",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.NoAction);
                });

            migrationBuilder.CreateIndex(
                name: "IX_Zadaca_RazredId",
                table: "Zadaca",
                column: "RazredId");

            migrationBuilder.CreateIndex(
                name: "IX_Razred_MektebId",
                table: "Razred",
                column: "MektebId");

            migrationBuilder.CreateIndex(
                name: "IX_Prisustvo_RazredId",
                table: "Prisustvo",
                column: "RazredId");

            migrationBuilder.CreateIndex(
                name: "IX_Cas_AkademskaGodinaId",
                table: "Cas",
                column: "AkademskaGodinaId");

            migrationBuilder.CreateIndex(
                name: "IX_AkademskaRazred_AkademskaGodinaId",
                table: "AkademskaRazred",
                column: "AkademskaGodinaId");

            migrationBuilder.CreateIndex(
                name: "IX_AkademskaRazred_RazredId",
                table: "AkademskaRazred",
                column: "RazredId");

            migrationBuilder.CreateIndex(
                name: "IX_RazredKorisnik_KorisnikId",
                table: "RazredKorisnik",
                column: "KorisnikId");

            migrationBuilder.CreateIndex(
                name: "IX_RazredKorisnik_RazredId",
                table: "RazredKorisnik",
                column: "RazredId");

            migrationBuilder.AddForeignKey(
                name: "FK_Cas_AkademskaGodina_AkademskaGodinaId",
                table: "Cas",
                column: "AkademskaGodinaId",
                principalTable: "AkademskaGodina",
                principalColumn: "Id",
                onDelete: ReferentialAction.NoAction);

            migrationBuilder.AddForeignKey(
                name: "FK_Prisustvo_Razred_RazredId",
                table: "Prisustvo",
                column: "RazredId",
                principalTable: "Razred",
                principalColumn: "Id",
                onDelete: ReferentialAction.NoAction);

            migrationBuilder.AddForeignKey(
                name: "FK_Razred_Mekteb_MektebId",
                table: "Razred",
                column: "MektebId",
                principalTable: "Mekteb",
                principalColumn: "Id",
                onDelete: ReferentialAction.NoAction);

            migrationBuilder.AddForeignKey(
                name: "FK_Zadaca_Razred_RazredId",
                table: "Zadaca",
                column: "RazredId",
                principalTable: "Razred",
                principalColumn: "Id",
                onDelete: ReferentialAction.NoAction);
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

            migrationBuilder.DropForeignKey(
                name: "FK_Zadaca_Razred_RazredId",
                table: "Zadaca");

            migrationBuilder.DropTable(
                name: "AkademskaRazred");

            migrationBuilder.DropTable(
                name: "RazredKorisnik");

            migrationBuilder.DropIndex(
                name: "IX_Zadaca_RazredId",
                table: "Zadaca");

            migrationBuilder.DropIndex(
                name: "IX_Razred_MektebId",
                table: "Razred");

            migrationBuilder.DropIndex(
                name: "IX_Prisustvo_RazredId",
                table: "Prisustvo");

            migrationBuilder.DropIndex(
                name: "IX_Cas_AkademskaGodinaId",
                table: "Cas");

            migrationBuilder.DropColumn(
                name: "RazredId",
                table: "Zadaca");

            migrationBuilder.DropColumn(
                name: "MektebId",
                table: "Razred");

            migrationBuilder.DropColumn(
                name: "RazredId",
                table: "Prisustvo");

            migrationBuilder.DropColumn(
                name: "AkademskaGodinaId",
                table: "Cas");

            migrationBuilder.DropColumn(
                name: "isAktivna",
                table: "AkademskaGodina");
        }
    }
}
