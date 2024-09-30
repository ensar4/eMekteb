using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eMekteb.Services.Database
{
    public class KampKorisnikM
    {
        public int Id { get; set; }
        public DateTime DatumDodavanja { get; set; }
        public int KorisnikId { get; set; }
        public int KampId { get; set; }

    }
}
