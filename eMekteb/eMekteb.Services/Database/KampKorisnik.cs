using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eMekteb.Services.Database
{
    public class KampKorisnik
    {
        [Key]
        public int Id { get; set; }
        public DateTime DatumDodavanja { get; set; }

        [ForeignKey("Korisnik")]
        public int KorisnikId { get; set; }
        public virtual Korisnik? Korisnik { get; set; }

        [ForeignKey("Kamp")]
        public int KampId { get; set; }
        public virtual Kamp? Kamp { get; set; }
    }
}
