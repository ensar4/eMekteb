using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eMekteb.Services.Database
{
    public class Medzlis
    {
        [Key]
        public int Id { get; set; }
        public string? Naziv { get; set; }
        public string? Adresa { get; set; }
        public string? Telefon { get; set; }
        public string? Mail { get; set; }

        [ForeignKey("Muftijstvo")]
        public int MuftijstvoId { get; set; }
        public virtual Muftijstvo? Muftijstvo { get; set; }


        public virtual ICollection<Mekteb> Mektebi { get; set; } = new List<Mekteb>();
        public virtual ICollection<Takmicenje> Takmicenje { get; set; } = new List<Takmicenje>();



    }
}
