using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eMekteb.Services.Database
{
    public class Mekteb
    {
        [Key]    
        public int Id { get; set; }
        public string? Naziv { get; set; }
        public string? Telefon { get; set; }
        public string? Adresa { get; set; }

        [ForeignKey("Medzlis")]
        public int MedzlisId { get; set; }
        public virtual Medzlis? Medzlis { get; set; }

        //[ForeignKey("AkademskaGodina")]
        //public int AkademskaGodinaId { get; set; }
        //public virtual AkademskaGodina? AkademskaGodina { get; set; }


        public virtual ICollection<Kamp> Kampovi { get; set; } = new List<Kamp>();
        public virtual ICollection<Obavijest> Obavijesti { get; set; } = new List<Obavijest>();
        public virtual ICollection<Korisnik> Korisnik { get; set; } = new List<Korisnik>();
        public virtual ICollection<DodatneLekcije> DodatneLekcije { get; set; } = new List<DodatneLekcije>();
        public ICollection<AkademskaMekteb>? AkademskaMekteb { get; set; } 




    }
}
