using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eMekteb.Model.Request
{
    public class MektebUpdate
    {
        public string? Naziv { get; set; }
        public string? Telefon { get; set; }
        public string? Adresa { get; set; }
        public int AkademskaGodinaId { get; set; }
    }
}
