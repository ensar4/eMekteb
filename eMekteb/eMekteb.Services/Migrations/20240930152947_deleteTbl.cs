using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace eMekteb.Services.Migrations
{
    /// <inheritdoc />
    public partial class deleteTbl : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropTable(
                name: "Bodovi");

            migrationBuilder.DropTable(
                name: "Lekcija");
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.CreateTable(
                name: "Bodovi",
                columns: table => new
                {
                    Id = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    TakmicarId = table.Column<int>(type: "int", nullable: false),
                    DodjeljeniBodovi = table.Column<int>(type: "int", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Bodovi", x => x.Id);
                    table.ForeignKey(
                        name: "FK_Bodovi_Takmicar_TakmicarId",
                        column: x => x.TakmicarId,
                        principalTable: "Takmicar",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateTable(
                name: "Lekcija",
                columns: table => new
                {
                    Id = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    RazredId = table.Column<int>(type: "int", nullable: false),
                    Naziv = table.Column<string>(type: "nvarchar(max)", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Lekcija", x => x.Id);
                    table.ForeignKey(
                        name: "FK_Lekcija_Razred_RazredId",
                        column: x => x.RazredId,
                        principalTable: "Razred",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateIndex(
                name: "IX_Bodovi_TakmicarId",
                table: "Bodovi",
                column: "TakmicarId");

            migrationBuilder.CreateIndex(
                name: "IX_Lekcija_RazredId",
                table: "Lekcija",
                column: "RazredId");
        }
    }
}
