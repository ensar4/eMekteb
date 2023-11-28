using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eMekteb.Services.Database
{
    public class PrisustvoM
    {
        public bool? Prisutan { get; set; }
        public DateTime? Datum { get; set; }
        public int KorisnikId { get; set; }

    }
}
