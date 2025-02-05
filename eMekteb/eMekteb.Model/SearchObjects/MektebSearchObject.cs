using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eMekteb.Model.SearchObjects
{
    public class MektebSearchObject:BaseSearchObject
    {
        public string? naziv { get; set; }
        public string? FTS { get; set; }
        public bool? IsAsc { get; set; }
        public bool? IsAscProsjek { get; set; }
        public int? MedzlisId { get; set; }
    }
}
