using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eMekteb.Services.Database
{
    public class RazredM
    {
        public int? id { get; set; }
        public string? Naziv { get; set; }
        public int MektebId { get; set; }


        //public virtual ICollection<Lekcija> Lekcije { get; set; } = new List<Lekcija>();
        //public virtual ICollection<Korisnik> Ucenici { get; set; } = new List<Korisnik>();


    }
}
