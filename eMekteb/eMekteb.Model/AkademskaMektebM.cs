﻿using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eMekteb.Services.Database
{
    public class AkademskaMektebM
    {
        public int AkademskaGodinaId { get; set; }
        public int MektebId { get; set; }

    }
}