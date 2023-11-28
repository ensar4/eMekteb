using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eMekteb.Services.Database
{
    public class ObavijestInsert
    {
        public string? Naslov { get; set; }
        public string? Opis { get; set; }
        public DateTime DatumObjave { get; set; }
        public string? VrstaObjave { get; set; }
        public int MektebId { get; set; }

    }
}
