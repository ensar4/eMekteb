using System.ComponentModel.DataAnnotations.Schema;

namespace eMekteb.Model
{
    public class MuftijstvoM
    {
        public int Id { get; set; }
        public string? Naziv { get; set; }
        public string? Adresa { get; set; }
        public string? Telefon { get; set; }
        public string? Mail { get; set; }
        public int? UkupnoMekteba { get; set; }
        public int? UkupnoUcenika { get; set; }
        public double? ProsjecnaOcjena { get; set; }
        public double? ProsjecnoPrisustvo { get; set; }

    }
}