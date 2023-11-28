using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eMekteb.Services.Database
{
    public class DodatneLekcije
    {
        [Key]
        public int Id { get; set; }
        public string Naziv { get; set; } = null!;
        public string Tekst { get; set; } = null!;
        public DateTime DatumObjavljivanja { get; set; }
        public int? Likes { get; set; }
        public int? Dislikes { get; set; }

        [ForeignKey("Mekteb")]
        public int MektebId { get; set; }
        public virtual Mekteb? Mekteb { get; set; }

    }
}
