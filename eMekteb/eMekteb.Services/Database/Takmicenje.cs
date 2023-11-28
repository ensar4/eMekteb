using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eMekteb.Services.Database
{
    public class Takmicenje
    {
        [Key]
        public int Id { get; set; }
        public string? Godina { get; set; }
        public DateTime DatumOdrzavanja { get; set; }
        public string Lokacija { get; set; } = null!;
        public string? VrijemePočetka { get; set; }
        public string? Info { get; set; }

        [ForeignKey("Medzlis")]
        public int MedzlisId { get; set; }
        public virtual Medzlis? Medzlis { get; set; }


        public virtual ICollection<TakmicenjeKategorija> TakmicenjeKategorije { get; set; } = new List<TakmicenjeKategorija>();

    }
}
