using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eMekteb.Services.Database
{
    public class AkademskaRazred
    {
        [Key]
        public int Id { get; set; }

        [ForeignKey("AkademskaGodina")]
        public int AkademskaGodinaId { get; set; }
        public virtual AkademskaGodina? AkademskaGodina { get; set; }

        [ForeignKey("Razred")]
        public int RazredId { get; set; }
        public virtual Razred? Razred { get; set; }
    }
}
