
using eMekteb.Services.Seed;
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

        public DbSet<Muftijstvo> Muftijstvo { get; set; }
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
        public DbSet<AkademskaRazred> AkademskaRazred { get; set; }
        public DbSet<RazredKorisnik> RazredKorisnik { get; set; }
        public DbSet<Razred> Razred { get; set; }
        public DbSet<Ocjene> Ocjene { get; set; }
        public DbSet<Zadaca> Zadaca { get; set; }
        public DbSet<Slika> Slika { get; set; }
        public DbSet<DodatneLekcije> DodatneLekcije { get; set; }


         protected override void OnModelCreating(ModelBuilder modelBuilder){

                modelBuilder.ApplyConfigurationsFromAssembly(typeof(eMektebContext).Assembly);

                modelBuilder.Entity<Muftijstvo>().SeedData();
                modelBuilder.Entity<AkademskaGodina>().SeedData();
                modelBuilder.Entity<AkademskaMekteb>().SeedData();
                modelBuilder.Entity<AkademskaRazred>().SeedData();
                modelBuilder.Entity<Cas>().SeedData();
                modelBuilder.Entity<DodatneLekcije>().SeedData();
                modelBuilder.Entity<Kamp>().SeedData();
                modelBuilder.Entity<KampKorisnik>().SeedData();
                modelBuilder.Entity<Kategorija>().SeedData();
                modelBuilder.Entity<KorisniciUloge>().SeedData();
                modelBuilder.Entity<Korisnik>().SeedData();
                modelBuilder.Entity<Medzlis>().SeedData();
                modelBuilder.Entity<Mekteb>().SeedData();
                modelBuilder.Entity<Obavijest>().SeedData();
                modelBuilder.Entity<Ocjene>().SeedData();
                modelBuilder.Entity<Prisustvo>().SeedData();
                modelBuilder.Entity<Razred>().SeedData();
                modelBuilder.Entity<RazredKorisnik>().SeedData();
                modelBuilder.Entity<Takmicar>().SeedData();
                modelBuilder.Entity<Takmicenje>().SeedData();
                modelBuilder.Entity<Uloga>().SeedData();
                modelBuilder.Entity<Zadaca>().SeedData();
 
          }
    }
}
