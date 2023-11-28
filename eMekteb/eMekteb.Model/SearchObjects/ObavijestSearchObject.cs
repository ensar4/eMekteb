using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eMekteb.Model.SearchObjects
{
    public class ObavijestSearchObject : BaseSearchObject
    {
        public string? naziv { get; set; }
        public string? FTS { get; set; }
    }
}
