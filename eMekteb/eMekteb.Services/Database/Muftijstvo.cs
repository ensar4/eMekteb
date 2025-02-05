using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eMekteb.Services.Database
{
    public class Muftijstvo
    {
        [Key]
        public int Id { get; set; }
        public string? Naziv { get; set; }
        public string? Adresa { get; set; }
        public string? Telefon { get; set; }
        public string? Mail { get; set; }

        public virtual ICollection<Medzlis> Medzlisi { get; set; } = new List<Medzlis>();




    }
}
