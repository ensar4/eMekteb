﻿using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eMekteb.Services.Database
{
    public class AkademskaGodinaInsert
    {
        public string? Naziv { get; set; }
        public DateTime DatumPocetka { get; set; }
        public DateTime DatumZavrsetka { get; set; }
        public bool? isAktivna { get; set; }

        //public virtual ICollection<Mekteb>Mektebi { get; set; } = new List<Mekteb>();


    }
}
