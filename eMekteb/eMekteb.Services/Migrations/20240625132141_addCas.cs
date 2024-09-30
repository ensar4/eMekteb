using System;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace eMekteb.Services.Migrations
{
    /// <inheritdoc />
    public partial class addCas : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropColumn(
                name: "Datum",
                table: "Prisustvo");

            migrationBuilder.AddColumn<int>(
                name: "CasId",
                table: "Prisustvo",
                type: "int",
                nullable: false,
                defaultValue: 0);

            migrationBuilder.CreateTable(
                name: "Cas",
                columns: table => new
                {
                    Id = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    Datum = table.Column<DateTime>(type: "datetime2", nullable: true),
                    Razred = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    Lekcija = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    MektebId = table.Column<int>(type: "int", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Cas", x => x.Id);
                    table.ForeignKey(
                        name: "FK_Cas_Mekteb_MektebId",
                        column: x => x.MektebId,
                        principalTable: "Mekteb",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.NoAction);
                });

            migrationBuilder.CreateIndex(
                name: "IX_Prisustvo_CasId",
                table: "Prisustvo",
                column: "CasId");

            migrationBuilder.CreateIndex(
                name: "IX_Cas_MektebId",
                table: "Cas",
                column: "MektebId");

            migrationBuilder.AddForeignKey(
                name: "FK_Prisustvo_Cas_CasId",
                table: "Prisustvo",
                column: "CasId",
                principalTable: "Cas",
                principalColumn: "Id",
                onDelete: ReferentialAction.NoAction);
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_Prisustvo_Cas_CasId",
                table: "Prisustvo");

            migrationBuilder.DropTable(
                name: "Cas");

            migrationBuilder.DropIndex(
                name: "IX_Prisustvo_CasId",
                table: "Prisustvo");

            migrationBuilder.DropColumn(
                name: "CasId",
                table: "Prisustvo");

            migrationBuilder.AddColumn<DateTime>(
                name: "Datum",
                table: "Prisustvo",
                type: "datetime2",
                nullable: true);
        }
    }
}
