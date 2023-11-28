using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eMekteb.Services.Database
{
    public class TakmicarM
    {
        public string? Ime { get; set; }
        public string? Prezime { get; set; }
        public DateTime DatumRodjenja { get; set; }
        public int? UkupnoBodova { get; set; }
        public int KategorijaId { get; set; }



       // public virtual ICollection<Bodovi> Bodovi { get; set; } = new List<Bodovi>();

    }
}
