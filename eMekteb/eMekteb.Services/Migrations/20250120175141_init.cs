using System;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

#pragma warning disable CA1814 // Prefer jagged arrays over multidimensional

namespace eMekteb.Services.Migrations
{
    /// <inheritdoc />
    public partial class init : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.CreateTable(
                name: "AkademskaGodina",
                columns: table => new
                {
                    Id = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    Naziv = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    DatumPocetka = table.Column<DateTime>(type: "datetime2", nullable: false),
                    DatumZavrsetka = table.Column<DateTime>(type: "datetime2", nullable: false),
                    isAktivna = table.Column<bool>(type: "bit", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_AkademskaGodina", x => x.Id);
                });

            migrationBuilder.CreateTable(
                name: "Muftijstvo",
                columns: table => new
                {
                    Id = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    Naziv = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    Adresa = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    Telefon = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    Mail = table.Column<string>(type: "nvarchar(max)", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Muftijstvo", x => x.Id);
                });

            migrationBuilder.CreateTable(
                name: "Ocjene",
                columns: table => new
                {
                    Id = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    Ocjena = table.Column<int>(type: "int", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Ocjene", x => x.Id);
                });

            migrationBuilder.CreateTable(
                name: "Uloga",
                columns: table => new
                {
                    Id = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    Naziv = table.Column<string>(type: "nvarchar(max)", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Uloga", x => x.Id);
                });

            migrationBuilder.CreateTable(
                name: "Medzlis",
                columns: table => new
                {
                    Id = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    Naziv = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    Adresa = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    Telefon = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    Mail = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    MuftijstvoId = table.Column<int>(type: "int", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Medzlis", x => x.Id);
                    table.ForeignKey(
                        name: "FK_Medzlis_Muftijstvo_MuftijstvoId",
                        column: x => x.MuftijstvoId,
                        principalTable: "Muftijstvo",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateTable(
                name: "Mekteb",
                columns: table => new
                {
                    Id = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    Naziv = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    Telefon = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    Adresa = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    MedzlisId = table.Column<int>(type: "int", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Mekteb", x => x.Id);
                    table.ForeignKey(
                        name: "FK_Mekteb_Medzlis_MedzlisId",
                        column: x => x.MedzlisId,
                        principalTable: "Medzlis",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateTable(
                name: "Takmicenje",
                columns: table => new
                {
                    Id = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    Godina = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    DatumOdrzavanja = table.Column<DateTime>(type: "datetime2", nullable: false),
                    Lokacija = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    VrijemePocetka = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    Info = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    MedzlisId = table.Column<int>(type: "int", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Takmicenje", x => x.Id);
                    table.ForeignKey(
                        name: "FK_Takmicenje_Medzlis_MedzlisId",
                        column: x => x.MedzlisId,
                        principalTable: "Medzlis",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                });

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
                        onDelete: ReferentialAction.Cascade);
                    table.ForeignKey(
                        name: "FK_AkademskaMekteb_Mekteb_MektebId",
                        column: x => x.MektebId,
                        principalTable: "Mekteb",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateTable(
                name: "Cas",
                columns: table => new
                {
                    Id = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    Datum = table.Column<DateTime>(type: "datetime2", nullable: true),
                    Razred = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    Lekcija = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    MektebId = table.Column<int>(type: "int", nullable: true),
                    AkademskaGodinaId = table.Column<int>(type: "int", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Cas", x => x.Id);
                    table.ForeignKey(
                        name: "FK_Cas_AkademskaGodina_AkademskaGodinaId",
                        column: x => x.AkademskaGodinaId,
                        principalTable: "AkademskaGodina",
                        principalColumn: "Id");
                    table.ForeignKey(
                        name: "FK_Cas_Mekteb_MektebId",
                        column: x => x.MektebId,
                        principalTable: "Mekteb",
                        principalColumn: "Id");
                });

            migrationBuilder.CreateTable(
                name: "DodatneLekcije",
                columns: table => new
                {
                    Id = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    Naziv = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    Tekst = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    DatumObjavljivanja = table.Column<DateTime>(type: "datetime2", nullable: false),
                    Likes = table.Column<int>(type: "int", nullable: true),
                    Dislikes = table.Column<int>(type: "int", nullable: true),
                    MektebId = table.Column<int>(type: "int", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_DodatneLekcije", x => x.Id);
                    table.ForeignKey(
                        name: "FK_DodatneLekcije_Mekteb_MektebId",
                        column: x => x.MektebId,
                        principalTable: "Mekteb",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateTable(
                name: "Kamp",
                columns: table => new
                {
                    Id = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    Naziv = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    Opis = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    DatumPocetka = table.Column<DateTime>(type: "datetime2", nullable: true),
                    DatumZavrsetka = table.Column<DateTime>(type: "datetime2", nullable: true),
                    Voditelj = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    MektebId = table.Column<int>(type: "int", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Kamp", x => x.Id);
                    table.ForeignKey(
                        name: "FK_Kamp_Mekteb_MektebId",
                        column: x => x.MektebId,
                        principalTable: "Mekteb",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateTable(
                name: "Obavijest",
                columns: table => new
                {
                    Id = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    Naslov = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    Opis = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    DatumObjave = table.Column<DateTime>(type: "datetime2", nullable: false),
                    VrstaObjave = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    StateMachine = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    MektebId = table.Column<int>(type: "int", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Obavijest", x => x.Id);
                    table.ForeignKey(
                        name: "FK_Obavijest_Mekteb_MektebId",
                        column: x => x.MektebId,
                        principalTable: "Mekteb",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateTable(
                name: "Razred",
                columns: table => new
                {
                    Id = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    Naziv = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    MektebId = table.Column<int>(type: "int", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Razred", x => x.Id);
                    table.ForeignKey(
                        name: "FK_Razred_Mekteb_MektebId",
                        column: x => x.MektebId,
                        principalTable: "Mekteb",
                        principalColumn: "Id");
                });

            migrationBuilder.CreateTable(
                name: "Kategorija",
                columns: table => new
                {
                    Id = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    Naziv = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    Nivo = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    TakmicenjeId = table.Column<int>(type: "int", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Kategorija", x => x.Id);
                    table.ForeignKey(
                        name: "FK_Kategorija_Takmicenje_TakmicenjeId",
                        column: x => x.TakmicenjeId,
                        principalTable: "Takmicenje",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                });

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
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateTable(
                name: "Korisnik",
                columns: table => new
                {
                    Id = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    Ime = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    Prezime = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    Username = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    LozinkaHash = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    LozinkaSalt = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    Telefon = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    Mail = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    Spol = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    Status = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    DatumRodjenja = table.Column<DateTime>(type: "datetime2", nullable: false),
                    ImeRoditelja = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    Prisustvo = table.Column<double>(type: "float", nullable: true),
                    NazivRazreda = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    Prosjek = table.Column<double>(type: "float", nullable: true),
                    IdRazreda = table.Column<int>(type: "int", nullable: true),
                    MektebId = table.Column<int>(type: "int", nullable: false),
                    MedzlisId = table.Column<int>(type: "int", nullable: true),
                    MuftijstvoId = table.Column<int>(type: "int", nullable: true),
                    RoditeljId = table.Column<int>(type: "int", nullable: true),
                    RazredId = table.Column<int>(type: "int", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Korisnik", x => x.Id);
                    table.ForeignKey(
                        name: "FK_Korisnik_Korisnik_RoditeljId",
                        column: x => x.RoditeljId,
                        principalTable: "Korisnik",
                        principalColumn: "Id");
                    table.ForeignKey(
                        name: "FK_Korisnik_Medzlis_MedzlisId",
                        column: x => x.MedzlisId,
                        principalTable: "Medzlis",
                        principalColumn: "Id");
                    table.ForeignKey(
                        name: "FK_Korisnik_Mekteb_MektebId",
                        column: x => x.MektebId,
                        principalTable: "Mekteb",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                    table.ForeignKey(
                        name: "FK_Korisnik_Muftijstvo_MuftijstvoId",
                        column: x => x.MuftijstvoId,
                        principalTable: "Muftijstvo",
                        principalColumn: "Id");
                    table.ForeignKey(
                        name: "FK_Korisnik_Razred_RazredId",
                        column: x => x.RazredId,
                        principalTable: "Razred",
                        principalColumn: "Id");
                });

            migrationBuilder.CreateTable(
                name: "Takmicar",
                columns: table => new
                {
                    Id = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    Ime = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    Prezime = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    DatumRodjenja = table.Column<DateTime>(type: "datetime2", nullable: false),
                    UkupnoBodova = table.Column<int>(type: "int", nullable: true),
                    KategorijaId = table.Column<int>(type: "int", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Takmicar", x => x.Id);
                    table.ForeignKey(
                        name: "FK_Takmicar_Kategorija_KategorijaId",
                        column: x => x.KategorijaId,
                        principalTable: "Kategorija",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateTable(
                name: "KampKorisnik",
                columns: table => new
                {
                    Id = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    DatumDodavanja = table.Column<DateTime>(type: "datetime2", nullable: false),
                    KorisnikId = table.Column<int>(type: "int", nullable: false),
                    KampId = table.Column<int>(type: "int", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_KampKorisnik", x => x.Id);
                    table.ForeignKey(
                        name: "FK_KampKorisnik_Kamp_KampId",
                        column: x => x.KampId,
                        principalTable: "Kamp",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                    table.ForeignKey(
                        name: "FK_KampKorisnik_Korisnik_KorisnikId",
                        column: x => x.KorisnikId,
                        principalTable: "Korisnik",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.NoAction);
                });

            migrationBuilder.CreateTable(
                name: "KorisniciUloge",
                columns: table => new
                {
                    Id = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    DatumIzmjene = table.Column<DateTime>(type: "datetime2", nullable: false),
                    KorisnikId = table.Column<int>(type: "int", nullable: false),
                    UlogaId = table.Column<int>(type: "int", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_KorisniciUloge", x => x.Id);
                    table.ForeignKey(
                        name: "FK_KorisniciUloge_Korisnik_KorisnikId",
                        column: x => x.KorisnikId,
                        principalTable: "Korisnik",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                    table.ForeignKey(
                        name: "FK_KorisniciUloge_Uloga_UlogaId",
                        column: x => x.UlogaId,
                        principalTable: "Uloga",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateTable(
                name: "Prisustvo",
                columns: table => new
                {
                    Id = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    Prisutan = table.Column<bool>(type: "bit", nullable: true),
                    Datum = table.Column<DateTime>(type: "datetime2", nullable: true),
                    KorisnikId = table.Column<int>(type: "int", nullable: false),
                    CasId = table.Column<int>(type: "int", nullable: true),
                    RazredId = table.Column<int>(type: "int", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Prisustvo", x => x.Id);
                    table.ForeignKey(
                        name: "FK_Prisustvo_Cas_CasId",
                        column: x => x.CasId,
                        principalTable: "Cas",
                        principalColumn: "Id");
                    table.ForeignKey(
                        name: "FK_Prisustvo_Korisnik_KorisnikId",
                        column: x => x.KorisnikId,
                        principalTable: "Korisnik",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.NoAction);
                    table.ForeignKey(
                        name: "FK_Prisustvo_Razred_RazredId",
                        column: x => x.RazredId,
                        principalTable: "Razred",
                        principalColumn: "Id");
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

            migrationBuilder.CreateTable(
                name: "Slika",
                columns: table => new
                {
                    Id = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    SlikaBytes = table.Column<byte[]>(type: "varbinary(max)", nullable: true),
                    KorisnikId = table.Column<int>(type: "int", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Slika", x => x.Id);
                    table.ForeignKey(
                        name: "FK_Slika_Korisnik_KorisnikId",
                        column: x => x.KorisnikId,
                        principalTable: "Korisnik",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateTable(
                name: "Zadaca",
                columns: table => new
                {
                    Id = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    DatumDodjele = table.Column<DateTime>(type: "datetime2", nullable: false),
                    Lekcija = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    ZaZadacu = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    KorisnikId = table.Column<int>(type: "int", nullable: false),
                    OcjeneId = table.Column<int>(type: "int", nullable: false),
                    RazredId = table.Column<int>(type: "int", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Zadaca", x => x.Id);
                    table.ForeignKey(
                        name: "FK_Zadaca_Korisnik_KorisnikId",
                        column: x => x.KorisnikId,
                        principalTable: "Korisnik",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                    table.ForeignKey(
                        name: "FK_Zadaca_Ocjene_OcjeneId",
                        column: x => x.OcjeneId,
                        principalTable: "Ocjene",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                    table.ForeignKey(
                        name: "FK_Zadaca_Razred_RazredId",
                        column: x => x.RazredId,
                        principalTable: "Razred",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.NoAction);
                });

            migrationBuilder.InsertData(
                table: "AkademskaGodina",
                columns: new[] { "Id", "DatumPocetka", "DatumZavrsetka", "Naziv", "isAktivna" },
                values: new object[,]
                {
                    { 1, new DateTime(2022, 9, 12, 0, 0, 0, 0, DateTimeKind.Unspecified), new DateTime(2023, 6, 12, 0, 0, 0, 0, DateTimeKind.Unspecified), "2022/23", false },
                    { 2, new DateTime(2023, 9, 12, 0, 0, 0, 0, DateTimeKind.Unspecified), new DateTime(2024, 6, 12, 0, 0, 0, 0, DateTimeKind.Unspecified), "2023/24", false },
                    { 3, new DateTime(2024, 9, 12, 0, 0, 0, 0, DateTimeKind.Unspecified), new DateTime(2025, 6, 12, 0, 0, 0, 0, DateTimeKind.Unspecified), "2024/25", true }
                });

            migrationBuilder.InsertData(
                table: "Muftijstvo",
                columns: new[] { "Id", "Adresa", "Mail", "Naziv", "Telefon" },
                values: new object[] { 1, "Čiče Miličevića, Mostar 88000", "muftijstvomostar@gmail.com", "Muftijstvo Mostarsko", "036 550-727" });

            migrationBuilder.InsertData(
                table: "Ocjene",
                columns: new[] { "Id", "Ocjena" },
                values: new object[,]
                {
                    { 1, 5 },
                    { 2, 4 },
                    { 3, 3 },
                    { 4, 2 },
                    { 5, 1 }
                });

            migrationBuilder.InsertData(
                table: "Uloga",
                columns: new[] { "Id", "Naziv" },
                values: new object[,]
                {
                    { 1, "Admin" },
                    { 2, "Ucenik" },
                    { 3, "Imam" },
                    { 4, "Roditelj" },
                    { 5, "Komisija" },
                    { 6, "SuperAdmin" }
                });

            migrationBuilder.InsertData(
                table: "Medzlis",
                columns: new[] { "Id", "Adresa", "Mail", "MuftijstvoId", "Naziv", "Telefon" },
                values: new object[] { 1, "Čiče Miličevića, Mostar 88000", "medzlismostar@gmail.com", 1, "Medzlis Mostar", "036 550-727" });

            migrationBuilder.InsertData(
                table: "Mekteb",
                columns: new[] { "Id", "Adresa", "MedzlisId", "Naziv", "Telefon" },
                values: new object[,]
                {
                    { 1, "Mostar", 1, "Mekteb Opine", "036 585-964" },
                    { 2, "Mostar", 1, "Mekteb Zalik", "036 585-967" },
                    { 3, "Mostar", 1, "Mekteb Luka", "036 585-963" },
                    { 4, "Mostar", 1, "Mekteb Musala", "036 585-962" },
                    { 5, "Mostar", 1, "Mekteb Blagaj", "036 585-961" },
                    { 6, "Mostar", 1, "Mekteb Vrapčići", "036 585-965" },
                    { 7, "Mostar", 1, "Mekteb Zalik 2", "036 585-967" },
                    { 8, "Mostar", 1, "Mekteb Luka 2", "036 585-963" },
                    { 9, "Mostar", 1, "Mekteb Ričina", "036 585-962" },
                    { 10, "Mostar", 1, "Mekteb Podhum", "036 585-961" },
                    { 11, "Mostar", 1, "Mekteb Pijesak", "036 585-965" },
                    { 12, "Mostar", 1, "Mekteb Balinovac", "036 585-961" },
                    { 13, "Mostar", 1, "Mekteb Jasenica", "036 585-965" },
                    { 14, "Mostar", 1, "Mekteb Kočine", "036 585-961" },
                    { 15, "Mostar", 1, "Mekteb Brankovac", "036 585-965" }
                });

            migrationBuilder.InsertData(
                table: "Takmicenje",
                columns: new[] { "Id", "DatumOdrzavanja", "Godina", "Info", "Lokacija", "MedzlisId", "VrijemePocetka" },
                values: new object[,]
                {
                    { 1, new DateTime(2023, 6, 12, 0, 0, 0, 0, DateTimeKind.Unspecified), "2023", "Takmicenje za sve polaznike mekteba. Bujrum!", "Medresa", 1, "10:00" },
                    { 2, new DateTime(2024, 6, 12, 0, 0, 0, 0, DateTimeKind.Unspecified), "2024", "Takmicenje za sve polaznike mekteba. Bujrum!", "Medresa", 1, "10:00" }
                });

            migrationBuilder.InsertData(
                table: "AkademskaMekteb",
                columns: new[] { "Id", "AkademskaGodinaId", "MektebId" },
                values: new object[,]
                {
                    { 1, 1, 1 },
                    { 2, 1, 2 },
                    { 3, 1, 3 },
                    { 4, 2, 1 },
                    { 5, 2, 2 },
                    { 6, 2, 3 },
                    { 7, 2, 4 },
                    { 8, 3, 2 },
                    { 9, 3, 3 },
                    { 10, 3, 1 },
                    { 11, 3, 4 },
                    { 12, 3, 5 },
                    { 13, 3, 6 }
                });

            migrationBuilder.InsertData(
                table: "Cas",
                columns: new[] { "Id", "AkademskaGodinaId", "Datum", "Lekcija", "MektebId", "Razred" },
                values: new object[,]
                {
                    { 1, 1, new DateTime(2022, 9, 12, 0, 0, 0, 0, DateTimeKind.Unspecified), "Rabbijesir", 1, "I nivo" },
                    { 2, 1, new DateTime(2022, 9, 13, 0, 0, 0, 0, DateTimeKind.Unspecified), "Subhaneke", 1, "I nivo" },
                    { 3, 1, new DateTime(2022, 9, 18, 0, 0, 0, 0, DateTimeKind.Unspecified), "Fatiha", 1, "I nivo" },
                    { 4, 2, new DateTime(2023, 9, 12, 0, 0, 0, 0, DateTimeKind.Unspecified), "Subhaneke", 1, "II nivo" },
                    { 5, 2, new DateTime(2023, 9, 13, 0, 0, 0, 0, DateTimeKind.Unspecified), "Krupno R", 1, "II nivo" },
                    { 6, 2, new DateTime(2023, 9, 18, 0, 0, 0, 0, DateTimeKind.Unspecified), "Ja Sin", 1, "II nivo" },
                    { 7, 2, new DateTime(2023, 9, 19, 0, 0, 0, 0, DateTimeKind.Unspecified), "Subhaneke", 1, "II nivo" },
                    { 8, 3, new DateTime(2024, 9, 12, 0, 0, 0, 0, DateTimeKind.Unspecified), "Podne namaz", 1, "III nivo" },
                    { 9, 3, new DateTime(2024, 9, 13, 0, 0, 0, 0, DateTimeKind.Unspecified), "Sabah namaz", 1, "III nivo" },
                    { 10, 3, new DateTime(2024, 9, 18, 0, 0, 0, 0, DateTimeKind.Unspecified), "Jacija namaz", 1, "III nivo" },
                    { 11, 1, new DateTime(2024, 9, 12, 0, 0, 0, 0, DateTimeKind.Unspecified), "Ja Sin", 2, "III nivo" },
                    { 12, 2, new DateTime(2024, 9, 12, 0, 0, 0, 0, DateTimeKind.Unspecified), "Rabbijesir", 2, "II nivo" },
                    { 13, 3, new DateTime(2024, 9, 12, 0, 0, 0, 0, DateTimeKind.Unspecified), "Subhaneke", 2, "II nivo" },
                    { 14, 1, new DateTime(2023, 9, 12, 0, 0, 0, 0, DateTimeKind.Unspecified), "Krupno R", 3, "Sufara" },
                    { 15, 2, new DateTime(2024, 9, 12, 0, 0, 0, 0, DateTimeKind.Unspecified), "Rabbijesir", 3, "Sufara" },
                    { 16, 3, new DateTime(2024, 9, 12, 0, 0, 0, 0, DateTimeKind.Unspecified), "Ja Sin", 3, "III nivo" },
                    { 17, 2, new DateTime(2023, 9, 12, 0, 0, 0, 0, DateTimeKind.Unspecified), "Subhaneke", 4, "III nivo" },
                    { 18, 3, new DateTime(2024, 9, 12, 0, 0, 0, 0, DateTimeKind.Unspecified), "Subhaneke", 4, "II nivo" },
                    { 19, 3, new DateTime(2024, 9, 12, 0, 0, 0, 0, DateTimeKind.Unspecified), "Fatiha", 5, "Sufara" },
                    { 20, 3, new DateTime(2024, 9, 12, 0, 0, 0, 0, DateTimeKind.Unspecified), "Ja Sin", 6, "Sufara" },
                    { 21, 3, new DateTime(2024, 9, 12, 0, 0, 0, 0, DateTimeKind.Unspecified), "Rabbijesir", 6, "Hatma" }
                });

            migrationBuilder.InsertData(
                table: "DodatneLekcije",
                columns: new[] { "Id", "DatumObjavljivanja", "Dislikes", "Likes", "MektebId", "Naziv", "Tekst" },
                values: new object[,]
                {
                    { 1, new DateTime(2024, 9, 12, 0, 0, 0, 0, DateTimeKind.Unspecified), 0, 2, 1, "Bereket masline", "U svome životu čovjek često dobiva samo jednu priliku da učini neko dobro djelo, vezano za njegovo trenutno stanje, trenutnu preokupaciju. Što se tiče uzroka na ovome svijetu, jedina stvar koja ga može nagnati i inspirirati da u pravome trenu uradi pravu stvar jeste njegovo društvo, osobe s kojima je često u kontaktu.\r\n\r\nUkoliko je čovjekovo društvo zdravo i pobožno, i on će uživati tu pobožnost makar sâm i ne bio toliko otvoren za vjeru. Kako naš narod izražava hazreti Pejgamberovu, alejhisselam, preporuku u formi vlastite mudrosti: „S kim si, takav si.“\r\n\r\nMaslinovo stablo blagoslovljeno je budući da je prvi put niklo na mjestu na kojemu se konstantno veličao uzvišeni Allah. Od toga vremena i od toga mjesta, svaka maslinova grančica blagoslovljena je baš kao i njen predak – stablo iz kojega je svo maslinovo drveće poteklo.\r\n\r\nI nadalje, svako ko u sebe unese sok, ulje, koje se dobiva iz ploda maslinovog stabla, i sâm će dobiti od njegovog berićeta, blagoslova, makar ga ne zasluživao. Jednostavno, stvorenje na koje uzvišeni Bog spusti Svoj blagoslov, taj će blagoslov širiti na sve s čime dođe u kontakt. Zato mudar vjernik traga za iskrenim Božijim robovima kojih, i pored sve žestine smutnje koja se može spustiti  na Zemlji, ima u svakome vremenu, na skoro svim mjestima.\r\n\r\nNeodgojen čovjek često odlazi u krajnost pa kada mu dragi Allah i podari da pronađe Njegovog iskrenog roba, neodgojeni ga prisvoji za sebe, guši ga svojom napadnošću, druge lišava berićeta a zaboravi i sâm sebe te se osloni da će ga sâmo druženje s takvom osobom, bez daljnjega rada na sebi, na odgoju vlastite duše, odvesti u džennet. U svemu treba mjera." },
                    { 2, new DateTime(2024, 9, 12, 0, 0, 0, 0, DateTimeKind.Unspecified), 0, 2, 1, "U dobrom društvu", "Insanu godi osama. Da se liši dunjaluka, svega što ga vezuje za ovaj dunjaluk, da se liši jastva. Da se liši i ahireta. Razmišljanja i želja vezanih za ahiret. Da se liši lišavanja. I ostane u Jednosti. U toj osami insanu godi društvo. Godi mu društvo dragih ljudi, dobrih ljudi. Društvo dobrih, koji su postigli Jedinstvo u mnoštvu. Da se ogleda u njihovom primjeru, u predajama o tim dobrima. Da osjećaj nedostajanja dobrih nadomjesti sjećanjem na njih, kroz značenjski duboke i slojevite predaje o dobrima. Naravno, želim podvući kako ove predaje ne treba doživljavati doslovno, banalno, već kroz njihovu značenjsku slojevitost. Da bismo dobili nadahnuće, da bismo ih imali kao lučonoše svjetlosti Istine.\r\n\r\nKako u tezkirama – spomenicama dobrih budem nalazila predaje o ovim velikanima, o ovom dobrom društvu, ja ću neke od njih prepričati na bosanskom jeziku, i tako ih dovoditi u naše vrijeme i naš, bosanski jezik. E da nam ZNACI ostanu. I za prijatelja koji nam na dunjalučki nedostaje, a koji je, čini se, pripadao ovome društvu." },
                    { 3, new DateTime(2024, 9, 12, 0, 0, 0, 0, DateTimeKind.Unspecified), 0, 2, 1, "Islam i moderna nauka", "Ibn Haldun i filozofija historije\r\n\r\nU želji da koliko toliko upotpunimo predstavu o ortodoksnom stavu prema racionalnoj (modernoj) nauci u islamu obratit ćemo se na još jednog velikog učenjaka iz islamske tradicije sa izrazitim uticajem na modernu misao. Od kada su se krajem osamnaestog stoljeća, na Zapadu upoznali sa njegovim najpoznatijim djelom „Muqaddima“ („Uvod“), koji je uvod u njegovo historijsko djelo „Kitab al-'Ibar“, Ibn Haldun se konstantno označava pretečom moderne sociologije i filozofije povijesti. Izražen interes za proučavanje povijesti i društva koji se na Zapadu posebno razvio u moderno doba, povećao je interesovanje za ovog islamskog mislioca, dajući mu nerijetko status najvažnije ličnosti u historiji islamske misli.\r\n\r\nPosebno su izražena zapažanja da se Ibn Haldun svojim naučnim pristupom (i metodologijom u izvođenju stavova i zaključaka) izdvojio od, pa čak i suprostavio dotadašnjoj islamskoj tradicionalnoj filozofiji i nauci. Nama je u ovom tekstu Ibn Haldun važan iz nekoliko razloga.\r\n\r\nPrvo, zato što ne izlazeći iz okvira islamske ortodoksije baštini jedan (od el-Gazalija) racionalniji pristup islamskom svjetopogledu , pa želimo čuti i njegove stavove o modernoj nauci, posebno historiji. Drugi je razlog njegovo podrobnije bavljenje onim što se danas naziva društvena nauka, oblast koja nema centralno mjesto u el-Gazalijevom opusu. I treći razlog je da Ibn Haldun živi u vremenu u kojem je već moguć stanoviti historijski otklon od 'zlatnog doba' nauke u islamu, što mu daje mogućnost da istražuje uzroke stagnacije naučne aktivnosti." },
                    { 4, new DateTime(2024, 9, 12, 0, 0, 0, 0, DateTimeKind.Unspecified), 0, 2, 2, "U dobrom društvu", "Insanu godi osama. Da se liši dunjaluka, svega što ga vezuje za ovaj dunjaluk, da se liši jastva. Da se liši i ahireta. Razmišljanja i želja vezanih za ahiret. Da se liši lišavanja. I ostane u Jednosti. U toj osami insanu godi društvo. Godi mu društvo dragih ljudi, dobrih ljudi. Društvo dobrih, koji su postigli Jedinstvo u mnoštvu. Da se ogleda u njihovom primjeru, u predajama o tim dobrima. Da osjećaj nedostajanja dobrih nadomjesti sjećanjem na njih, kroz značenjski duboke i slojevite predaje o dobrima. Naravno, želim podvući kako ove predaje ne treba doživljavati doslovno, banalno, već kroz njihovu značenjsku slojevitost. Da bismo dobili nadahnuće, da bismo ih imali kao lučonoše svjetlosti Istine.\r\n\r\nKako u tezkirama – spomenicama dobrih budem nalazila predaje o ovim velikanima, o ovom dobrom društvu, ja ću neke od njih prepričati na bosanskom jeziku, i tako ih dovoditi u naše vrijeme i naš, bosanski jezik. E da nam ZNACI ostanu. I za prijatelja koji nam na dunjalučki nedostaje, a koji je, čini se, pripadao ovome društvu." },
                    { 5, new DateTime(2024, 9, 12, 0, 0, 0, 0, DateTimeKind.Unspecified), 0, 2, 3, "U dobrom društvu", "Insanu godi osama. Da se liši dunjaluka, svega što ga vezuje za ovaj dunjaluk, da se liši jastva. Da se liši i ahireta. Razmišljanja i želja vezanih za ahiret. Da se liši lišavanja. I ostane u Jednosti. U toj osami insanu godi društvo. Godi mu društvo dragih ljudi, dobrih ljudi. Društvo dobrih, koji su postigli Jedinstvo u mnoštvu. Da se ogleda u njihovom primjeru, u predajama o tim dobrima. Da osjećaj nedostajanja dobrih nadomjesti sjećanjem na njih, kroz značenjski duboke i slojevite predaje o dobrima. Naravno, želim podvući kako ove predaje ne treba doživljavati doslovno, banalno, već kroz njihovu značenjsku slojevitost. Da bismo dobili nadahnuće, da bismo ih imali kao lučonoše svjetlosti Istine.\r\n\r\nKako u tezkirama – spomenicama dobrih budem nalazila predaje o ovim velikanima, o ovom dobrom društvu, ja ću neke od njih prepričati na bosanskom jeziku, i tako ih dovoditi u naše vrijeme i naš, bosanski jezik. E da nam ZNACI ostanu. I za prijatelja koji nam na dunjalučki nedostaje, a koji je, čini se, pripadao ovome društvu." },
                    { 6, new DateTime(2024, 9, 12, 0, 0, 0, 0, DateTimeKind.Unspecified), 0, 2, 4, "U dobrom društvu", "Insanu godi osama. Da se liši dunjaluka, svega što ga vezuje za ovaj dunjaluk, da se liši jastva. Da se liši i ahireta. Razmišljanja i želja vezanih za ahiret. Da se liši lišavanja. I ostane u Jednosti. U toj osami insanu godi društvo. Godi mu društvo dragih ljudi, dobrih ljudi. Društvo dobrih, koji su postigli Jedinstvo u mnoštvu. Da se ogleda u njihovom primjeru, u predajama o tim dobrima. Da osjećaj nedostajanja dobrih nadomjesti sjećanjem na njih, kroz značenjski duboke i slojevite predaje o dobrima. Naravno, želim podvući kako ove predaje ne treba doživljavati doslovno, banalno, već kroz njihovu značenjsku slojevitost. Da bismo dobili nadahnuće, da bismo ih imali kao lučonoše svjetlosti Istine.\r\n\r\nKako u tezkirama – spomenicama dobrih budem nalazila predaje o ovim velikanima, o ovom dobrom društvu, ja ću neke od njih prepričati na bosanskom jeziku, i tako ih dovoditi u naše vrijeme i naš, bosanski jezik. E da nam ZNACI ostanu. I za prijatelja koji nam na dunjalučki nedostaje, a koji je, čini se, pripadao ovome društvu." },
                    { 7, new DateTime(2024, 9, 12, 0, 0, 0, 0, DateTimeKind.Unspecified), 0, 2, 5, "U dobrom društvu", "Insanu godi osama. Da se liši dunjaluka, svega što ga vezuje za ovaj dunjaluk, da se liši jastva. Da se liši i ahireta. Razmišljanja i želja vezanih za ahiret. Da se liši lišavanja. I ostane u Jednosti. U toj osami insanu godi društvo. Godi mu društvo dragih ljudi, dobrih ljudi. Društvo dobrih, koji su postigli Jedinstvo u mnoštvu. Da se ogleda u njihovom primjeru, u predajama o tim dobrima. Da osjećaj nedostajanja dobrih nadomjesti sjećanjem na njih, kroz značenjski duboke i slojevite predaje o dobrima. Naravno, želim podvući kako ove predaje ne treba doživljavati doslovno, banalno, već kroz njihovu značenjsku slojevitost. Da bismo dobili nadahnuće, da bismo ih imali kao lučonoše svjetlosti Istine.\r\n\r\nKako u tezkirama – spomenicama dobrih budem nalazila predaje o ovim velikanima, o ovom dobrom društvu, ja ću neke od njih prepričati na bosanskom jeziku, i tako ih dovoditi u naše vrijeme i naš, bosanski jezik. E da nam ZNACI ostanu. I za prijatelja koji nam na dunjalučki nedostaje, a koji je, čini se, pripadao ovome društvu." },
                    { 8, new DateTime(2024, 9, 12, 0, 0, 0, 0, DateTimeKind.Unspecified), 0, 2, 6, "U dobrom društvu", "Insanu godi osama. Da se liši dunjaluka, svega što ga vezuje za ovaj dunjaluk, da se liši jastva. Da se liši i ahireta. Razmišljanja i želja vezanih za ahiret. Da se liši lišavanja. I ostane u Jednosti. U toj osami insanu godi društvo. Godi mu društvo dragih ljudi, dobrih ljudi. Društvo dobrih, koji su postigli Jedinstvo u mnoštvu. Da se ogleda u njihovom primjeru, u predajama o tim dobrima. Da osjećaj nedostajanja dobrih nadomjesti sjećanjem na njih, kroz značenjski duboke i slojevite predaje o dobrima. Naravno, želim podvući kako ove predaje ne treba doživljavati doslovno, banalno, već kroz njihovu značenjsku slojevitost. Da bismo dobili nadahnuće, da bismo ih imali kao lučonoše svjetlosti Istine.\r\n\r\nKako u tezkirama – spomenicama dobrih budem nalazila predaje o ovim velikanima, o ovom dobrom društvu, ja ću neke od njih prepričati na bosanskom jeziku, i tako ih dovoditi u naše vrijeme i naš, bosanski jezik. E da nam ZNACI ostanu. I za prijatelja koji nam na dunjalučki nedostaje, a koji je, čini se, pripadao ovome društvu." }
                });

            migrationBuilder.InsertData(
                table: "Kamp",
                columns: new[] { "Id", "DatumPocetka", "DatumZavrsetka", "MektebId", "Naziv", "Opis", "Voditelj" },
                values: new object[,]
                {
                    { 1, new DateTime(2023, 8, 12, 0, 0, 0, 0, DateTimeKind.Unspecified), new DateTime(2023, 8, 20, 0, 0, 0, 0, DateTimeKind.Unspecified), 1, "Kamp 2023", "Kamp za sve polaznike mekteba. Bujrum!", "Imam dzemata" },
                    { 2, new DateTime(2024, 8, 12, 0, 0, 0, 0, DateTimeKind.Unspecified), new DateTime(2024, 8, 20, 0, 0, 0, 0, DateTimeKind.Unspecified), 1, "Kamp 2024", "Kamp za sve polaznike mekteba. Bujrum!", "Imam dzemata" }
                });

            migrationBuilder.InsertData(
                table: "Kategorija",
                columns: new[] { "Id", "Naziv", "Nivo", "TakmicenjeId" },
                values: new object[,]
                {
                    { 1, "Hifz", "1", 1 },
                    { 2, "Hifz", "2", 1 },
                    { 3, "Hifz", "3", 1 },
                    { 4, "Opće znanje", "1", 1 },
                    { 5, "Opće znanje", "2", 1 },
                    { 6, "Opće znanje", "3", 1 },
                    { 7, "Hifz", "1", 2 },
                    { 8, "Hifz", "2", 2 },
                    { 9, "Hifz", "3", 2 },
                    { 10, "Opće znanje", "1", 2 },
                    { 11, "Opće znanje", "2", 2 },
                    { 12, "Opće znanje", "3", 2 }
                });

            migrationBuilder.InsertData(
                table: "Korisnik",
                columns: new[] { "Id", "DatumRodjenja", "IdRazreda", "Ime", "ImeRoditelja", "LozinkaHash", "LozinkaSalt", "Mail", "MedzlisId", "MektebId", "MuftijstvoId", "NazivRazreda", "Prezime", "Prisustvo", "Prosjek", "RazredId", "RoditeljId", "Spol", "Status", "Telefon", "Username" },
                values: new object[,]
                {
                    { 1, new DateTime(1985, 9, 12, 0, 0, 0, 0, DateTimeKind.Unspecified), null, "Dino", "Mehmed", "dP9XoZcTTTU8f4ddDbNLJalRQqQ=", "jmK1d1xnmg2DC0svh3UvRw==", "dino@gmail.com", null, 1, null, null, "Maksumic", null, null, null, null, "M", "Aktivan", "063355441", "admin" },
                    { 2, new DateTime(1971, 9, 12, 0, 0, 0, 0, DateTimeKind.Unspecified), null, "Zijad", "Bajro", "z/sT0B+tdXeEL9SHGZRnuwLTq24=", "TojKLl0mMwNiLEbjjO9oZg==", "zijad@gmail.com", null, 1, null, null, "Maric", null, null, null, null, "M", "Aktivan", "062627878", "roditelj" },
                    { 4, new DateTime(1981, 9, 12, 0, 0, 0, 0, DateTimeKind.Unspecified), null, "Armin", "Aner", "AtSGH/z7qvkVdWoRnHgpVjtiw+M=", "XPD7niYAxH0Rify963NJDA==", "armin@gmail.com", null, 1, null, null, "Abaza", null, null, null, null, "M", "Aktivan", "062545121", "komisija" },
                    { 5, new DateTime(1989, 9, 12, 0, 0, 0, 0, DateTimeKind.Unspecified), null, "Atif", "Suad", "cKnCCVJWJjRXqM7XevrbN6B3RbM=", "cLnMQzMpSBWfc9nVetCRnw==", "atif@gmail.com", null, 1, null, null, "Mujkic", null, null, null, null, "M", "Aktivan", "062589989", "imam" },
                    { 7, new DateTime(1971, 9, 12, 0, 0, 0, 0, DateTimeKind.Unspecified), null, "Almir", "Salko", "bkLKbSxLPSFFmeMtQgdPC1AAnDQ=", "Gx+JkCnY/r169UVKD+dWYg==", "almir@gmail.com", null, 2, null, null, "Gosto", null, null, null, null, "M", "Aktivan", "062062062", "almir.gosto" },
                    { 11, new DateTime(1974, 9, 12, 0, 0, 0, 0, DateTimeKind.Unspecified), null, "Almir", "Halil", "QASszTjeeigPIi3z2Pco4Xz6z2A=", "SGEPRubCkiUhpIkgN1ICLA==", "almirL@gmail.com", null, 3, null, null, "Lizde", null, null, null, null, "M", "Aktivan", "063063063", "almir.lizde" },
                    { 15, new DateTime(1979, 9, 12, 0, 0, 0, 0, DateTimeKind.Unspecified), null, "Muamer", "Husein", "AtSGH/z7qvkVdWoRnHgpVjtiw+M=", "XPD7niYAxH0Rify963NJDA==", "muamer@gmail.com", null, 2, null, null, "Terko", null, null, null, null, "M", "Aktivan", "061061061", "muamer.terko" },
                    { 18, new DateTime(1979, 9, 12, 0, 0, 0, 0, DateTimeKind.Unspecified), null, "Omer", "Husein", "AtSGH/z7qvkVdWoRnHgpVjtiw+M=", "XPD7niYAxH0Rify963NJDA==", "omer@gmail.com", null, 1, null, null, "Brkan", null, null, null, null, "M", "Aktivan", "061222222", "omer.brkan" },
                    { 21, new DateTime(1979, 9, 12, 0, 0, 0, 0, DateTimeKind.Unspecified), null, "Samed", "Husein", "AtSGH/z7qvkVdWoRnHgpVjtiw+M=", "XPD7niYAxH0Rify963NJDA==", "samed@gmail.com", null, 3, null, null, "Kodrić", null, null, null, null, "M", "Aktivan", "061222333", "samed.kodric" },
                    { 24, new DateTime(2005, 9, 12, 0, 0, 0, 0, DateTimeKind.Unspecified), null, "Medzida", "Samed", "AtSGH/z7qvkVdWoRnHgpVjtiw+M=", "XPD7niYAxH0Rify963NJDA==", "medzida@gmail.com", null, 4, null, null, "Pehilj", null, null, null, null, "Ž", "Aktivan", "061061444", "medzida.pehilj" },
                    { 25, new DateTime(2006, 9, 12, 0, 0, 0, 0, DateTimeKind.Unspecified), null, "Bakir", "Samed", "AtSGH/z7qvkVdWoRnHgpVjtiw+M=", "XPD7niYAxH0Rify963NJDA==", "bakir@gmail.com", null, 4, null, null, "Pehilj", null, null, null, null, "M", "Aktivan", "061061444", "bakir.pehilj" },
                    { 26, new DateTime(2007, 8, 12, 0, 0, 0, 0, DateTimeKind.Unspecified), null, "Seid", "Samed", "AtSGH/z7qvkVdWoRnHgpVjtiw+M=", "XPD7niYAxH0Rify963NJDA==", "seid@gmail.com", null, 4, null, null, "Cikotić", null, null, null, null, "M", "Aktivan", "062062555", "seid.cikotic" },
                    { 27, new DateTime(2004, 9, 12, 0, 0, 0, 0, DateTimeKind.Unspecified), null, "Sajra", "Samed", "AtSGH/z7qvkVdWoRnHgpVjtiw+M=", "XPD7niYAxH0Rify963NJDA==", "sajra@gmail.com", null, 4, null, null, "Sarancic", null, null, null, null, "Ž", "Aktivan", "063555444", "sajra.sarancic" },
                    { 28, new DateTime(2004, 3, 17, 0, 0, 0, 0, DateTimeKind.Unspecified), null, "Amina", "Samed", "AtSGH/z7qvkVdWoRnHgpVjtiw+M=", "XPD7niYAxH0Rify963NJDA==", "amina@gmail.com", null, 5, null, null, "Čomor", null, null, null, null, "Ž", "Aktivan", "063212454", "amina.comor" },
                    { 29, new DateTime(2001, 1, 23, 0, 0, 0, 0, DateTimeKind.Unspecified), null, "Hana", "Samed", "AtSGH/z7qvkVdWoRnHgpVjtiw+M=", "XPD7niYAxH0Rify963NJDA==", "hana@gmail.com", null, 6, null, null, "Omerika", null, null, null, null, "Ž", "Aktivan", "061474851", "hana.omerika" },
                    { 30, new DateTime(2001, 3, 22, 0, 0, 0, 0, DateTimeKind.Unspecified), null, "Amil", "Samed", "AtSGH/z7qvkVdWoRnHgpVjtiw+M=", "XPD7niYAxH0Rify963NJDA==", "amil@gmail.com", null, 6, null, null, "Omerović", null, null, null, null, "M", "Aktivan", "061111444", "amil.omerovic" },
                    { 31, new DateTime(1989, 9, 12, 0, 0, 0, 0, DateTimeKind.Unspecified), null, "Muhjudin", "Suad", "cKnCCVJWJjRXqM7XevrbN6B3RbM=", "cLnMQzMpSBWfc9nVetCRnw==", "muhjudin@gmail.com", null, 2, null, null, "Bećoja", null, null, null, null, "M", "Aktivan", "062062581", "muhjudin" },
                    { 32, new DateTime(1999, 9, 12, 0, 0, 0, 0, DateTimeKind.Unspecified), null, "Sanjin", "Suad", "cKnCCVJWJjRXqM7XevrbN6B3RbM=", "cLnMQzMpSBWfc9nVetCRnw==", "sanjin@gmail.com", null, 3, null, null, "Šahić", null, null, null, null, "M", "Aktivan", "063212323", "sanjin.sahic" },
                    { 33, new DateTime(2000, 9, 12, 0, 0, 0, 0, DateTimeKind.Unspecified), null, "Muhamed", "Nazif", "cKnCCVJWJjRXqM7XevrbN6B3RbM=", "cLnMQzMpSBWfc9nVetCRnw==", "muhamed@gmail.com", null, 4, null, null, "Hasić", null, null, null, null, "M", "Aktivan", "062598777", "muhamed.hasic" },
                    { 34, new DateTime(2000, 9, 12, 0, 0, 0, 0, DateTimeKind.Unspecified), null, "Šefik", "Nazif", "cKnCCVJWJjRXqM7XevrbN6B3RbM=", "cLnMQzMpSBWfc9nVetCRnw==", "sefik@gmail.com", null, 5, null, null, "Čavčić", null, null, null, null, "M", "Aktivan", "062358474", "sefik.cavcic" },
                    { 35, new DateTime(1984, 9, 12, 0, 0, 0, 0, DateTimeKind.Unspecified), null, "Suljo", "Omer", "cKnCCVJWJjRXqM7XevrbN6B3RbM=", "cLnMQzMpSBWfc9nVetCRnw==", "suljo@gmail.com", null, 6, null, null, "Cikotić", null, null, null, null, "M", "Aktivan", "061222555", "suljo.cikotic" },
                    { 38, new DateTime(1954, 9, 12, 0, 0, 0, 0, DateTimeKind.Unspecified), null, "Seid", "Omer", "dP9XoZcTTTU8f4ddDbNLJalRQqQ=", "jmK1d1xnmg2DC0svh3UvRw==", "superadmin@gmail.com", null, 6, null, null, "Smajkić", null, null, null, null, "M", "Aktivan", "061222555", "superadmin" }
                });

            migrationBuilder.InsertData(
                table: "Obavijest",
                columns: new[] { "Id", "DatumObjave", "MektebId", "Naslov", "Opis", "StateMachine", "VrstaObjave" },
                values: new object[,]
                {
                    { 1, new DateTime(2024, 9, 12, 0, 0, 0, 0, DateTimeKind.Unspecified), 1, "eMekteb aplikacija ", "Dobrodošli na novu platformu za mektebsku nastavu, nadamo se da cete uzivati u koristenju i da će vam koristiti u sticanju korisnog znanja. \r\nHairli vam bila nova mektebska godina!", "active", "Obavijest" },
                    { 2, new DateTime(2024, 9, 12, 0, 0, 0, 0, DateTimeKind.Unspecified), 1, "Promijeni password!", "Radi sigurnosti i pristupa aplikaciji napravite novi password.", "active", "Obavijest" },
                    { 3, new DateTime(2024, 9, 12, 0, 0, 0, 0, DateTimeKind.Unspecified), 2, "eMekteb aplikacija ", "Dobrodošli na novu platformu za mektebsku nastavu, nadamo se da cete uzivati u koristenju i da će vam koristiti u sticanju korisnog znanja. \r\nHairli vam bila nova mektebska godina!", "active", "Obavijest" },
                    { 4, new DateTime(2024, 9, 12, 0, 0, 0, 0, DateTimeKind.Unspecified), 2, "Promijeni password!", "Radi sigurnosti i pristupa aplikaciji napravite novi password.", "active", "Obavijest" },
                    { 5, new DateTime(2024, 9, 12, 0, 0, 0, 0, DateTimeKind.Unspecified), 3, "eMekteb aplikacija ", "Dobrodošli na novu platformu za mektebsku nastavu, nadamo se da cete uzivati u koristenju i da će vam koristiti u sticanju korisnog znanja. \r\nHairli vam bila nova mektebska godina!", "active", "Obavijest" },
                    { 6, new DateTime(2024, 9, 12, 0, 0, 0, 0, DateTimeKind.Unspecified), 3, "Promijeni password!", "Radi sigurnosti i pristupa aplikaciji napravite novi password.", "active", "Obavijest" },
                    { 7, new DateTime(2024, 9, 12, 0, 0, 0, 0, DateTimeKind.Unspecified), 4, "eMekteb aplikacija ", "Dobrodošli na novu platformu za mektebsku nastavu, nadamo se da cete uzivati u koristenju i da će vam koristiti u sticanju korisnog znanja. \r\nHairli vam bila nova mektebska godina!", "active", "Obavijest" },
                    { 8, new DateTime(2024, 9, 12, 0, 0, 0, 0, DateTimeKind.Unspecified), 4, "Promijeni password!", "Radi sigurnosti i pristupa aplikaciji napravite novi password.", "active", "Obavijest" },
                    { 9, new DateTime(2024, 9, 12, 0, 0, 0, 0, DateTimeKind.Unspecified), 5, "eMekteb aplikacija ", "Dobrodošli na novu platformu za mektebsku nastavu, nadamo se da cete uzivati u koristenju i da će vam koristiti u sticanju korisnog znanja. \r\nHairli vam bila nova mektebska godina!", "active", "Obavijest" },
                    { 10, new DateTime(2024, 9, 12, 0, 0, 0, 0, DateTimeKind.Unspecified), 5, "Promijeni password!", "Radi sigurnosti i pristupa aplikaciji napravite novi password.", "active", "Obavijest" },
                    { 11, new DateTime(2024, 9, 12, 0, 0, 0, 0, DateTimeKind.Unspecified), 6, "eMekteb aplikacija ", "Dobrodošli na novu platformu za mektebsku nastavu, nadamo se da cete uzivati u koristenju i da će vam koristiti u sticanju korisnog znanja. \r\nHairli vam bila nova mektebska godina!", "active", "Obavijest" },
                    { 12, new DateTime(2024, 9, 12, 0, 0, 0, 0, DateTimeKind.Unspecified), 6, "Promijeni password!", "Radi sigurnosti i pristupa aplikaciji napravite novi password.", "active", "Obavijest" }
                });

            migrationBuilder.InsertData(
                table: "Razred",
                columns: new[] { "Id", "MektebId", "Naziv" },
                values: new object[,]
                {
                    { 1, 1, "I nivo" },
                    { 2, 1, "II nivo" },
                    { 3, 1, "III nivo" },
                    { 4, 1, "Sufara" },
                    { 5, 1, "Tedžvid" },
                    { 6, 1, "Hatma" },
                    { 7, 2, "I nivo" },
                    { 8, 2, "II nivo" },
                    { 9, 2, "III nivo" },
                    { 10, 2, "Sufara" },
                    { 11, 2, "Tedžvid" },
                    { 12, 2, "Hatma" },
                    { 13, 3, "I nivo" },
                    { 14, 3, "II nivo" },
                    { 15, 3, "III nivo" },
                    { 16, 3, "Sufara" },
                    { 17, 3, "Tedžvid" },
                    { 18, 3, "Hatma" },
                    { 19, 4, "I nivo" },
                    { 20, 4, "II nivo" },
                    { 21, 4, "III nivo" },
                    { 22, 4, "Sufara" },
                    { 23, 4, "Tedžvid" },
                    { 24, 4, "Hatma" },
                    { 25, 5, "I nivo" },
                    { 26, 5, "II nivo" },
                    { 27, 5, "III nivo" },
                    { 28, 5, "Sufara" },
                    { 29, 5, "Tedžvid" },
                    { 30, 5, "Hatma" },
                    { 31, 6, "I nivo" },
                    { 32, 6, "II nivo" },
                    { 33, 6, "III nivo" },
                    { 34, 6, "Sufara" },
                    { 35, 6, "Tedžvid" },
                    { 36, 6, "Hatma" }
                });

            migrationBuilder.InsertData(
                table: "AkademskaRazred",
                columns: new[] { "Id", "AkademskaGodinaId", "RazredId" },
                values: new object[,]
                {
                    { 1, 1, 1 },
                    { 2, 1, 3 },
                    { 3, 1, 2 },
                    { 4, 1, 4 },
                    { 5, 1, 5 },
                    { 6, 1, 6 },
                    { 7, 1, 7 },
                    { 8, 1, 8 },
                    { 9, 1, 9 },
                    { 10, 1, 10 },
                    { 11, 1, 11 },
                    { 12, 1, 12 },
                    { 13, 1, 13 },
                    { 14, 1, 14 },
                    { 15, 1, 15 },
                    { 16, 1, 16 },
                    { 17, 1, 17 },
                    { 18, 2, 1 },
                    { 19, 2, 2 },
                    { 20, 2, 3 },
                    { 21, 2, 4 },
                    { 22, 2, 5 },
                    { 23, 2, 6 },
                    { 24, 2, 7 },
                    { 25, 2, 8 },
                    { 26, 2, 9 },
                    { 27, 2, 10 },
                    { 28, 2, 11 },
                    { 29, 2, 12 },
                    { 30, 2, 13 },
                    { 31, 2, 14 },
                    { 32, 2, 15 },
                    { 33, 2, 16 },
                    { 34, 2, 17 },
                    { 35, 2, 18 },
                    { 36, 2, 19 },
                    { 37, 2, 20 },
                    { 38, 2, 21 },
                    { 39, 1, 18 },
                    { 40, 2, 22 },
                    { 41, 2, 23 },
                    { 42, 2, 24 },
                    { 43, 3, 1 },
                    { 44, 3, 2 },
                    { 45, 3, 3 },
                    { 46, 3, 4 },
                    { 47, 3, 5 },
                    { 48, 3, 6 },
                    { 49, 3, 7 },
                    { 50, 3, 8 },
                    { 51, 3, 9 },
                    { 52, 3, 10 },
                    { 53, 3, 11 },
                    { 54, 3, 12 },
                    { 55, 3, 13 },
                    { 56, 3, 14 },
                    { 57, 3, 15 },
                    { 58, 3, 16 },
                    { 59, 3, 17 },
                    { 60, 3, 18 },
                    { 61, 3, 19 },
                    { 62, 3, 20 },
                    { 63, 3, 21 },
                    { 64, 3, 22 },
                    { 65, 3, 23 },
                    { 66, 3, 24 },
                    { 67, 3, 25 },
                    { 68, 3, 26 },
                    { 69, 3, 27 },
                    { 70, 3, 28 },
                    { 71, 3, 29 },
                    { 72, 3, 30 },
                    { 73, 3, 31 },
                    { 74, 3, 32 },
                    { 75, 3, 33 },
                    { 76, 3, 34 },
                    { 77, 3, 35 },
                    { 78, 3, 36 }
                });

            migrationBuilder.InsertData(
                table: "KorisniciUloge",
                columns: new[] { "Id", "DatumIzmjene", "KorisnikId", "UlogaId" },
                values: new object[,]
                {
                    { 1, new DateTime(2024, 8, 20, 0, 0, 0, 0, DateTimeKind.Unspecified), 1, 1 },
                    { 2, new DateTime(2024, 8, 20, 0, 0, 0, 0, DateTimeKind.Unspecified), 2, 4 },
                    { 4, new DateTime(2024, 8, 20, 0, 0, 0, 0, DateTimeKind.Unspecified), 4, 5 },
                    { 5, new DateTime(2024, 8, 20, 0, 0, 0, 0, DateTimeKind.Unspecified), 5, 3 },
                    { 6, new DateTime(2024, 8, 20, 0, 0, 0, 0, DateTimeKind.Unspecified), 7, 4 },
                    { 7, new DateTime(2024, 8, 20, 0, 0, 0, 0, DateTimeKind.Unspecified), 11, 4 },
                    { 8, new DateTime(2024, 8, 20, 0, 0, 0, 0, DateTimeKind.Unspecified), 15, 4 },
                    { 9, new DateTime(2024, 8, 20, 0, 0, 0, 0, DateTimeKind.Unspecified), 18, 4 },
                    { 10, new DateTime(2024, 8, 20, 0, 0, 0, 0, DateTimeKind.Unspecified), 21, 4 },
                    { 24, new DateTime(2024, 8, 20, 0, 0, 0, 0, DateTimeKind.Unspecified), 24, 2 },
                    { 25, new DateTime(2024, 8, 20, 0, 0, 0, 0, DateTimeKind.Unspecified), 25, 2 },
                    { 26, new DateTime(2024, 8, 20, 0, 0, 0, 0, DateTimeKind.Unspecified), 26, 2 },
                    { 27, new DateTime(2024, 8, 20, 0, 0, 0, 0, DateTimeKind.Unspecified), 27, 2 },
                    { 28, new DateTime(2024, 8, 20, 0, 0, 0, 0, DateTimeKind.Unspecified), 28, 2 },
                    { 29, new DateTime(2024, 8, 20, 0, 0, 0, 0, DateTimeKind.Unspecified), 29, 2 },
                    { 30, new DateTime(2024, 8, 20, 0, 0, 0, 0, DateTimeKind.Unspecified), 30, 2 },
                    { 31, new DateTime(2024, 8, 20, 0, 0, 0, 0, DateTimeKind.Unspecified), 31, 3 },
                    { 32, new DateTime(2024, 8, 20, 0, 0, 0, 0, DateTimeKind.Unspecified), 32, 3 },
                    { 33, new DateTime(2024, 8, 20, 0, 0, 0, 0, DateTimeKind.Unspecified), 33, 3 },
                    { 34, new DateTime(2024, 8, 20, 0, 0, 0, 0, DateTimeKind.Unspecified), 34, 3 },
                    { 35, new DateTime(2024, 8, 20, 0, 0, 0, 0, DateTimeKind.Unspecified), 35, 3 },
                    { 38, new DateTime(2024, 8, 20, 0, 0, 0, 0, DateTimeKind.Unspecified), 38, 6 }
                });

            migrationBuilder.InsertData(
                table: "Korisnik",
                columns: new[] { "Id", "DatumRodjenja", "IdRazreda", "Ime", "ImeRoditelja", "LozinkaHash", "LozinkaSalt", "Mail", "MedzlisId", "MektebId", "MuftijstvoId", "NazivRazreda", "Prezime", "Prisustvo", "Prosjek", "RazredId", "RoditeljId", "Spol", "Status", "Telefon", "Username" },
                values: new object[,]
                {
                    { 3, new DateTime(2001, 9, 12, 0, 0, 0, 0, DateTimeKind.Unspecified), null, "Lejla", "Zijad", "YumKKJBN/A/I4N5FUZAQiS+GsKU=", "sDj4ejrFF0VUWuf3Z86EAg==", "lejla@gmail.com", null, 1, null, null, "Maric", null, null, null, 2, "Ž", "Aktivan", "062627878", "ucenik" },
                    { 6, new DateTime(2003, 9, 12, 0, 0, 0, 0, DateTimeKind.Unspecified), null, "Sadzid", "Zijad", "ScUPKxksw9aYsTBy3ONHNtiP/pQ=", "iHcegpYjjbOop1BEsE3Rtg==", "sadzid@gmail.com", null, 1, null, null, "Maric", null, null, null, 2, "M", "Aktivan", "062627878", "sadzid" },
                    { 8, new DateTime(2001, 9, 12, 0, 0, 0, 0, DateTimeKind.Unspecified), null, "Omer", "Almir", "LCG4lHMiiZiASdZwtCYMsGxbIoc=", "lTkuZDGh2IQr66IeRWnkIA==", "omer@gmail.com", null, 2, null, null, "Gosto", null, null, null, 7, "M", "Aktivan", "062062062", "omer" },
                    { 9, new DateTime(2003, 9, 12, 0, 0, 0, 0, DateTimeKind.Unspecified), null, "Nejra", "Almir", "YumKKJBN/A/I4N5FUZAQiS+GsKU=", "sDj4ejrFF0VUWuf3Z86EAg==", "nejra@gmail.com", null, 2, null, null, "Gosto", null, null, null, 7, "Ž", "Aktivan", "062062062", "nejra" },
                    { 10, new DateTime(2005, 9, 12, 0, 0, 0, 0, DateTimeKind.Unspecified), null, "Amer", "Almir", "YumKKJBN/A/I4N5FUZAQiS+GsKU=", "sDj4ejrFF0VUWuf3Z86EAg==", "amer@gmail.com", null, 2, null, null, "Gosto", null, null, null, 7, "Ž", "Aktivan", "062062062", "amer" },
                    { 12, new DateTime(2009, 9, 12, 0, 0, 0, 0, DateTimeKind.Unspecified), null, "Madzid", "Almir", "/VHd1Q8gLYi2VggsmwT3ruCAqJk=", "HzWzHz3sQE9LK4+jteknTA==", "madzid@gmail.com", null, 3, null, null, "Lizde", null, null, null, 11, "M", "Aktivan", "063063063", "madzid" },
                    { 13, new DateTime(2008, 9, 12, 0, 0, 0, 0, DateTimeKind.Unspecified), null, "Hazim", "Almir", "YumKKJBN/A/I4N5FUZAQiS+GsKU=", "sDj4ejrFF0VUWuf3Z86EAg==", "hazim@gmail.com", null, 3, null, null, "Lizde", null, null, null, 11, "M", "Aktivan", "063063063", "hazim" },
                    { 14, new DateTime(2000, 9, 12, 0, 0, 0, 0, DateTimeKind.Unspecified), null, "Alma", "Almir", "YumKKJBN/A/I4N5FUZAQiS+GsKU=", "sDj4ejrFF0VUWuf3Z86EAg==", "almal@gmail.com", null, 3, null, null, "Lizde", null, null, null, 11, "Ž", "Aktivan", "063063063", "alma.lizde" },
                    { 16, new DateTime(2007, 9, 12, 0, 0, 0, 0, DateTimeKind.Unspecified), null, "Iman", "Muamer", "5SBNe56lKlnvUcxOHVIpujXsv5g=", "+HLQg+K0DVk1praxlrTU3g==", "imant@gmail.com", null, 2, null, null, "Terko", null, null, null, 15, "Ž", "Aktivan", "061061061", "iman.terko" },
                    { 17, new DateTime(2002, 9, 12, 0, 0, 0, 0, DateTimeKind.Unspecified), null, "Emina", "Muamer", "YumKKJBN/A/I4N5FUZAQiS+GsKU=", "sDj4ejrFF0VUWuf3Z86EAg==", "emina@gmail.com", null, 2, null, null, "Terko", null, null, null, 15, "Ž", "Aktivan", "061061061", "emina.terko" },
                    { 19, new DateTime(2002, 6, 14, 0, 0, 0, 0, DateTimeKind.Unspecified), null, "Voljevica", "Omer", "AtSGH/z7qvkVdWoRnHgpVjtiw+M=", "XPD7niYAxH0Rify963NJDA==", "kenan@gmail.com", null, 1, null, null, "Kenan", null, null, null, 18, "M", "Aktivan", "061222222", "kenan.voljevica" },
                    { 20, new DateTime(2004, 3, 17, 0, 0, 0, 0, DateTimeKind.Unspecified), null, "Nejra", "Omer", "AtSGH/z7qvkVdWoRnHgpVjtiw+M=", "XPD7niYAxH0Rify963NJDA==", "nejra@gmail.com", null, 1, null, null, "Brkan", null, null, null, 18, "M", "Aktivan", "061222222", "nejra.brkan" },
                    { 22, new DateTime(2001, 9, 12, 0, 0, 0, 0, DateTimeKind.Unspecified), null, "Ahmet", "Samed", "AtSGH/z7qvkVdWoRnHgpVjtiw+M=", "XPD7niYAxH0Rify963NJDA==", "ahmet@gmail.com", null, 3, null, null, "Kodrić", null, null, null, 21, "M", "Aktivan", "061222333", "ahmet.kodric" },
                    { 23, new DateTime(2006, 9, 12, 0, 0, 0, 0, DateTimeKind.Unspecified), null, "Elma", "Samed", "AtSGH/z7qvkVdWoRnHgpVjtiw+M=", "XPD7niYAxH0Rify963NJDA==", "elma@gmail.com", null, 3, null, null, "Kodrić", null, null, null, 21, "Ž", "Aktivan", "061222333", "elma.kodric" },
                    { 36, new DateTime(2000, 9, 12, 0, 0, 0, 0, DateTimeKind.Unspecified), null, "Anadin", "Omer", "AtSGH/z7qvkVdWoRnHgpVjtiw+M=", "XPD7niYAxH0Rify963NJDA==", "anadin@gmail.com", null, 1, null, null, "Brkan", null, null, null, 18, "M", "Aktivan", "061222222", "anadin.brkan" },
                    { 37, new DateTime(2008, 9, 12, 0, 0, 0, 0, DateTimeKind.Unspecified), null, "Zaim", "Omer", "AtSGH/z7qvkVdWoRnHgpVjtiw+M=", "XPD7niYAxH0Rify963NJDA==", "zaim@gmail.com", null, 1, null, null, "Brkan", null, null, null, 18, "M", "Aktivan", "061222222", "zaim.brkan" }
                });

            migrationBuilder.InsertData(
                table: "Prisustvo",
                columns: new[] { "Id", "CasId", "Datum", "KorisnikId", "Prisutan", "RazredId" },
                values: new object[,]
                {
                    { 28, 19, new DateTime(2024, 9, 12, 0, 0, 0, 0, DateTimeKind.Unspecified), 24, true, 21 },
                    { 29, 19, new DateTime(2024, 9, 12, 0, 0, 0, 0, DateTimeKind.Unspecified), 25, true, 21 },
                    { 30, 19, new DateTime(2024, 9, 12, 0, 0, 0, 0, DateTimeKind.Unspecified), 26, true, 21 },
                    { 31, 19, new DateTime(2024, 9, 12, 0, 0, 0, 0, DateTimeKind.Unspecified), 27, true, 22 },
                    { 32, 20, new DateTime(2024, 9, 12, 0, 0, 0, 0, DateTimeKind.Unspecified), 29, true, 33 },
                    { 33, 21, new DateTime(2024, 9, 12, 0, 0, 0, 0, DateTimeKind.Unspecified), 30, true, 35 },
                    { 34, 19, new DateTime(2024, 9, 12, 0, 0, 0, 0, DateTimeKind.Unspecified), 28, true, 27 }
                });

            migrationBuilder.InsertData(
                table: "RazredKorisnik",
                columns: new[] { "Id", "DatumUpisa", "KorisnikId", "RazredId" },
                values: new object[,]
                {
                    { 40, new DateTime(2024, 9, 12, 0, 0, 0, 0, DateTimeKind.Unspecified), 24, 19 },
                    { 41, new DateTime(2024, 9, 12, 0, 0, 0, 0, DateTimeKind.Unspecified), 24, 20 },
                    { 42, new DateTime(2024, 9, 12, 0, 0, 0, 0, DateTimeKind.Unspecified), 24, 21 },
                    { 43, new DateTime(2024, 9, 12, 0, 0, 0, 0, DateTimeKind.Unspecified), 25, 20 },
                    { 44, new DateTime(2024, 9, 12, 0, 0, 0, 0, DateTimeKind.Unspecified), 25, 21 },
                    { 45, new DateTime(2024, 9, 12, 0, 0, 0, 0, DateTimeKind.Unspecified), 25, 22 },
                    { 46, new DateTime(2024, 9, 12, 0, 0, 0, 0, DateTimeKind.Unspecified), 26, 21 },
                    { 47, new DateTime(2024, 9, 12, 0, 0, 0, 0, DateTimeKind.Unspecified), 26, 22 },
                    { 48, new DateTime(2024, 9, 12, 0, 0, 0, 0, DateTimeKind.Unspecified), 26, 23 },
                    { 49, new DateTime(2024, 9, 12, 0, 0, 0, 0, DateTimeKind.Unspecified), 27, 22 },
                    { 50, new DateTime(2024, 9, 12, 0, 0, 0, 0, DateTimeKind.Unspecified), 27, 23 },
                    { 51, new DateTime(2024, 9, 12, 0, 0, 0, 0, DateTimeKind.Unspecified), 27, 24 },
                    { 52, new DateTime(2024, 9, 12, 0, 0, 0, 0, DateTimeKind.Unspecified), 28, 25 },
                    { 53, new DateTime(2023, 9, 12, 0, 0, 0, 0, DateTimeKind.Unspecified), 28, 26 },
                    { 54, new DateTime(2024, 9, 12, 0, 0, 0, 0, DateTimeKind.Unspecified), 28, 27 },
                    { 55, new DateTime(2024, 9, 12, 0, 0, 0, 0, DateTimeKind.Unspecified), 29, 31 },
                    { 56, new DateTime(2023, 9, 12, 0, 0, 0, 0, DateTimeKind.Unspecified), 29, 32 },
                    { 57, new DateTime(2024, 9, 12, 0, 0, 0, 0, DateTimeKind.Unspecified), 29, 33 },
                    { 58, new DateTime(2024, 9, 12, 0, 0, 0, 0, DateTimeKind.Unspecified), 30, 33 },
                    { 59, new DateTime(2024, 9, 12, 0, 0, 0, 0, DateTimeKind.Unspecified), 30, 34 },
                    { 60, new DateTime(2024, 9, 12, 0, 0, 0, 0, DateTimeKind.Unspecified), 30, 35 }
                });

            migrationBuilder.InsertData(
                table: "Takmicar",
                columns: new[] { "Id", "DatumRodjenja", "Ime", "KategorijaId", "Prezime", "UkupnoBodova" },
                values: new object[,]
                {
                    { 1, new DateTime(2000, 2, 1, 0, 0, 0, 0, DateTimeKind.Unspecified), "Lejla", 1, "Marić", 15 },
                    { 2, new DateTime(2001, 2, 1, 0, 0, 0, 0, DateTimeKind.Unspecified), "Zejd", 2, "Marić", 17 },
                    { 3, new DateTime(2001, 2, 1, 0, 0, 0, 0, DateTimeKind.Unspecified), "Sadzid", 2, "Marić", 15 },
                    { 4, new DateTime(2002, 2, 1, 0, 0, 0, 0, DateTimeKind.Unspecified), "Amna", 3, "Baralija", 17 },
                    { 5, new DateTime(2002, 2, 1, 0, 0, 0, 0, DateTimeKind.Unspecified), "Selma", 3, "Bučuk", 16 },
                    { 6, new DateTime(2000, 2, 1, 0, 0, 0, 0, DateTimeKind.Unspecified), "Kenan", 4, "Baralija", 15 },
                    { 7, new DateTime(2001, 2, 1, 0, 0, 0, 0, DateTimeKind.Unspecified), "Osman", 5, "Brkan", 14 },
                    { 8, new DateTime(2002, 2, 1, 0, 0, 0, 0, DateTimeKind.Unspecified), "Amar", 6, "Brkan", 13 },
                    { 9, new DateTime(2000, 2, 1, 0, 0, 0, 0, DateTimeKind.Unspecified), "Lejla", 7, "Marić", 14 },
                    { 10, new DateTime(2000, 2, 1, 0, 0, 0, 0, DateTimeKind.Unspecified), "Hasan", 7, "Gološ", 15 },
                    { 11, new DateTime(2001, 2, 1, 0, 0, 0, 0, DateTimeKind.Unspecified), "Zejd", 8, "Marić", 16 },
                    { 12, new DateTime(2001, 2, 1, 0, 0, 0, 0, DateTimeKind.Unspecified), "Sadzid", 8, "Marić", 17 },
                    { 13, new DateTime(2000, 2, 1, 0, 0, 0, 0, DateTimeKind.Unspecified), "Hasan", 1, "Gološ", 14 },
                    { 14, new DateTime(2002, 2, 1, 0, 0, 0, 0, DateTimeKind.Unspecified), "Selma", 9, "Bučuk", 15 },
                    { 15, new DateTime(2000, 2, 1, 0, 0, 0, 0, DateTimeKind.Unspecified), "Kenan", 10, "Baralija", 16 },
                    { 16, new DateTime(2001, 2, 1, 0, 0, 0, 0, DateTimeKind.Unspecified), "Osman", 10, "Brkan", 14 },
                    { 17, new DateTime(2002, 2, 1, 0, 0, 0, 0, DateTimeKind.Unspecified), "Amar", 11, "Brkan", 15 },
                    { 18, new DateTime(2002, 2, 1, 0, 0, 0, 0, DateTimeKind.Unspecified), "Salih", 12, "Marić", 11 },
                    { 19, new DateTime(2000, 2, 1, 0, 0, 0, 0, DateTimeKind.Unspecified), "Ruvejda", 7, "Kaminić", 12 },
                    { 20, new DateTime(2002, 2, 1, 0, 0, 0, 0, DateTimeKind.Unspecified), "Amna", 9, "Baralija", 14 }
                });

            migrationBuilder.InsertData(
                table: "Zadaca",
                columns: new[] { "Id", "DatumDodjele", "KorisnikId", "Lekcija", "OcjeneId", "RazredId", "ZaZadacu" },
                values: new object[,]
                {
                    { 28, new DateTime(2024, 9, 12, 0, 0, 0, 0, DateTimeKind.Unspecified), 24, "Rabbijesir", 2, 21, "Krupno R" },
                    { 29, new DateTime(2024, 9, 12, 0, 0, 0, 0, DateTimeKind.Unspecified), 25, "Rabbijesir", 3, 21, "Krupno R" },
                    { 30, new DateTime(2024, 9, 12, 0, 0, 0, 0, DateTimeKind.Unspecified), 26, "Rabbijesir", 2, 21, "Krupno R" },
                    { 31, new DateTime(2024, 9, 12, 0, 0, 0, 0, DateTimeKind.Unspecified), 28, "Rabbijesir", 1, 27, "Krupno R" },
                    { 32, new DateTime(2024, 9, 12, 0, 0, 0, 0, DateTimeKind.Unspecified), 29, "Rabbijesir", 1, 33, "Krupno R" },
                    { 33, new DateTime(2024, 9, 12, 0, 0, 0, 0, DateTimeKind.Unspecified), 30, "Rabbijesir", 1, 35, "Krupno R" }
                });

            migrationBuilder.InsertData(
                table: "KampKorisnik",
                columns: new[] { "Id", "DatumDodavanja", "KampId", "KorisnikId" },
                values: new object[,]
                {
                    { 1, new DateTime(2024, 8, 15, 0, 0, 0, 0, DateTimeKind.Unspecified), 1, 6 },
                    { 2, new DateTime(2024, 8, 15, 0, 0, 0, 0, DateTimeKind.Unspecified), 1, 19 },
                    { 3, new DateTime(2024, 8, 15, 0, 0, 0, 0, DateTimeKind.Unspecified), 1, 20 },
                    { 4, new DateTime(2024, 8, 15, 0, 0, 0, 0, DateTimeKind.Unspecified), 1, 36 },
                    { 5, new DateTime(2024, 8, 15, 0, 0, 0, 0, DateTimeKind.Unspecified), 1, 37 },
                    { 6, new DateTime(2024, 8, 15, 0, 0, 0, 0, DateTimeKind.Unspecified), 2, 6 },
                    { 7, new DateTime(2024, 8, 15, 0, 0, 0, 0, DateTimeKind.Unspecified), 2, 19 },
                    { 8, new DateTime(2024, 8, 15, 0, 0, 0, 0, DateTimeKind.Unspecified), 2, 20 },
                    { 9, new DateTime(2024, 8, 15, 0, 0, 0, 0, DateTimeKind.Unspecified), 2, 36 },
                    { 10, new DateTime(2024, 8, 15, 0, 0, 0, 0, DateTimeKind.Unspecified), 2, 37 }
                });

            migrationBuilder.InsertData(
                table: "KorisniciUloge",
                columns: new[] { "Id", "DatumIzmjene", "KorisnikId", "UlogaId" },
                values: new object[,]
                {
                    { 3, new DateTime(2024, 8, 20, 0, 0, 0, 0, DateTimeKind.Unspecified), 3, 2 },
                    { 11, new DateTime(2024, 8, 20, 0, 0, 0, 0, DateTimeKind.Unspecified), 6, 2 },
                    { 12, new DateTime(2024, 8, 20, 0, 0, 0, 0, DateTimeKind.Unspecified), 8, 2 },
                    { 13, new DateTime(2024, 8, 20, 0, 0, 0, 0, DateTimeKind.Unspecified), 9, 2 },
                    { 14, new DateTime(2024, 8, 20, 0, 0, 0, 0, DateTimeKind.Unspecified), 10, 2 },
                    { 15, new DateTime(2024, 8, 20, 0, 0, 0, 0, DateTimeKind.Unspecified), 12, 2 },
                    { 16, new DateTime(2024, 8, 20, 0, 0, 0, 0, DateTimeKind.Unspecified), 13, 2 },
                    { 17, new DateTime(2024, 8, 20, 0, 0, 0, 0, DateTimeKind.Unspecified), 14, 2 },
                    { 18, new DateTime(2024, 8, 20, 0, 0, 0, 0, DateTimeKind.Unspecified), 16, 2 },
                    { 19, new DateTime(2024, 8, 20, 0, 0, 0, 0, DateTimeKind.Unspecified), 17, 2 },
                    { 20, new DateTime(2024, 8, 20, 0, 0, 0, 0, DateTimeKind.Unspecified), 19, 2 },
                    { 21, new DateTime(2024, 8, 20, 0, 0, 0, 0, DateTimeKind.Unspecified), 20, 2 },
                    { 22, new DateTime(2024, 8, 20, 0, 0, 0, 0, DateTimeKind.Unspecified), 22, 2 },
                    { 23, new DateTime(2024, 8, 20, 0, 0, 0, 0, DateTimeKind.Unspecified), 23, 2 },
                    { 36, new DateTime(2024, 8, 20, 0, 0, 0, 0, DateTimeKind.Unspecified), 36, 2 },
                    { 37, new DateTime(2024, 8, 20, 0, 0, 0, 0, DateTimeKind.Unspecified), 37, 2 }
                });

            migrationBuilder.InsertData(
                table: "Prisustvo",
                columns: new[] { "Id", "CasId", "Datum", "KorisnikId", "Prisutan", "RazredId" },
                values: new object[,]
                {
                    { 1, 1, new DateTime(2024, 9, 12, 0, 0, 0, 0, DateTimeKind.Unspecified), 3, true, 1 },
                    { 2, 2, new DateTime(2024, 9, 13, 0, 0, 0, 0, DateTimeKind.Unspecified), 3, true, 1 },
                    { 3, 3, new DateTime(2024, 9, 18, 0, 0, 0, 0, DateTimeKind.Unspecified), 3, true, 1 },
                    { 4, 4, new DateTime(2024, 9, 19, 0, 0, 0, 0, DateTimeKind.Unspecified), 3, true, 2 },
                    { 5, 5, new DateTime(2024, 9, 20, 0, 0, 0, 0, DateTimeKind.Unspecified), 3, true, 2 },
                    { 6, 6, new DateTime(2024, 9, 27, 0, 0, 0, 0, DateTimeKind.Unspecified), 3, true, 2 },
                    { 7, 7, new DateTime(2024, 9, 28, 0, 0, 0, 0, DateTimeKind.Unspecified), 3, false, 2 },
                    { 8, 3, new DateTime(2024, 9, 12, 0, 0, 0, 0, DateTimeKind.Unspecified), 3, true, 3 },
                    { 9, 2, new DateTime(2024, 9, 12, 0, 0, 0, 0, DateTimeKind.Unspecified), 3, true, 3 },
                    { 10, 5, new DateTime(2024, 9, 12, 0, 0, 0, 0, DateTimeKind.Unspecified), 3, true, 3 },
                    { 11, 3, new DateTime(2024, 9, 12, 0, 0, 0, 0, DateTimeKind.Unspecified), 6, false, 3 },
                    { 12, 4, new DateTime(2024, 9, 12, 0, 0, 0, 0, DateTimeKind.Unspecified), 19, true, 3 },
                    { 13, 2, new DateTime(2024, 9, 12, 0, 0, 0, 0, DateTimeKind.Unspecified), 20, true, 4 },
                    { 14, 2, new DateTime(2023, 9, 12, 0, 0, 0, 0, DateTimeKind.Unspecified), 36, false, 1 },
                    { 15, 3, new DateTime(2024, 9, 12, 0, 0, 0, 0, DateTimeKind.Unspecified), 37, true, 2 },
                    { 16, 6, new DateTime(2024, 9, 12, 0, 0, 0, 0, DateTimeKind.Unspecified), 37, false, 1 },
                    { 17, 11, new DateTime(2023, 9, 12, 0, 0, 0, 0, DateTimeKind.Unspecified), 8, true, 9 },
                    { 18, 11, new DateTime(2024, 9, 12, 0, 0, 0, 0, DateTimeKind.Unspecified), 9, true, 9 },
                    { 19, 11, new DateTime(2024, 9, 12, 0, 0, 0, 0, DateTimeKind.Unspecified), 10, true, 10 },
                    { 20, 12, new DateTime(2024, 9, 12, 0, 0, 0, 0, DateTimeKind.Unspecified), 16, true, 7 },
                    { 21, 13, new DateTime(2024, 9, 12, 0, 0, 0, 0, DateTimeKind.Unspecified), 17, true, 7 },
                    { 22, 13, new DateTime(2024, 9, 12, 0, 0, 0, 0, DateTimeKind.Unspecified), 23, true, 8 },
                    { 23, 16, new DateTime(2024, 9, 12, 0, 0, 0, 0, DateTimeKind.Unspecified), 22, true, 15 },
                    { 24, 16, new DateTime(2024, 9, 12, 0, 0, 0, 0, DateTimeKind.Unspecified), 14, true, 16 },
                    { 25, 16, new DateTime(2024, 9, 12, 0, 0, 0, 0, DateTimeKind.Unspecified), 13, true, 13 },
                    { 26, 16, new DateTime(2024, 9, 12, 0, 0, 0, 0, DateTimeKind.Unspecified), 12, true, 13 },
                    { 27, 17, new DateTime(2024, 9, 12, 0, 0, 0, 0, DateTimeKind.Unspecified), 12, false, 14 }
                });

            migrationBuilder.InsertData(
                table: "RazredKorisnik",
                columns: new[] { "Id", "DatumUpisa", "KorisnikId", "RazredId" },
                values: new object[,]
                {
                    { 1, new DateTime(2024, 9, 12, 0, 0, 0, 0, DateTimeKind.Unspecified), 3, 1 },
                    { 2, new DateTime(2024, 9, 12, 0, 0, 0, 0, DateTimeKind.Unspecified), 3, 3 },
                    { 3, new DateTime(2024, 9, 12, 0, 0, 0, 0, DateTimeKind.Unspecified), 3, 2 },
                    { 4, new DateTime(2024, 9, 12, 0, 0, 0, 0, DateTimeKind.Unspecified), 6, 2 },
                    { 5, new DateTime(2024, 9, 12, 0, 0, 0, 0, DateTimeKind.Unspecified), 6, 3 },
                    { 6, new DateTime(2024, 9, 12, 0, 0, 0, 0, DateTimeKind.Unspecified), 6, 4 },
                    { 7, new DateTime(2024, 9, 12, 0, 0, 0, 0, DateTimeKind.Unspecified), 19, 3 },
                    { 8, new DateTime(2024, 9, 12, 0, 0, 0, 0, DateTimeKind.Unspecified), 19, 4 },
                    { 9, new DateTime(2024, 9, 12, 0, 0, 0, 0, DateTimeKind.Unspecified), 19, 5 },
                    { 10, new DateTime(2024, 9, 12, 0, 0, 0, 0, DateTimeKind.Unspecified), 20, 4 },
                    { 11, new DateTime(2024, 9, 12, 0, 0, 0, 0, DateTimeKind.Unspecified), 20, 5 },
                    { 12, new DateTime(2024, 9, 12, 0, 0, 0, 0, DateTimeKind.Unspecified), 20, 6 },
                    { 13, new DateTime(2024, 9, 12, 0, 0, 0, 0, DateTimeKind.Unspecified), 36, 1 },
                    { 14, new DateTime(2023, 9, 12, 0, 0, 0, 0, DateTimeKind.Unspecified), 37, 1 },
                    { 15, new DateTime(2024, 9, 12, 0, 0, 0, 0, DateTimeKind.Unspecified), 37, 2 },
                    { 16, new DateTime(2024, 9, 12, 0, 0, 0, 0, DateTimeKind.Unspecified), 8, 7 },
                    { 17, new DateTime(2023, 9, 12, 0, 0, 0, 0, DateTimeKind.Unspecified), 8, 8 },
                    { 18, new DateTime(2024, 9, 12, 0, 0, 0, 0, DateTimeKind.Unspecified), 9, 9 },
                    { 19, new DateTime(2024, 9, 12, 0, 0, 0, 0, DateTimeKind.Unspecified), 9, 10 },
                    { 20, new DateTime(2024, 9, 12, 0, 0, 0, 0, DateTimeKind.Unspecified), 9, 11 },
                    { 21, new DateTime(2024, 9, 12, 0, 0, 0, 0, DateTimeKind.Unspecified), 10, 10 },
                    { 22, new DateTime(2024, 9, 12, 0, 0, 0, 0, DateTimeKind.Unspecified), 10, 11 },
                    { 23, new DateTime(2024, 9, 12, 0, 0, 0, 0, DateTimeKind.Unspecified), 10, 12 },
                    { 24, new DateTime(2024, 9, 12, 0, 0, 0, 0, DateTimeKind.Unspecified), 16, 7 },
                    { 25, new DateTime(2024, 9, 12, 0, 0, 0, 0, DateTimeKind.Unspecified), 17, 7 },
                    { 26, new DateTime(2024, 9, 12, 0, 0, 0, 0, DateTimeKind.Unspecified), 17, 8 },
                    { 27, new DateTime(2024, 9, 12, 0, 0, 0, 0, DateTimeKind.Unspecified), 23, 13 },
                    { 28, new DateTime(2024, 9, 12, 0, 0, 0, 0, DateTimeKind.Unspecified), 23, 14 },
                    { 29, new DateTime(2024, 9, 12, 0, 0, 0, 0, DateTimeKind.Unspecified), 23, 15 },
                    { 30, new DateTime(2024, 9, 12, 0, 0, 0, 0, DateTimeKind.Unspecified), 22, 15 },
                    { 31, new DateTime(2024, 9, 12, 0, 0, 0, 0, DateTimeKind.Unspecified), 22, 16 },
                    { 32, new DateTime(2024, 9, 12, 0, 0, 0, 0, DateTimeKind.Unspecified), 22, 17 },
                    { 33, new DateTime(2024, 9, 12, 0, 0, 0, 0, DateTimeKind.Unspecified), 14, 16 },
                    { 34, new DateTime(2024, 9, 12, 0, 0, 0, 0, DateTimeKind.Unspecified), 14, 17 },
                    { 35, new DateTime(2024, 9, 12, 0, 0, 0, 0, DateTimeKind.Unspecified), 14, 18 },
                    { 36, new DateTime(2024, 9, 12, 0, 0, 0, 0, DateTimeKind.Unspecified), 13, 13 },
                    { 37, new DateTime(2024, 9, 12, 0, 0, 0, 0, DateTimeKind.Unspecified), 12, 13 },
                    { 38, new DateTime(2024, 9, 12, 0, 0, 0, 0, DateTimeKind.Unspecified), 12, 14 },
                    { 39, new DateTime(2024, 9, 12, 0, 0, 0, 0, DateTimeKind.Unspecified), 8, 9 }
                });

            migrationBuilder.InsertData(
                table: "Zadaca",
                columns: new[] { "Id", "DatumDodjele", "KorisnikId", "Lekcija", "OcjeneId", "RazredId", "ZaZadacu" },
                values: new object[,]
                {
                    { 1, new DateTime(2024, 9, 12, 0, 0, 0, 0, DateTimeKind.Unspecified), 3, "Krupno R", 3, 1, "Fatiha" },
                    { 2, new DateTime(2024, 9, 12, 0, 0, 0, 0, DateTimeKind.Unspecified), 3, "Ja Sin", 1, 3, "Subhaneke" },
                    { 3, new DateTime(2024, 9, 12, 0, 0, 0, 0, DateTimeKind.Unspecified), 3, "Fatiha", 4, 2, "Ja Sin" },
                    { 4, new DateTime(2024, 9, 12, 0, 0, 0, 0, DateTimeKind.Unspecified), 3, "Subhaneke", 2, 2, "Fatiha" },
                    { 5, new DateTime(2024, 9, 12, 0, 0, 0, 0, DateTimeKind.Unspecified), 3, "Krupno R", 5, 3, "Subhaneke" },
                    { 6, new DateTime(2024, 9, 12, 0, 0, 0, 0, DateTimeKind.Unspecified), 3, "Ja Sin", 1, 2, "Rabbijesir" },
                    { 7, new DateTime(2024, 9, 12, 0, 0, 0, 0, DateTimeKind.Unspecified), 3, "Subhaneke", 4, 1, "Ja Sin" },
                    { 8, new DateTime(2024, 9, 12, 0, 0, 0, 0, DateTimeKind.Unspecified), 3, "Rabbijesir", 3, 1, "Fatiha" },
                    { 9, new DateTime(2024, 9, 12, 0, 0, 0, 0, DateTimeKind.Unspecified), 3, "Krupno R", 2, 2, "Rabbijesir" },
                    { 10, new DateTime(2024, 9, 12, 0, 0, 0, 0, DateTimeKind.Unspecified), 3, "Fatiha", 5, 3, "Subhaneke" },
                    { 11, new DateTime(2024, 9, 12, 0, 0, 0, 0, DateTimeKind.Unspecified), 6, "Ja Sin", 3, 4, "Fatiha" },
                    { 12, new DateTime(2024, 9, 12, 0, 0, 0, 0, DateTimeKind.Unspecified), 19, "Rabbijesir", 4, 4, "Krupno R" },
                    { 13, new DateTime(2024, 9, 12, 0, 0, 0, 0, DateTimeKind.Unspecified), 20, "Subhaneke", 2, 4, "Ja Sin" },
                    { 14, new DateTime(2023, 9, 12, 0, 0, 0, 0, DateTimeKind.Unspecified), 36, "Krupno R", 1, 1, "Subhaneke" },
                    { 15, new DateTime(2024, 9, 12, 0, 0, 0, 0, DateTimeKind.Unspecified), 37, "Rabbijesir", 3, 2, "Fatiha" },
                    { 16, new DateTime(2024, 9, 12, 0, 0, 0, 0, DateTimeKind.Unspecified), 37, "Ja Sin", 5, 1, "Rabbijesir" },
                    { 17, new DateTime(2023, 9, 12, 0, 0, 0, 0, DateTimeKind.Unspecified), 8, "Subhaneke", 2, 9, "Ja Sin" },
                    { 18, new DateTime(2024, 9, 12, 0, 0, 0, 0, DateTimeKind.Unspecified), 9, "Subhaneke", 5, 10, "Fatiha" },
                    { 19, new DateTime(2024, 9, 12, 0, 0, 0, 0, DateTimeKind.Unspecified), 10, "Fatiha", 3, 10, "Rabbijesir" },
                    { 20, new DateTime(2024, 9, 12, 0, 0, 0, 0, DateTimeKind.Unspecified), 16, "Ja Sin", 4, 7, "Subhaneke" },
                    { 21, new DateTime(2024, 9, 12, 0, 0, 0, 0, DateTimeKind.Unspecified), 17, "Rabbijesir", 1, 7, "Krupno R" },
                    { 22, new DateTime(2024, 9, 12, 0, 0, 0, 0, DateTimeKind.Unspecified), 17, "Subhaneke", 5, 8, "Ja Sin" },
                    { 23, new DateTime(2024, 9, 12, 0, 0, 0, 0, DateTimeKind.Unspecified), 23, "Krupno R", 3, 15, "Fatiha" },
                    { 24, new DateTime(2024, 9, 12, 0, 0, 0, 0, DateTimeKind.Unspecified), 22, "Ja Sin", 4, 16, "Rabbijesir" },
                    { 25, new DateTime(2024, 9, 12, 0, 0, 0, 0, DateTimeKind.Unspecified), 14, "Rabbijesir", 5, 16, "Subhaneke" },
                    { 26, new DateTime(2024, 9, 12, 0, 0, 0, 0, DateTimeKind.Unspecified), 13, "Krupno R", 3, 13, "Fatiha" },
                    { 27, new DateTime(2024, 9, 12, 0, 0, 0, 0, DateTimeKind.Unspecified), 12, "Rabbijesir", 4, 14, "Krupno R" }
                });

            migrationBuilder.CreateIndex(
                name: "IX_AkademskaMekteb_AkademskaGodinaId",
                table: "AkademskaMekteb",
                column: "AkademskaGodinaId");

            migrationBuilder.CreateIndex(
                name: "IX_AkademskaMekteb_MektebId",
                table: "AkademskaMekteb",
                column: "MektebId");

            migrationBuilder.CreateIndex(
                name: "IX_AkademskaRazred_AkademskaGodinaId",
                table: "AkademskaRazred",
                column: "AkademskaGodinaId");

            migrationBuilder.CreateIndex(
                name: "IX_AkademskaRazred_RazredId",
                table: "AkademskaRazred",
                column: "RazredId");

            migrationBuilder.CreateIndex(
                name: "IX_Cas_AkademskaGodinaId",
                table: "Cas",
                column: "AkademskaGodinaId");

            migrationBuilder.CreateIndex(
                name: "IX_Cas_MektebId",
                table: "Cas",
                column: "MektebId");

            migrationBuilder.CreateIndex(
                name: "IX_DodatneLekcije_MektebId",
                table: "DodatneLekcije",
                column: "MektebId");

            migrationBuilder.CreateIndex(
                name: "IX_Kamp_MektebId",
                table: "Kamp",
                column: "MektebId");

            migrationBuilder.CreateIndex(
                name: "IX_KampKorisnik_KampId",
                table: "KampKorisnik",
                column: "KampId");

            migrationBuilder.CreateIndex(
                name: "IX_KampKorisnik_KorisnikId",
                table: "KampKorisnik",
                column: "KorisnikId");

            migrationBuilder.CreateIndex(
                name: "IX_Kategorija_TakmicenjeId",
                table: "Kategorija",
                column: "TakmicenjeId");

            migrationBuilder.CreateIndex(
                name: "IX_KorisniciUloge_KorisnikId",
                table: "KorisniciUloge",
                column: "KorisnikId");

            migrationBuilder.CreateIndex(
                name: "IX_KorisniciUloge_UlogaId",
                table: "KorisniciUloge",
                column: "UlogaId");

            migrationBuilder.CreateIndex(
                name: "IX_Korisnik_MedzlisId",
                table: "Korisnik",
                column: "MedzlisId");

            migrationBuilder.CreateIndex(
                name: "IX_Korisnik_MektebId",
                table: "Korisnik",
                column: "MektebId");

            migrationBuilder.CreateIndex(
                name: "IX_Korisnik_MuftijstvoId",
                table: "Korisnik",
                column: "MuftijstvoId");

            migrationBuilder.CreateIndex(
                name: "IX_Korisnik_RazredId",
                table: "Korisnik",
                column: "RazredId");

            migrationBuilder.CreateIndex(
                name: "IX_Korisnik_RoditeljId",
                table: "Korisnik",
                column: "RoditeljId");

            migrationBuilder.CreateIndex(
                name: "IX_Medzlis_MuftijstvoId",
                table: "Medzlis",
                column: "MuftijstvoId");

            migrationBuilder.CreateIndex(
                name: "IX_Mekteb_MedzlisId",
                table: "Mekteb",
                column: "MedzlisId");

            migrationBuilder.CreateIndex(
                name: "IX_Obavijest_MektebId",
                table: "Obavijest",
                column: "MektebId");

            migrationBuilder.CreateIndex(
                name: "IX_Prisustvo_CasId",
                table: "Prisustvo",
                column: "CasId");

            migrationBuilder.CreateIndex(
                name: "IX_Prisustvo_KorisnikId",
                table: "Prisustvo",
                column: "KorisnikId");

            migrationBuilder.CreateIndex(
                name: "IX_Prisustvo_RazredId",
                table: "Prisustvo",
                column: "RazredId");

            migrationBuilder.CreateIndex(
                name: "IX_Razred_MektebId",
                table: "Razred",
                column: "MektebId");

            migrationBuilder.CreateIndex(
                name: "IX_RazredKorisnik_KorisnikId",
                table: "RazredKorisnik",
                column: "KorisnikId");

            migrationBuilder.CreateIndex(
                name: "IX_RazredKorisnik_RazredId",
                table: "RazredKorisnik",
                column: "RazredId");

            migrationBuilder.CreateIndex(
                name: "IX_Slika_KorisnikId",
                table: "Slika",
                column: "KorisnikId");

            migrationBuilder.CreateIndex(
                name: "IX_Takmicar_KategorijaId",
                table: "Takmicar",
                column: "KategorijaId");

            migrationBuilder.CreateIndex(
                name: "IX_Takmicenje_MedzlisId",
                table: "Takmicenje",
                column: "MedzlisId");

            migrationBuilder.CreateIndex(
                name: "IX_Zadaca_KorisnikId",
                table: "Zadaca",
                column: "KorisnikId");

            migrationBuilder.CreateIndex(
                name: "IX_Zadaca_OcjeneId",
                table: "Zadaca",
                column: "OcjeneId");

            migrationBuilder.CreateIndex(
                name: "IX_Zadaca_RazredId",
                table: "Zadaca",
                column: "RazredId");
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropTable(
                name: "AkademskaMekteb");

            migrationBuilder.DropTable(
                name: "AkademskaRazred");

            migrationBuilder.DropTable(
                name: "DodatneLekcije");

            migrationBuilder.DropTable(
                name: "KampKorisnik");

            migrationBuilder.DropTable(
                name: "KorisniciUloge");

            migrationBuilder.DropTable(
                name: "Obavijest");

            migrationBuilder.DropTable(
                name: "Prisustvo");

            migrationBuilder.DropTable(
                name: "RazredKorisnik");

            migrationBuilder.DropTable(
                name: "Slika");

            migrationBuilder.DropTable(
                name: "Takmicar");

            migrationBuilder.DropTable(
                name: "Zadaca");

            migrationBuilder.DropTable(
                name: "Kamp");

            migrationBuilder.DropTable(
                name: "Uloga");

            migrationBuilder.DropTable(
                name: "Cas");

            migrationBuilder.DropTable(
                name: "Kategorija");

            migrationBuilder.DropTable(
                name: "Korisnik");

            migrationBuilder.DropTable(
                name: "Ocjene");

            migrationBuilder.DropTable(
                name: "AkademskaGodina");

            migrationBuilder.DropTable(
                name: "Takmicenje");

            migrationBuilder.DropTable(
                name: "Razred");

            migrationBuilder.DropTable(
                name: "Mekteb");

            migrationBuilder.DropTable(
                name: "Medzlis");

            migrationBuilder.DropTable(
                name: "Muftijstvo");
        }
    }
}
