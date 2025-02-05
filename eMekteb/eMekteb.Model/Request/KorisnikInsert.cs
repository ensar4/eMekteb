using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Globalization;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eMekteb.Services.Database
{
    public class KorisnikInsert
    {
        public string? Ime { get; set; }
        public string? Prezime { get; set; }
        public string? Username { get; set; }
        public string? Telefon { get; set; }
        public string? Mail { get; set; }
        public string? Spol { get; set; }
        public string? Status { get; set; }
        public DateTime DatumRodjenja {get; set; }
        public string? ImeRoditelja { get; set; }
        public int MektebId { get; set; }
        public int? MuftijstvoId { get; set; }
        public int? MedzlisId { get; set; }


        [Compare("PasswordPotvrda", ErrorMessage ="Lozinke se ne slazu")]
        public string? Password { get; set; }

        [Compare("Password", ErrorMessage = "Lozinke se ne slazu")]
        public string? PasswordPotvrda { get; set; }

    }
}
