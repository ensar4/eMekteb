using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eMekteb.Services.Database
{
    public class KategorijaInsert
    {
        public string? Naziv { get; set; }
        public string? Nivo { get; set; }
        public int TakmicenjeId { get; set; }

    }
}
