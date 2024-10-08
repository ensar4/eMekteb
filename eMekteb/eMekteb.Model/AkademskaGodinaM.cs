using eMekteb.Model;
using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eMekteb.Services.Database
{
    public class AkademskaGodinaM
    {
        public int? Id { get; set; }
        public string? Naziv { get; set; }
        public DateTime DatumPocetka { get; set; }
        public DateTime DatumZavrsetka { get; set; }
        public int? UkupnoMekteba { get; set; }
        public int? UkupnoUcenika { get; set; }
        public double? ProsjecnaOcjena { get; set; } 
        public double? ProsjecnoPrisustvo { get; set; }
        public bool? isAktivna { get; set; }

        //public virtual ICollection<MektebM>Mektebi { get; set; } = new List<MektebM>();


    }
}
