using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eMekteb.Model.SearchObjects
{
    public class TakmicenjeSearchObject : BaseSearchObject
    {
        public bool? IsAsc { get; set; }
        public int? MedzlisId { get; set; }

    }
}
