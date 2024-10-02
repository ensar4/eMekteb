using eMekteb.Services.Database;
using Microsoft.EntityFrameworkCore.Metadata.Builders;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eMekteb.Services.Seed
{
    public static class OcjeneData
    {
        public static void SeedData(this EntityTypeBuilder<Ocjene> entity)
        {
            entity.HasData(
                new Ocjene
                {
                    Id = 1,
                    Ocjena = 5
                },
                new Ocjene
                {
                    Id = 2,
                    Ocjena = 4
                },
                new Ocjene
                {
                    Id = 3,
                    Ocjena = 3
                },
                new Ocjene
                {
                    Id = 4,
                    Ocjena = 2
                },
                new Ocjene
                {
                    Id = 5,
                    Ocjena = 1
                }
              
            );
        }
    }
}
