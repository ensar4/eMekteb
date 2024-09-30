using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eMekteb.Services.Database
{
    public class AkademskaGodina
    {
        [Key]
        public int Id { get; set; }
        public string? Naziv { get; set; }
        public DateTime DatumPocetka { get; set; }
        public DateTime DatumZavrsetka { get; set; }

        public ICollection<AkademskaMekteb>? AkademskaMekteb { get; set; } 





    }
}
