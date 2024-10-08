﻿using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eMekteb.Services.Database
{
    public class AkademskaMekteb
    {
        [Key]
        public int Id { get; set; }

        [ForeignKey("AkademskaGodina")]
        public int AkademskaGodinaId { get; set; }
        public virtual AkademskaGodina? AkademskaGodina { get; set; }

        [ForeignKey("Mekteb")]
        public int MektebId { get; set; }
        public virtual Mekteb? Mekteb { get; set; }
    }
}
