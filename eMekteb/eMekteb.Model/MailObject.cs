using System.ComponentModel.DataAnnotations.Schema;

namespace eMekteb.Model
{
    public class MailObject
    {
        public string? mailAdresa { get; set; }
        public string? subject { get; set; }
        public string? poruka { get; set; }

    }
}