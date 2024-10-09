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
using System.Security.Cryptography;
using System.Text;
using System.Threading.Tasks;

namespace eMekteb.Services
{
    public class KorisnikService : BaseCRUDService<KorisnikM, Korisnik, KorisnikSearchObject, KorisnikInsert, KorisnikUpdate>, IKorisnikService
    {
        public KorisnikService(eMektebContext dbContext, IMapper mapper) : base(dbContext, mapper)
        {
        }
        public async Task<PagedResult<KorisnikM>> GetByRoditeljId(int roditeljId)
        {
            // Fetch students by RoditeljId
            var items = _dbContext.Set<Korisnik>()
                                  .Where(k => k.RoditeljId == roditeljId)
                                  .Join(_dbContext.RazredKorisnik,
                                        k => k.Id,
                                        kr => kr.KorisnikId,
                                        (k, kr) => new { Korisnik = k, KorisnikRazred = kr })
                                  .Join(_dbContext.Razred,
                                        kr => kr.KorisnikRazred.RazredId,
                                        r => r.Id,
                                        (kr, r) => new { kr.Korisnik, Razred = r });

            var uceniciWithAttendance = await items.ToListAsync();

            foreach (var ucenikData in uceniciWithAttendance)
            {
                var ucenik = ucenikData.Korisnik;
                var razred = ucenikData.Razred;

                // Fetch attendance records for the specific student (Korisnik) and class (Razred)
                var attendanceRecords = await _dbContext.Prisustvo
                    .Where(p => p.KorisnikId == ucenik.Id && p.RazredId == razred.Id)
                    .ToListAsync();

                int totalClasses = attendanceRecords.Count;
                if (totalClasses > 0)
                {
                    int presentCount = attendanceRecords.Count(p => p.Prisutan == true);
                    double attendancePercentage = (double)presentCount / totalClasses * 100;
                    ucenik.Prisustvo = attendancePercentage;
                }
                else
                {
                    ucenik.Prisustvo = 0;
                }

                // Fetch zadace (assignments) for the specific student and class to calculate the average grade
                var zadace = await _dbContext.Zadaca
                    .Where(z => z.RazredId == razred.Id && z.KorisnikId == ucenik.Id)
                    .Include(z => z.Ocjene)
                    .ToListAsync();

                if (zadace.Count > 0)
                {
                    double averageGrade = (double)zadace.Average(z => z.Ocjene.Ocjena); // Assuming Ocjene has a property 'Ocjena'
                    ucenik.Prosjek = averageGrade;
                }
                else
                {
                    ucenik.Prosjek = 0; // No grades available
                }

                // Set the Razred name for the student
                ucenik.NazivRazreda = razred.Naziv;
            }

            PagedResult<KorisnikM> result = new PagedResult<KorisnikM>
            {
                Count = uceniciWithAttendance.Count,
                Result = _mapper.Map<List<KorisnikM>>(uceniciWithAttendance.Select(ud => ud.Korisnik).ToList())
            };

            return result;
        }



        public async Task<UcenikRoditeljResponse> CreateStudentWithParentAsync(KorisnikInsert studentInsert, KorisnikInsert parentInsert)
        {
            var existingParent = await _dbContext.Korisnik
                .FirstOrDefaultAsync(k => k.Telefon == parentInsert.Telefon);

            Korisnik parentEntity;
            if (existingParent == null)
            {
                parentEntity = _mapper.Map<Korisnik>(parentInsert);
                await BeforeInsert(parentEntity, parentInsert);

                _dbContext.Korisnik.Add(parentEntity);
                await _dbContext.SaveChangesAsync();
            }
            else
            {
                parentEntity = existingParent;
            }

            var studentEntity = _mapper.Map<Korisnik>(studentInsert);

            studentEntity.RoditeljId = parentEntity.Id;

            await BeforeInsert(studentEntity, studentInsert);

            _dbContext.Korisnik.Add(studentEntity);
            await _dbContext.SaveChangesAsync();

            return new UcenikRoditeljResponse
            {
                StudentId = studentEntity.Id,
                ParentId = parentEntity.Id
            };
        }

        public static string GenerateSalt()
        {
            RNGCryptoServiceProvider provider = new RNGCryptoServiceProvider();
            var byteArray = new byte[16];
            provider.GetBytes(byteArray);


            return Convert.ToBase64String(byteArray);
        }
        public static string GenerateHash(string salt, string password)
        {
            byte[] src = Convert.FromBase64String(salt);
            byte[] bytes = Encoding.Unicode.GetBytes(password);
            byte[] dst = new byte[src.Length + bytes.Length];

            System.Buffer.BlockCopy(src, 0, dst, 0, src.Length);
            System.Buffer.BlockCopy(bytes, 0, dst, src.Length, bytes.Length);

            HashAlgorithm algorithm = HashAlgorithm.Create("SHA1");
            byte[] inArray = algorithm.ComputeHash(dst);
            return Convert.ToBase64String(inArray);
        }

        public override IQueryable<Korisnik> AddFilter(IQueryable<Korisnik> query, KorisnikSearchObject? search)
        {
            if (!string.IsNullOrWhiteSpace(search?.Ime))
            {
                query = query.Where(y => y.Ime.StartsWith(search.Ime));
            }
            if (!string.IsNullOrWhiteSpace(search?.Prezime))
            {
                query = query.Where(y => y.Prezime.StartsWith(search.Prezime));
            }

            if (!string.IsNullOrWhiteSpace(search.FTS))
            {
                query = query.Where(y => y.Ime.Contains(search.FTS) || y.Prezime.Contains(search.FTS));
            }

            return base.AddFilter(query, search);
        }


        public override async Task BeforeInsert(Korisnik entity, KorisnikInsert insert)
        {
            entity.LozinkaSalt = GenerateSalt();
            entity.LozinkaHash = GenerateHash(entity.LozinkaSalt, insert.Password);
        }

        public override IQueryable<Korisnik> AddInclude(IQueryable<Korisnik> query, KorisnikSearchObject? search = null)
        {
            if (search?.IsUlogeIncluded == true)
            {
                query = query.Include("KorisniciUloge.Uloga");
            }
            return base.AddInclude(query, search);
        }

        public async Task<KorisnikM> Login(string username, string password)
        {
            var entity = await _dbContext.Korisnik.Include("KorisniciUloge.Uloga").FirstOrDefaultAsync(x => x.Username == username);

            if (entity == null)
            {
                return null;
            }

            var hash = GenerateHash(entity.LozinkaSalt, password);

            if (hash != entity.LozinkaHash)
            {
                return null;
            }

            return _mapper.Map<KorisnikM>(entity);
        }

        public async Task<KorisnikM>GetByUsernameAndLozinkaAsync(string username, string password)
        {

            var entity = await _dbContext
                .Korisnik
                .Include("KorisniciUloge.Uloga")
                .FirstOrDefaultAsync(x => x.Username == username);

            if (entity == null)
            {
                throw new ArgumentNullException(nameof(entity), "Wrong username.");
            }

            var hash = GenerateHash(entity.LozinkaSalt, password);

            if (hash != entity.LozinkaHash)
            {
                return null;
            }

            return _mapper.Map<KorisnikM>(entity);
        }

        public async Task<PagedResult<KorisnikM>> GetUcenici(int? mektebId)
        {
            var ucenikRoleName = "Ucenik";

            // Query the ucenici through the KorisnikRazred table to link them with Razred
            var uceniciQuery = _dbContext.Set<Korisnik>()
                .Where(k => k.KorisniciUloge.Any(ku => ku.Uloga.Naziv == ucenikRoleName))
                .Join(_dbContext.RazredKorisnik,
                      k => k.Id,
                      kr => kr.KorisnikId,
                      (k, kr) => new { Korisnik = k, KorisnikRazred = kr })
                .Join(_dbContext.Razred,
                      kr => kr.KorisnikRazred.RazredId,
                      r => r.Id,
                      (kr, r) => new { kr.Korisnik, Razred = r });

            if (mektebId.HasValue)
            {
                uceniciQuery = uceniciQuery.Where(k => k.Razred.MektebId == mektebId.Value);
            }

            var uceniciWithAttendance = await uceniciQuery.ToListAsync();

            foreach (var ucenikData in uceniciWithAttendance)
            {
                var ucenik = ucenikData.Korisnik;
                var razred = ucenikData.Razred;

                // Fetch attendance records for the specific Ucenik and Razred
                var attendanceRecords = await _dbContext.Prisustvo
                    .Where(p => p.KorisnikId == ucenik.Id && p.RazredId == razred.Id)
                    .ToListAsync();

                int totalClasses = attendanceRecords.Count;
                if (totalClasses > 0)
                {
                    int presentCount = attendanceRecords.Count(p => p.Prisutan == true);
                    double attendancePercentage = (double)presentCount / totalClasses * 100;
                    ucenik.Prisustvo = attendancePercentage;
                }
                else
                {
                    ucenik.Prisustvo = 0;
                }

                // Fetch zadace (assignments) for the Ucenik's Razred to calculate the average grade
                var zadace = await _dbContext.Zadaca
                    .Where(z => z.RazredId == razred.Id && z.KorisnikId == ucenik.Id)
                    .Include(z => z.Ocjene)
                    .ToListAsync();

                if (zadace.Count > 0)
                {
                    double averageGrade = (double)zadace.Average(z => z.Ocjene.Ocjena); // Assuming Ocjene has a property 'Ocjena'
                    ucenik.Prosjek = averageGrade;
                }
                else
                {
                    ucenik.Prosjek = 0; // No grades available
                }

                // Set the Razred name for the student
                ucenik.NazivRazreda = razred.Naziv;
                ucenik.IdRazreda = razred.Id;
            }

            PagedResult<KorisnikM> result = new PagedResult<KorisnikM>
            {
                Count = uceniciWithAttendance.Count,
                Result = _mapper.Map<List<KorisnikM>>(uceniciWithAttendance.Select(ud => ud.Korisnik).ToList())
            };

            return result;
        }



        public async Task<PagedResult<KorisnikM>> GetMualimi(int? Id)
        {
            var ucenikRoleName = "Imam";

            var uceniciQuery = _dbContext.Set<Korisnik>()
                .Where(k => k.KorisniciUloge.Any(ku => ku.Uloga.Naziv == ucenikRoleName));

            if (Id.HasValue)
            {
                uceniciQuery = uceniciQuery.Where(k => k.MektebId == Id.Value);
            }

            var ucenici = await uceniciQuery.ToListAsync();

            PagedResult<KorisnikM> result = new PagedResult<KorisnikM>
            {
                Count = ucenici.Count,
                Result = _mapper.Map<List<KorisnikM>>(ucenici)
            };

            return result;
        }

        public async Task<PagedResult<KorisnikM>> GetKomisija(int? Id)
        {
            var RoleName = "Komisija";

            var komisijaQuery = _dbContext.Set<Korisnik>()
                .Where(k => k.KorisniciUloge.Any(ku => ku.Uloga.Naziv == RoleName));

            if (Id.HasValue)
            {
                komisijaQuery = komisijaQuery.Where(k => k.MektebId == Id.Value);
            }

            var komisija = await komisijaQuery.ToListAsync();

            PagedResult<KorisnikM> result = new PagedResult<KorisnikM>
            {
                Count = komisija.Count,
                Result = _mapper.Map<List<KorisnikM>>(komisija)
            };

            return result;
        }

        public async Task<PagedResult<KorisnikM>> GetAdmin(int? Id)
        {
            var RoleName = "Admin";

            var adminQuery = _dbContext.Set<Korisnik>()
                .Where(k => k.KorisniciUloge.Any(ku => ku.Uloga.Naziv == RoleName));

            if (Id.HasValue)
            {
                adminQuery = adminQuery.Where(k => k.MektebId == Id.Value);
            }

            var admin = await adminQuery.ToListAsync();

            PagedResult<KorisnikM> result = new PagedResult<KorisnikM>
            {
                Count = admin.Count,
                Result = _mapper.Map<List<KorisnikM>>(admin)
            };

            return result;
        }

        public async Task<bool> ChangePassword(int userId, string oldPassword, string newPassword)
        {
            var user = await _dbContext.Korisnik.FindAsync(userId);
            if (user == null)
            {
                throw new Exception("User not found");
            }

            if (GenerateHash(user.LozinkaSalt, oldPassword) != user.LozinkaHash)
            {
                throw new Exception("Old password is incorrect");
            }

            var newSalt = GenerateSalt();
            var newHash = GenerateHash(newSalt, newPassword);

            user.LozinkaSalt = newSalt;
            user.LozinkaHash = newHash;

            await _dbContext.SaveChangesAsync();

            return true;
        }
        public async Task<bool> ChangePassword(ChangePasswordRequest request)
        {
            var user = await _dbContext.Korisnik.FindAsync(request.UserId);
            if (user == null)
            {
                throw new Exception("User not found");
            }

            if (GenerateHash(user.LozinkaSalt, request.OldPassword) != user.LozinkaHash)
            {
                throw new Exception("Old password is incorrect");
            }

            var newSalt = GenerateSalt();
            var newHash = GenerateHash(newSalt, request.NewPassword);

            user.LozinkaSalt = newSalt;
            user.LozinkaHash = newHash;

            // Save changes
            await _dbContext.SaveChangesAsync();

            return true;
        }



        public override async Task<KorisnikM> Update(int id, KorisnikUpdate update)
        {
            var korisnik = await _dbContext.Korisnik.FindAsync(id);
            if (korisnik == null)
            {
                throw new Exception("User not found");
            }

            _mapper.Map(update, korisnik);

            // Handle password change
           // if (!string.IsNullOrEmpty(update.OldPassword) && !string.IsNullOrEmpty(update.NewPassword))
           // {
           //     if (GenerateHash(korisnik.LozinkaSalt, update.OldPassword) != korisnik.LozinkaHash)
           //     {
           //         throw new Exception("Old password is incorrect");
           //     }
           //
           //     var newSalt = GenerateSalt();
           //     var newHash = GenerateHash(newSalt, update.NewPassword);
           //     korisnik.LozinkaSalt = newSalt;
           //     korisnik.LozinkaHash = newHash;
           // }

             _dbContext.SaveChangesAsync();
            return _mapper.Map<KorisnikM>(korisnik);
        }


        public override async Task<PagedResult<KorisnikM>> Get(KorisnikSearchObject? search)
        {
            // Perform a left join so that ucenici are returned even if they don't have entries in RazredKorisnik
            var uceniciQuery = _dbContext.Set<Korisnik>()
                .GroupJoin(_dbContext.RazredKorisnik,
                    k => k.Id,
                    kr => kr.KorisnikId,
                    (k, krGroup) => new { Korisnik = k, KorisnikRazredi = krGroup })
                .SelectMany(
                    kKr => kKr.KorisnikRazredi.DefaultIfEmpty(),
                    (kKr, kr) => new { kKr.Korisnik, KorisnikRazred = kr })
                .GroupJoin(_dbContext.Razred,
                    kKr => kKr.KorisnikRazred.RazredId,
                    r => r.Id,
                    (kKr, rGroup) => new { kKr.Korisnik, Razred = rGroup.FirstOrDefault() });

            var uceniciWithAttendance = await uceniciQuery.ToListAsync();

            foreach (var ucenikData in uceniciWithAttendance)
            {
                var ucenik = ucenikData.Korisnik;
                var razred = ucenikData.Razred;

                // Fetch attendance records for the specific Ucenik and Razred if Razred exists
                var attendanceRecords = razred != null
                    ? await _dbContext.Prisustvo
                        .Where(p => p.KorisnikId == ucenik.Id && p.RazredId == razred.Id)
                        .ToListAsync()
                    : new List<Prisustvo>(); // No Razred means no attendance records

                int totalClasses = attendanceRecords.Count;
                if (totalClasses > 0)
                {
                    int presentCount = attendanceRecords.Count(p => p.Prisutan == true);
                    double attendancePercentage = (double)presentCount / totalClasses * 100;
                    ucenik.Prisustvo = Math.Round(attendancePercentage, 0); // Round to 0 decimal places
                }
                else
                {
                    ucenik.Prisustvo = 0;
                }

                // Fetch zadace (assignments) for the Ucenik's Razred to calculate the average grade if Razred exists
                var zadace = razred != null
                    ? await _dbContext.Zadaca
                        .Where(z => z.RazredId == razred.Id && z.KorisnikId == ucenik.Id)
                        .Include(z => z.Ocjene)
                        .ToListAsync()
                    : new List<Zadaca>(); // No Razred means no zadace records

                if (zadace.Count > 0)
                {
                    double averageGrade = (double)zadace.Average(z => z.Ocjene.Ocjena); // Assuming Ocjene has a property 'Ocjena'
                    ucenik.Prosjek = Math.Round(averageGrade, 1); // Round to 1 decimal place
                }
                else
                {
                    ucenik.Prosjek = 0; // No grades available
                }

                // Set the Razred name for the student, or "N/A" if no Razred exists
                ucenik.NazivRazreda = razred?.Naziv ?? "N/A";
            }

            // Map the result to KorisnikM and return the paged result
            PagedResult<KorisnikM> result = new PagedResult<KorisnikM>
            {
                Count = uceniciWithAttendance.Count,
                Result = _mapper.Map<List<KorisnikM>>(uceniciWithAttendance.Select(ud => ud.Korisnik).ToList())
            };

            return result;
        }



        public override async Task<KorisnikM> GetById(int id)
        {
            // Query the ucenik through a left join to include Korisnik even if there's no matching RazredKorisnik entry
            var ucenikQuery = await _dbContext.Set<Korisnik>()
                .GroupJoin(_dbContext.RazredKorisnik,
                    k => k.Id,
                    kr => kr.KorisnikId,
                    (k, krGroup) => new { Korisnik = k, KorisnikRazredi = krGroup })
                .SelectMany(
                    kKr => kKr.KorisnikRazredi.DefaultIfEmpty(),
                    (kKr, kr) => new { kKr.Korisnik, KorisnikRazred = kr })
                .GroupJoin(_dbContext.Razred,
                    kKr => kKr.KorisnikRazred.RazredId,
                    r => r.Id,
                    (kKr, rGroup) => new { kKr.Korisnik, Razred = rGroup.FirstOrDefault() })
                .Where(k => k.Korisnik.Id == id)
                .FirstOrDefaultAsync();

            if (ucenikQuery == null)
            {
                throw new Exception("Korisnik not found");
            }

            var ucenik = ucenikQuery.Korisnik;
            var razred = ucenikQuery.Razred;

            // Fetch attendance records for the specific Ucenik and Razred if Razred exists
            var attendanceRecords = razred != null
                ? await _dbContext.Prisustvo
                    .Where(p => p.KorisnikId == ucenik.Id && p.RazredId == razred.Id)
                    .ToListAsync()
                : new List<Prisustvo>(); // No Razred means no attendance records

            int totalClasses = attendanceRecords.Count;
            if (totalClasses > 0)
            {
                int presentCount = attendanceRecords.Count(p => p.Prisutan == true);
                double attendancePercentage = (double)presentCount / totalClasses * 100;
                ucenik.Prisustvo = Math.Round(attendancePercentage, 0); // Round to 0 decimal places
            }
            else
            {
                ucenik.Prisustvo = 0;
            }

            // Fetch zadace (assignments) for the Ucenik's Razred to calculate the average grade if Razred exists
            var zadace = razred != null
                ? await _dbContext.Zadaca
                    .Where(z => z.RazredId == razred.Id && z.KorisnikId == ucenik.Id)
                    .Include(z => z.Ocjene)
                    .ToListAsync()
                : new List<Zadaca>(); // No Razred means no zadace records

            if (zadace.Count > 0)
            {
                double averageGrade = (double)zadace.Average(z => z.Ocjene.Ocjena); // Assuming Ocjene has a property 'Ocjena'
                ucenik.Prosjek = Math.Round(averageGrade, 1); // Round to 1 decimal place
            }
            else
            {
                ucenik.Prosjek = 0; // No grades available
            }

            ucenik.NazivRazreda = razred?.Naziv ?? "N/A"; // Set Razred name if it exists, otherwise "N/A"
            ucenik.IdRazreda = razred?.Id ?? 0;

            var result = _mapper.Map<KorisnikM>(ucenik);

            return result;
        }



    }

}
