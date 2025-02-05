using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eMekteb.Model.SearchObjects
{
    public class AkademskaGodSearchObject : BaseSearchObject
    {
        public bool? IsAsc { get; set; }
        public bool? IsPupilsAsc { get; set; }
        public int? MedzlisId { get; set; }
        public int? MuftijstvoId { get; set; }

    }
}
