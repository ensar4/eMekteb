﻿using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eMekteb.Services.Database
{
    public class RazredKorisnikM
    {
        public int KorisnikId { get; set; }
        public int RazredId { get; set; }
        public DateTime DatumUpisa { get; set; }

    }
}