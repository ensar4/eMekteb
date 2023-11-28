using System;
using System.Collections.Generic;
using System.Diagnostics.Metrics;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eMekteb.Model
{
    public class MedzlisM
    {
        public string? Naziv { get; set; }
        public string? Adresa { get; set; }
        public string? Telefon { get; set; }
        public string? Mail { get; set; }

        //public virtual ICollection<Mekteb> Mektebi { get; set; } = new List<Mekteb>();
        //public virtual ICollection<Takmicenje> Takmicenje { get; set; } = new List<Takmicenje>();
    }
}
