using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eMekteb.Model.DTOs
{
    public class MektebBodoviDto
    {
        public int MektebId { get; set; }
        public string NazivMekteba { get; set; } = string.Empty;
        public int UkupnoBodova { get; set; }
    }
}
