using eMekteb.Services.Database;
using Microsoft.EntityFrameworkCore.Metadata.Builders;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eMekteb.Services.Seed
{
    public static class AkademskaMektebData
    {
        public static void SeedData(this EntityTypeBuilder<AkademskaMekteb> entity)
        {
            entity.HasData(
                new AkademskaMekteb
                {
                    Id = 1,
                    AkademskaGodinaId=1,
                    MektebId = 1
                },
                new AkademskaMekteb
                {
                    Id = 2,
                    AkademskaGodinaId = 1,
                    MektebId = 2
                },
                new AkademskaMekteb
                {
                    Id = 3,
                    AkademskaGodinaId = 1,
                    MektebId = 3
                },
                new AkademskaMekteb
                {
                    Id = 4,
                    AkademskaGodinaId = 2,
                    MektebId = 1
                },
                new AkademskaMekteb
                {
                    Id = 5,
                    AkademskaGodinaId = 2,
                    MektebId = 2
                },
                new AkademskaMekteb
                {
                    Id = 6,
                    AkademskaGodinaId = 2,
                    MektebId = 3
                },
                new AkademskaMekteb
                {
                    Id = 7,
                    AkademskaGodinaId = 2,
                    MektebId = 4
                },
                new AkademskaMekteb
                {
                    Id = 8,
                    AkademskaGodinaId = 3,
                    MektebId = 2
                },
                new AkademskaMekteb
                {
                    Id = 9,
                    AkademskaGodinaId = 3,
                    MektebId = 3
                },
                new AkademskaMekteb
                {
                    Id = 10,
                    AkademskaGodinaId = 3,
                    MektebId = 1
                },
                new AkademskaMekteb
                {
                    Id = 11,
                    AkademskaGodinaId = 3,
                    MektebId = 4
                },
                new AkademskaMekteb
                {
                    Id = 12,
                    AkademskaGodinaId = 3,
                    MektebId = 5
                },
                new AkademskaMekteb
                {
                    Id = 13,
                    AkademskaGodinaId = 3,
                    MektebId = 6
                }
    

            );
        }
    }
}
