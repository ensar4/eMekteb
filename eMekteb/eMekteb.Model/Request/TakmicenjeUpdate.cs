using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eMekteb.Services.Database
{
    public class TakmicenjeUpdate
    {
        public string? Godina { get; set; }
        public DateTime DatumOdrzavanja { get; set; }
        public string Lokacija { get; set; } = null!;
        public string? VrijemePocetka { get; set; }
        public string? Info { get; set; }

    }
}
