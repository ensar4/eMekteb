using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace eMekteb.Services.Migrations
{
    /// <inheritdoc />
    public partial class fx4 : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_Cas_Mekteb_MektebId",
                table: "Cas");

            migrationBuilder.AlterColumn<int>(
                name: "MektebId",
                table: "Cas",
                type: "int",
                nullable: true,
                oldClrType: typeof(int),
                oldType: "int");

            migrationBuilder.AddForeignKey(
                name: "FK_Cas_Mekteb_MektebId",
                table: "Cas",
                column: "MektebId",
                principalTable: "Mekteb",
                principalColumn: "Id");
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_Cas_Mekteb_MektebId",
                table: "Cas");

            migrationBuilder.AlterColumn<int>(
                name: "MektebId",
                table: "Cas",
                type: "int",
                nullable: false,
                defaultValue: 0,
                oldClrType: typeof(int),
                oldType: "int",
                oldNullable: true);

            migrationBuilder.AddForeignKey(
                name: "FK_Cas_Mekteb_MektebId",
                table: "Cas",
                column: "MektebId",
                principalTable: "Mekteb",
                principalColumn: "Id",
                onDelete: ReferentialAction.NoAction);
        }
    }
}
