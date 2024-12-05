using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eMekteb.Services.Database
{
    public class Prisustvo
    {
        [Key]
        public int Id { get; set; }
        public bool? Prisutan { get; set; }
        public DateTime? Datum { get; set; }

        [ForeignKey("Korisnik")]
        public int KorisnikId { get; set; }
        public virtual Korisnik? Korisnik { get; set; }

        [ForeignKey("Cas")]
        public int? CasId { get; set; }
        public virtual Cas? Cas { get; set; }        
        

        
        [ForeignKey("Razred")]
        public int? RazredId { get; set; }
        public virtual Razred? Razred { get; set; }
    }
}
