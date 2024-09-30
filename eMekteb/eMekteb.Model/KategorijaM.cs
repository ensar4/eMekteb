using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eMekteb.Services.Database
{
    public class KategorijaM
    {
        public int? Id { get; set; }
        public string? Naziv { get; set; }
        public string? Nivo { get; set; }
        public int TakmicenjeId { get; set; }

        //public virtual ICollection<TakmicenjeKategorija> TakmicenjeKategorije { get; set; } = new List<TakmicenjeKategorija>();
        //public virtual ICollection<Takmicar> Takmicari { get; set; } = new List<Takmicar>();

    }
}
