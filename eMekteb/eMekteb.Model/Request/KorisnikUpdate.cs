using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eMekteb.Services.Database
{
    public class KorisnikUpdate
    {
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
        public int RazredId { get; set; }

    }
}
