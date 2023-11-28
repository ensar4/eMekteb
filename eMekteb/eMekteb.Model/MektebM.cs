using System.ComponentModel.DataAnnotations.Schema;

namespace eMekteb.Model
{
    public class MektebM
    {
        public string? Naziv { get; set; }
        public string? Telefon { get; set; }
        public string? Adresa { get; set; }
        public int MedzlisId { get; set; }
        public int AkademskaGodinaId { get; set; }

        //public virtual ICollection<Korisnik> Korisnik { get; set; } = new List<Korisnik>();


    }
}