using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace eMekteb.Services.Migrations
{
    /// <inheritdoc />
    public partial class addZad : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.AddColumn<string>(
                name: "ZaZadacu",
                table: "Zadaca",
                type: "nvarchar(max)",
                nullable: true);
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropColumn(
                name: "ZaZadacu",
                table: "Zadaca");
        }
    }
}
