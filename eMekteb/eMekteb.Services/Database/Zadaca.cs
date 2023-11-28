using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eMekteb.Services.Database
{
    public class Zadaca
    {
        public int Id { get; set; }
        public DateTime DatumDodjele { get; set; }

        [ForeignKey("Korisnik")]
        public int KorisnikId { get; set; }
        public virtual Korisnik? Korisnik { get; set; }

        [ForeignKey("Ocjene")]
        public int OcjeneId { get; set; }
        public virtual Ocjene? Ocjene { get; set; }

        public string? Lekcija { get; set; }
    }
}
