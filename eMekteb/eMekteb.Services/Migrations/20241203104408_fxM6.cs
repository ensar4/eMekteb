using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace eMekteb.Services.Migrations
{
    /// <inheritdoc />
    public partial class fxM6 : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_Prisustvo_Cas_CasId",
                table: "Prisustvo");

            migrationBuilder.AlterColumn<int>(
                name: "CasId",
                table: "Prisustvo",
                type: "int",
                nullable: true,
                oldClrType: typeof(int),
                oldType: "int");

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

            migrationBuilder.AlterColumn<int>(
                name: "CasId",
                table: "Prisustvo",
                type: "int",
                nullable: false,
                defaultValue: 0,
                oldClrType: typeof(int),
                oldType: "int",
                oldNullable: true);

            migrationBuilder.AddForeignKey(
                name: "FK_Prisustvo_Cas_CasId",
                table: "Prisustvo",
                column: "CasId",
                principalTable: "Cas",
                principalColumn: "Id",
                onDelete: ReferentialAction.NoAction);
        }
    }
}
