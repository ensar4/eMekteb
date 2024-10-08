using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eMekteb.Services.Database
{
    public class Razred
    {
        [Key]
        public int Id { get; set; }
        public string? Naziv { get; set; }

        [ForeignKey("Mekteb")]
        public int? MektebId { get; set; }
        public virtual Mekteb? Mekteb { get; set; }
        public virtual ICollection<Korisnik> Ucenici { get; set; } = new List<Korisnik>();


    }
}
