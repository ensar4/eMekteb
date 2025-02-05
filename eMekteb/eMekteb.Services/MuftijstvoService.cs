using AutoMapper;
using eMekteb.Model;
using eMekteb.Model.Request;
using eMekteb.Model.SearchObjects;
using eMekteb.Services.Database;
using eMekteb.Services.Interfaces;
using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eMekteb.Services
{
    public class MuftijstvoService : BaseCRUDService<MuftijstvoM, Muftijstvo, MuftijstvoSearchObject, MuftijstvoInsert, MuftijstvoUpdate>, IMuftijstvoService
    {
        public MuftijstvoService(eMektebContext dbContext, IMapper mapper) : base(dbContext, mapper)
        {
        }
        public async override Task<PagedResult<MuftijstvoM>> Get(MuftijstvoSearchObject? search)
        {
            var result = await base.Get(search);

            foreach (var muftijstvoM in result.Result)
            {
                muftijstvoM.UkupnoMekteba = await _dbContext.Mekteb
                    .CountAsync(m => m.MedzlisId == muftijstvoM.Id);

                var korisniciIds = await _dbContext.Korisnik
                         .Where(k => k.KorisniciUloge.Any(ku => ku.Uloga.Naziv == "Ucenik") && 
                        _dbContext.Mekteb
                        .Where(m => m.MedzlisId == muftijstvoM.Id)
                        .Select(m => m.Id)
                        .Contains(k.MektebId))
                          .Select(k => k.Id)
                          .ToListAsync();

                muftijstvoM.UkupnoUcenika = korisniciIds.Count;

                var averageGrade = await _dbContext.Zadaca
                    .Where(z => korisniciIds.Contains(z.KorisnikId))
                    .AverageAsync(z => (double?)z.Ocjene.Ocjena);

                muftijstvoM.ProsjecnaOcjena = averageGrade;

                var averageAttendance = await _dbContext.Prisustvo
                    .Where(p => korisniciIds.Contains(p.KorisnikId))
                    .GroupBy(p => p.KorisnikId)
                    .Select(g => g.Count(p => p.Prisutan == true) / (double)g.Count())
                    .AverageAsync() * 100;

                muftijstvoM.ProsjecnoPrisustvo = averageAttendance;
            }

            return result;
        }

        //public async override Task<PagedResult<muftijstvoM>> Get(MektebSearchObject? search)
        //{
        //    var result = await base.Get(search);

        //    foreach (var muftijstvoM in result.Result)
        //    {
        //        // Calculate the total number of Mektebs in the Medzlis
        //        muftijstvoM.UkupnoMekteba = await _dbContext.Mekteb.CountAsync(m => m.MedzlisId == muftijstvoM.Id);

        //        // Get all Mektebs in the Medzlis
        //        var mektebsInMedzlis = await _dbContext.Mekteb
        //            .Where(m => m.MedzlisId == muftijstvoM.Id)
        //            .ToListAsync();

        //        var korisniciIds = new List<int>();

        //        // Get all student IDs in the Mektebs
        //        foreach (var mekteb in mektebsInMedzlis)
        //        {
        //            var mektebKorisniciIds = await _dbContext.Korisnik
        //                .Where(k => k.MektebId == mekteb.Id)
        //                .Select(k => k.Id).Distinct()
        //                .ToListAsync();
        //            korisniciIds.AddRange(mektebKorisniciIds);
        //        }

        //        // Calculate the total number of students
        //        muftijstvoM.UkupnoUcenika = korisniciIds.Count;

        //        // Calculate the average grade for the Medzlis
        //        var zadace = await _dbContext.Zadaca
        //            .Where(z => korisniciIds.Contains(z.KorisnikId))
        //            .Include(z => z.Ocjene)
        //            .ToListAsync();

        //        if (zadace.Count > 0)
        //        {
        //            double averageGrade = (double)zadace.Average(z => z.Ocjene.Ocjena);
        //            muftijstvoM.ProsjecnaOcjena = averageGrade;
        //        }
        //        else
        //        {
        //            muftijstvoM.ProsjecnaOcjena = null;
        //        }

        //        // Calculate the average attendance for the Medzlis
        //        var prisustva = await _dbContext.Prisustvo
        //            .Where(p => korisniciIds.Contains(p.KorisnikId))
        //            .ToListAsync();

        //        if (prisustva.Count > 0)
        //        {
        //            double averageAttendance = prisustva
        //                .GroupBy(p => p.KorisnikId)
        //                .Select(g => g.Count(p => p.Prisutan == true) / (double)g.Count())
        //                .Average() * 100;
        //            muftijstvoM.ProsjecnoPrisustvo = averageAttendance;
        //        }
        //        else
        //        {
        //            muftijstvoM.ProsjecnoPrisustvo = null;
        //        }
        //    }

        //    return result;
        //}


    }
}
