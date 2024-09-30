using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eMekteb.Services.Database
{
    public class CasUpdate
    {
        public DateTime? Datum { get; set; }
        public string? Razred { get; set; }
        public string? Lekcija { get; set; }
        public int MektebId { get; set; }
    }
}
