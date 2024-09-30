using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Data.Common;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eMekteb.Services.Database
{
    public class eMektebContext : DbContext
    {
        public eMektebContext()
        {
        }

        public eMektebContext(DbContextOptions<eMektebContext> options) : base(options)
        {
        }

        public DbSet<Cas> Cas { get; set; }
        public DbSet<Medzlis> Medzlis { get;set; }
        public DbSet<Mekteb> Mekteb { get; set; }
        public DbSet<Kamp> Kamp { get; set; }
        public DbSet<KampKorisnik> KampKorisnik { get; set; }
        public DbSet<Obavijest> Obavijest { get; set; }
        public DbSet<Korisnik> Korisnik { get; set; }
        public DbSet<Prisustvo> Prisustvo { get; set; }
        public DbSet<Uloga> Uloga { get; set; }
        public DbSet<KorisniciUloge> KorisniciUloge { get; set; }
        public DbSet<Takmicenje> Takmicenje { get; set; }
        public DbSet<Kategorija> Kategorija { get; set; }
        public DbSet<Takmicar> Takmicar { get; set; }
        public DbSet<AkademskaGodina> AkademskaGodina { get; set; }
        public DbSet<AkademskaMekteb> AkademskaMekteb { get; set; }
        public DbSet<Razred> Razred { get; set; }
        public DbSet<Ocjene> Ocjene { get; set; }
        public DbSet<Zadaca> Zadaca { get; set; }
        public DbSet<Slika> Slika { get; set; }
        public DbSet<DodatneLekcije> DodatneLekcije { get; set; }

    }
}
