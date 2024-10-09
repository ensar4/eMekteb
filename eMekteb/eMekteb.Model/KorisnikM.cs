using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using eMekteb.Services.Database;

namespace eMekteb.Services.Database
{
    public partial class KorisnikM
    {
        public int Id { get; set; }
        public string? Ime { get; set; }
        public string? Prezime { get; set; }
        public string? Username { get; set; }
       // public string? LozinkaHash { get; set; }
       // public string? LozinkaSalt { get; set; }
        public string? Telefon { get; set; }
        public string? Mail { get; set; }
        public string? Spol { get; set; }
        public string? Status { get; set; }
        public DateTime DatumRodjenja {get; set; }
        public string? ImeRoditelja { get; set; }
        public int MektebId { get; set; }
        public double? Prisustvo { get; set; }
        public string? NazivRazreda { get; set; }
        public double? Prosjek { get; set; }
        public int? IdRazreda { get; set; }





        //public virtual ICollection<Prisustvo> Prisustva { get; set; } = new List<Prisustvo>();
        public virtual ICollection<KorisniciUlogeM> KorisniciUloge { get;  } = new List<KorisniciUlogeM>();

        //public virtual ICollection<Zadaca> Zadace { get; set; } = new List<Zadaca>();






    }
}
