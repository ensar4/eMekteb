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
    public class MedzlisService : BaseCRUDService<MedzlisM, Medzlis, MedzlisSearchObject, MedzlisInsert, MedzlisUpdate>, IMedzlisService
    {
        public MedzlisService(eMektebContext dbContext, IMapper mapper) : base(dbContext, mapper)
        {
        }

        public override IQueryable<Medzlis> AddFilter(IQueryable<Medzlis> query, MedzlisSearchObject? search)
        {
            if (!string.IsNullOrWhiteSpace(search.naziv))
            {
                query = query.Where(y => y.Naziv.StartsWith(search.naziv));
            }
            if (search?.MedzlisId != null)
            {
                query = query.Where(m => m.Id == search.MedzlisId);
            }
            if (search?.MuftijstvoId != null)
            {
                query = query.Where(m => m.MuftijstvoId == search.MuftijstvoId);
            }
            if (!string.IsNullOrWhiteSpace(search.FTS))
            {
                query = query.Where(y => y.Naziv.Contains(search.FTS));
            }
            if (search?.IsAsc == true)
            {
                query = query.OrderBy(y => y.Mektebi.Count());
            }
            else
                query = query.OrderByDescending(y => y.Mektebi.Count());
            return base.AddFilter(query, search);
        }

        public async override Task<PagedResult<MedzlisM>> Get(MedzlisSearchObject? search)
        {
            var result = await base.Get(search);

            foreach (var medzlisM in result.Result)
            {
                medzlisM.UkupnoMekteba = await _dbContext.Mekteb
                    .Where(m => m.MedzlisId == medzlisM.Id)
                    .CountAsync();

                var korisniciIds = await _dbContext.Korisnik
                    .Where(k => k.KorisniciUloge.Any(ku => ku.Uloga.Naziv == "Ucenik") &&
                                _dbContext.Mekteb
                                    .Where(m => m.MedzlisId == medzlisM.Id)
                                    .Select(m => m.Id)
                                    .Contains(k.MektebId))
                    .Select(k => k.Id)
                    .ToListAsync();

                medzlisM.UkupnoUcenika = korisniciIds.Count;

                if (korisniciIds.Any())
                {
                    var averageGrade = await _dbContext.Zadaca
                        .Where(z => korisniciIds.Contains(z.KorisnikId) && z.Ocjene != null && z.Ocjene.Ocjena.HasValue)
                        .AverageAsync(z => (double?)z.Ocjene.Ocjena);

                    medzlisM.ProsjecnaOcjena = averageGrade;

                    var averageAttendance = await _dbContext.Prisustvo
                        .Where(p => korisniciIds.Contains(p.KorisnikId))
                        .GroupBy(p => p.KorisnikId)
                        .Select(g => g.Count(p => p.Prisutan == true) / (double)g.Count())
                        .AverageAsync() * 100;

                    medzlisM.ProsjecnoPrisustvo = averageAttendance;
                }
                else
                {
                    // Handle case where korisniciIds is empty
                    medzlisM.ProsjecnaOcjena = null;
                    medzlisM.ProsjecnoPrisustvo = null;
                }
            }

            return result;
        }


        //public async override Task<PagedResult<MedzlisM>> Get(MedzlisSearchObject? search)
        //{
        //    var result = await base.Get(search);

        //    foreach (var medzlisM in result.Result)
        //    {
        //        // Calculate the total number of Mektebs in the Medzlis
        //        medzlisM.UkupnoMekteba = await _dbContext.Mekteb.CountAsync(m => m.MedzlisId == medzlisM.Id);

        //        // Get all Mektebs in the Medzlis
        //        var mektebsInMedzlis = await _dbContext.Mekteb
        //            .Where(m => m.MedzlisId == medzlisM.Id)
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
        //        medzlisM.UkupnoUcenika = korisniciIds.Count;

        //        // Calculate the average grade for the Medzlis
        //        var zadace = await _dbContext.Zadaca
        //            .Where(z => korisniciIds.Contains(z.KorisnikId))
        //            .Include(z => z.Ocjene)
        //            .ToListAsync();

        //        if (zadace.Count > 0)
        //        {
        //            double averageGrade = (double)zadace.Average(z => z.Ocjene.Ocjena);
        //            medzlisM.ProsjecnaOcjena = averageGrade;
        //        }
        //        else
        //        {
        //            medzlisM.ProsjecnaOcjena = null;
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
        //            medzlisM.ProsjecnoPrisustvo = averageAttendance;
        //        }
        //        else
        //        {
        //            medzlisM.ProsjecnoPrisustvo = null;
        //        }
        //    }

        //    return result;
        //}


    }
}
