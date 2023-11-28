using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eMekteb.Services.Database
{
    public class Bodovi
    {
        [Key]
        public int Id { get; set; }
        public int? DodjeljeniBodovi { get; set; }

        [ForeignKey("Takmicar")]
        public int TakmicarId { get; set; }
        public virtual Takmicar? Takmicar { get; set; }

    }
}
