using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Globalization;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eMekteb.Services.Database
{
    public class UcenikRoditelj
    {
        public string? UcenikIme { get; set; }
        public string? UcenikPrezime { get; set; }
        public string? UcenikUsername { get; set; }
        public string? UcenikTelefon { get; set; }
        public string? UcenikMail { get; set; }
        public string? UcenikSpol { get; set; }
        public string? UcenikStatus { get; set; }
        public DateTime UcenikDatumRodjenja { get; set; }
        public string? UcenikImeRoditelja { get; set; }
        public int UcenikMektebId { get; set; }
        public int? UcenikRazredId { get; set; }
        public string? UcenikPassword { get; set; }
        public string? UcenikPasswordPotvrda { get; set; }


        public string? RoditeljIme { get; set; }
        public string? RoditeljPrezime { get; set; }
        public string? RoditeljUsername { get; set; }
        public string? RoditeljTelefon { get; set; }
        public string? RoditeljMail { get; set; }
        public string? RoditeljSpol { get; set; }
        public string? RoditeljStatus { get; set; }
        public DateTime RoditeljDatumRodjenja { get; set; }
        public string? RoditeljImeRoditelja { get; set; }
        public int RoditeljMektebId { get; set; }
        public int? RoditeljRazredId { get; set; }
        public string? RoditeljPassword { get; set; }
        public string? RoditeljPasswordPotvrda { get; set; }

    }
}
