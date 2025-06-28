using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eMekteb.Services.Database
{
    public class Kategorija
    {
        [Key]
        public int Id { get; set; }
        public string? Naziv { get; set; }
        public string? Nivo { get; set; }

        [ForeignKey("Takmicenje")]
        public int TakmicenjeId { get; set; }
        public virtual Takmicenje? Takmicenje { get; set; }


        public virtual ICollection<Takmicar> Takmicari { get; set; } = new List<Takmicar>();

    }
}
