using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eMekteb.Services.Database
{
    public class Uloga
    {
        [Key]
        public int Id { get; set; }
        public string? Naziv { get; set; }
        public virtual ICollection<KorisniciUloge> KorisniciUloge { get; set; } = new List<KorisniciUloge>();

    }
}
