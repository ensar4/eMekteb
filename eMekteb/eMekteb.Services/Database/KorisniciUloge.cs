using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eMekteb.Services.Database
{
    public class KorisniciUloge
    {
        [Key]
        public int Id { get; set; }
        public DateTime DatumIzmjene { get; set; }

        [ForeignKey("Korisnik")]
        public int KorisnikId { get; set; }
        public virtual Korisnik? Korisnik { get; set; }

        [ForeignKey("Uloga")]
        public int UlogaId { get; set; }
        public virtual Uloga? Uloga { get; set; }
    }
}
