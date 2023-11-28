using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eMekteb.Services.Database
{
    public class Korisnik
    {
        [Key]
        public int Id { get; set; }
        public string? Ime { get; set; }
        public string? Prezime { get; set; }
        public string? Username { get; set; }
        public string? LozinkaHash { get; set; }
        public string? LozinkaSalt { get; set; }
        public string? Telefon { get; set; }
        public string? Mail { get; set; }
        public string? Spol { get; set; }
        public string? Status { get; set; }
        public DateTime DatumRodjenja {get; set; }
        public string? ImeRoditelja { get; set; }

        [ForeignKey("Mekteb")]
        public int MektebId { get; set; }
        public virtual Mekteb? Mekteb { get; set; }

        [ForeignKey("Razred")]
        public int RazredId { get; set; }
        public virtual Razred? Razred { get; set; }


        public virtual ICollection<Prisustvo> Prisustva { get; set; } = new List<Prisustvo>();
        public virtual ICollection<KorisniciUloge> KorisniciUloge { get; set; } = new List<KorisniciUloge>();
        public virtual ICollection<Zadaca> Zadace { get; set; } = new List<Zadaca>();





    }
}
