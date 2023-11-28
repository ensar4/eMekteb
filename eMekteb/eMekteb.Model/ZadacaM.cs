using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eMekteb.Services.Database
{
    public class ZadacaM
    {
        public DateTime DatumDodjele { get; set; }
        public int KorisnikId { get; set; }
        public int OcjeneId { get; set; }
        public string? Lekcija { get; set; }


    }
}
