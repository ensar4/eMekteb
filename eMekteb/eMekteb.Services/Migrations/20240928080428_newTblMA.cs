using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace eMekteb.Services.Migrations
{
    /// <inheritdoc />
    public partial class newTblMA : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_Mekteb_AkademskaGodina_AkademskaGodinaId",
                table: "Mekteb");

            migrationBuilder.DropIndex(
                name: "IX_Mekteb_AkademskaGodinaId",
                table: "Mekteb");

            migrationBuilder.DropColumn(
                name: "AkademskaGodinaId",
                table: "Mekteb");

            migrationBuilder.CreateTable(
                name: "AkademskaMekteb",
                columns: table => new
                {
                    Id = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    AkademskaGodinaId = table.Column<int>(type: "int", nullable: false),
                    MektebId = table.Column<int>(type: "int", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_AkademskaMekteb", x => x.Id);
                    table.ForeignKey(
                        name: "FK_AkademskaMekteb_AkademskaGodina_AkademskaGodinaId",
                        column: x => x.AkademskaGodinaId,
                        principalTable: "AkademskaGodina",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.NoAction);
                    table.ForeignKey(
                        name: "FK_AkademskaMekteb_Mekteb_MektebId",
                        column: x => x.MektebId,
                        principalTable: "Mekteb",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.NoAction);
                });

            migrationBuilder.CreateIndex(
                name: "IX_AkademskaMekteb_AkademskaGodinaId",
                table: "AkademskaMekteb",
                column: "AkademskaGodinaId");

            migrationBuilder.CreateIndex(
                name: "IX_AkademskaMekteb_MektebId",
                table: "AkademskaMekteb",
                column: "MektebId");
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropTable(
                name: "AkademskaMekteb");

            migrationBuilder.AddColumn<int>(
                name: "AkademskaGodinaId",
                table: "Mekteb",
                type: "int",
                nullable: false,
                defaultValue: 0);

            migrationBuilder.CreateIndex(
                name: "IX_Mekteb_AkademskaGodinaId",
                table: "Mekteb",
                column: "AkademskaGodinaId");

            migrationBuilder.AddForeignKey(
                name: "FK_Mekteb_AkademskaGodina_AkademskaGodinaId",
                table: "Mekteb",
                column: "AkademskaGodinaId",
                principalTable: "AkademskaGodina",
                principalColumn: "Id",
                onDelete: ReferentialAction.NoAction);
        }
    }
}
