﻿using AutoMapper;
using eMekteb.Model;
using eMekteb.Model.Helpers;
using eMekteb.Model.SearchObjects;
using eMekteb.Services.Database;
using eMekteb.Services.Interfaces;
using Microsoft.EntityFrameworkCore;
using System.Security.Cryptography;
using System.Text;

namespace eMekteb.Services
{
    public class KorisnikService : BaseCRUDService<KorisnikM, Korisnik, KorisnikSearchObject, KorisnikInsert, KorisnikUpdate>, IKorisnikService
    {

        public KorisnikService(eMektebContext dbContext, IMapper mapper)
            : base(dbContext, mapper)
        {
        }

        public async Task<PagedResult<KorisnikM>> GetUcenikHistory(int? ucenikId)
        {
            if (ucenikId == null)
            {
                throw new ArgumentNullException(nameof(ucenikId), "UcenikId cannot be null");
            }

            var lastAkademskaGodinaId = await _dbContext.AkademskaGodina
                .OrderByDescending(ag => ag.Id)
                .Select(ag => ag.Id)
                .FirstOrDefaultAsync();

            var razrediHistory = await _dbContext.RazredKorisnik
                .Where(kr => kr.KorisnikId == ucenikId)
                .Join(_dbContext.Razred,
                      kr => kr.RazredId,
                      r => r.Id,
                      (kr, r) => new { Razred = r, KorisnikRazred = kr })
                .Join(_dbContext.AkademskaRazred,
                      r => r.Razred.Id,
                      ra => ra.RazredId,
                      (r, ra) => new { r.Razred, ra.AkademskaGodinaId })
                .Where(ra => ra.AkademskaGodinaId < lastAkademskaGodinaId) 
                .Select(ra => new { ra.Razred.Id, ra.Razred.Naziv })
                .Distinct().OrderByDescending(r => r.Id)  
                .ToListAsync();

            var resultList = new List<KorisnikM>();

            foreach (var razred in razrediHistory)
            {
                var attendanceRecords = await _dbContext.Prisustvo
                    .Where(p => p.KorisnikId == ucenikId && p.RazredId == razred.Id)
                    .ToListAsync();

                double attendancePercentage = 0;
                if (attendanceRecords.Any())
                {
                    int totalClasses = attendanceRecords.Count;
                    int presentCount = attendanceRecords.Count(p => p.Prisutan == true);
                    attendancePercentage = (double)presentCount / totalClasses * 100;
                }

                var zadace = await _dbContext.Zadaca
                    .Where(z => z.KorisnikId == ucenikId && z.RazredId == razred.Id)
                    .Include(z => z.Ocjene)
                    .ToListAsync();

                double averageGrade = 0;
                if (zadace.Any())
                {
                    averageGrade = (double)zadace.Average(z => z.Ocjene.Ocjena);
                }

                var korisnikM = new KorisnikM
                {
                    NazivRazreda = razred.Naziv,
                    IdRazreda = razred.Id,
                    Prosjek = Math.Round(averageGrade, 1), 
                    Prisustvo = Math.Round(attendancePercentage, 1) 
                };

                resultList.Add(korisnikM);
            }

            var result = new PagedResult<KorisnikM>
            {
                Count = resultList.Count,
                Result = resultList
            };

            return result;
        }


        public async Task<PagedResult<KorisnikM>> GetByRoditeljId(int roditeljId)
        {
            var lastAkademskaGodina = await _dbContext.AkademskaGodina
                .OrderByDescending(ag => ag.DatumPocetka)
                .FirstOrDefaultAsync();

            if (lastAkademskaGodina == null)
            {
                throw new Exception("No academic years found");
            }

            var items = await _dbContext.Korisnik
                .Where(k => k.RoditeljId == roditeljId)
                .Join(_dbContext.RazredKorisnik,
                    k => k.Id,
                    kr => kr.KorisnikId,
                    (k, kr) => new { Korisnik = k, KorisnikRazred = kr })
                .Join(_dbContext.Razred,
                    kr => kr.KorisnikRazred.RazredId,
                    r => r.Id,
                    (kr, r) => new { kr.Korisnik, Razred = r })
                .Join(_dbContext.AkademskaRazred,
                    r => r.Razred.Id,
                    agr => agr.RazredId,
                    (r, agr) => new { r.Korisnik, Razred = r.Razred, agr.AkademskaGodinaId })
                .Where(agr => agr.AkademskaGodinaId == lastAkademskaGodina.Id)
                .Select(agr => new
                {
                    Korisnik = agr.Korisnik,
                    agr.Razred.Id,
                    agr.Razred.Naziv
                })
                .Distinct()
                .ToListAsync();

            foreach (var item in items)
            {
                var ucenik = item.Korisnik;
                var razredId = item.Id;
                var razredNaziv = item.Naziv;

                var attendanceRecords = await _dbContext.Prisustvo
                    .Where(p => p.KorisnikId == ucenik.Id && p.RazredId == razredId)
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

                var zadace = await _dbContext.Zadaca
                    .Where(z => z.KorisnikId == ucenik.Id && z.RazredId == razredId)
                    .Include(z => z.Ocjene)
                    .ToListAsync();

                int totalzadace = zadace.Count;
                if (zadace.Count > 0)
                {
                    double averageGrade = (double)zadace.Average(z => z.Ocjene.Ocjena); 
                    ucenik.Prosjek = averageGrade;
                }
                else
                {
                    ucenik.Prosjek = 0; // No grades available
                }

                ucenik.NazivRazreda = razredNaziv;
                ucenik.IdRazreda = razredId;
            }

            var result = new PagedResult<KorisnikM>
            {
                Count = items.Count,
                Result = _mapper.Map<List<KorisnikM>>(items.Select(i => i.Korisnik).Distinct().ToList())
            };

            return result;
        }


        private async Task<string> GenerateUniqueUsernameAsync(string baseUsername)
        {
            var usernames = await _dbContext.Korisnik
                .Where(k => k.Username.StartsWith(baseUsername))
                .Select(k => k.Username)
                .ToListAsync();

            if (!usernames.Contains(baseUsername))
                return baseUsername;

            int counter = 1;
            string newUsername;

            do
            {
                newUsername = $"{baseUsername}{counter}";
                counter++;
            } while (usernames.Contains(newUsername));

            return newUsername;
        }


        public async Task<UcenikRoditeljResponse> CreateStudentWithParentAsync(KorisnikInsert studentInsert, KorisnikInsert parentInsert)
        {
            var existingParent = await _dbContext.Korisnik
                .FirstOrDefaultAsync(k => k.Telefon == parentInsert.Telefon);

            Korisnik parentEntity;
            if (existingParent == null)
            {
                parentInsert.Username = await GenerateUniqueUsernameAsync(parentInsert.Username);
                parentEntity = _mapper.Map<Korisnik>(parentInsert);
                await BeforeInsert(parentEntity, parentInsert);

                _dbContext.Korisnik.Add(parentEntity);
                await _dbContext.SaveChangesAsync();
            }
            else
            {
                parentEntity = existingParent;
            }

            // GENERIŠI UNIQUE USERNAME za učenika
            studentInsert.Username = await GenerateUniqueUsernameAsync(studentInsert.Username);

            var studentEntity = _mapper.Map<Korisnik>(studentInsert);

            studentEntity.RoditeljId = parentEntity.Id;

            await BeforeInsert(studentEntity, studentInsert);

            _dbContext.Korisnik.Add(studentEntity);
            await _dbContext.SaveChangesAsync();

            var mailText = $@"
                 <p>Poštovani {parentEntity.Ime} {parentEntity.Prezime},</p>
                 <p>Vaš korisnički profil za eMekteb je uspješno kreiran.</p>
                 <p><strong>Username:</strong> {parentEntity.Username}<br/>
                 <strong>Privremena lozinka:</strong> {parentEntity.Ime?.ToLower()}1234</p>

                 <p>Također, kreiran je korisnički račun za Vaše dijete:</p>
                 <p><strong>Ime djeteta:</strong> {studentEntity.Ime} {studentEntity.Prezime}<br/>
                 <strong>Username djeteta:</strong> {studentEntity.Username}</p>
                 <strong>Privremena lozinka za vaše dijete:</strong> {studentEntity.Ime?.ToLower()}1234</p>
                 <p>Molimo Vas da prilikom prve prijave promijenite lozinke.</p>
                 <p>Lijep pozdrav,<br/>eMekteb tim</p>";

            var mailObj = new MailObjekat
            {
                mailAdresa = parentEntity.Mail,
                subject = "Vaš korisnički profil na eMektebu",
                poruka = mailText
            };

            var mailService = new MailSendingService();
            await mailService.PosaljiMail(mailObj);

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
            if (search?.NeededId != null)
            {
                query = query.Where(m => m.MedzlisId == search.NeededId);
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
 var ucenikRoleName = "Admin";
            if (hash != entity.LozinkaHash)
            {
                return null;
            }

            return _mapper.Map<KorisnikM>(entity);
        }

   

        public async Task<PagedResult<KorisnikM>> GetMualimi(int? Id, int? MedzlisId, int? MuftijstvoId)
        {
            var ucenikRoleName = "Imam";

            var uceniciQuery = _dbContext.Set<Korisnik>()
                .Where(k => k.KorisniciUloge.Any(ku => ku.Uloga.Naziv == ucenikRoleName));


            if (Id.HasValue)
            {
                uceniciQuery = uceniciQuery.Where(k => k.MektebId == Id.Value);
            }
            if (MedzlisId.HasValue)
            {
                uceniciQuery = uceniciQuery.Where(k => k.MedzlisId == MedzlisId.Value);
            } 
            if (MuftijstvoId.HasValue)
            {
                uceniciQuery = uceniciQuery.Where(k => k.Medzlis.MuftijstvoId == MuftijstvoId.Value);
            }


            var ucenici = await uceniciQuery.ToListAsync();

            PagedResult<KorisnikM> result = new PagedResult<KorisnikM>
            {
                Count = ucenici.Count,
                Result = _mapper.Map<List<KorisnikM>>(ucenici)
            };

            return result;
        }

        public async Task<PagedResult<KorisnikM>> GetKomisija(int? Id, int? MedzlisId)
        {
            var RoleName = "Komisija";

            var komisijaQuery = _dbContext.Set<Korisnik>()
                .Where(k => k.KorisniciUloge.Any(ku => ku.Uloga.Naziv == RoleName));

            if (Id.HasValue)
            {
                komisijaQuery = komisijaQuery.Where(k => k.MektebId == Id.Value);
            }
            if (MedzlisId.HasValue)
            {
                komisijaQuery = komisijaQuery.Where(k => k.MedzlisId == MedzlisId.Value);
            }

            var komisija = await komisijaQuery.ToListAsync();

            PagedResult<KorisnikM> result = new PagedResult<KorisnikM>
            {
                Count = komisija.Count,
                Result = _mapper.Map<List<KorisnikM>>(komisija)
            };

            return result;
        }

        public async Task<PagedResult<KorisnikM>> GetAdmin(int? Id, int? MedzlisId, int? MuftijstvoId)
        {
            var RoleName = "Admin";

            var adminQuery = _dbContext.Set<Korisnik>()
                .Where(k => k.KorisniciUloge.Any(ku => ku.Uloga.Naziv == RoleName));

            if (Id.HasValue)
            {
                adminQuery = adminQuery.Where(k => k.MektebId == Id.Value);
            }
            if (MedzlisId.HasValue)
            {
                adminQuery = adminQuery.Where(k => k.MedzlisId == MedzlisId.Value);
            } 
            if (MuftijstvoId.HasValue)
            {
                adminQuery = adminQuery.Where(k => k.Medzlis!.MuftijstvoId == MuftijstvoId.Value);
            }

            var admin = await adminQuery.ToListAsync();

            PagedResult<KorisnikM> result = new PagedResult<KorisnikM>
            {
                Count = admin.Count,
                Result = _mapper.Map<List<KorisnikM>>(admin)
            };

            return result;
        } 
        
        public async Task<PagedResult<KorisnikM>> GetSuperAdmin(int? Id, int? MuftijstvoId)
        {
            var RoleName = "SuperAdmin";

            var superAdminQuery = _dbContext.Set<Korisnik>()
                .Where(k => k.KorisniciUloge.Any(ku => ku.Uloga.Naziv == RoleName));

            if (Id.HasValue)
            {
                superAdminQuery = superAdminQuery.Where(k => k.MektebId == Id.Value);
            }
   
            if (MuftijstvoId.HasValue)
            {
                superAdminQuery = superAdminQuery.Where(k => k.MuftijstvoId == MuftijstvoId.Value);
            }

            var admin = await superAdminQuery.ToListAsync();

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

          

            await _dbContext.SaveChangesAsync();
            return _mapper.Map<KorisnikM>(korisnik);
        }


        public override async Task<PagedResult<KorisnikM>> Get(KorisnikSearchObject? search)
        {
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

                var attendanceRecords = razred != null
                    ? await _dbContext.Prisustvo
                        .Where(p => p.KorisnikId == ucenik.Id && p.RazredId == razred.Id)
                        .ToListAsync()
                    : new List<Prisustvo>();

                int totalClasses = attendanceRecords.Count;
                if (totalClasses > 0)
                {
                    int presentCount = attendanceRecords.Count(p => p.Prisutan == true);
                    double attendancePercentage = (double)presentCount / totalClasses * 100;
                    ucenik.Prisustvo = Math.Round(attendancePercentage, 0); 
                }
                else
                {
                    ucenik.Prisustvo = 0;
                }

                var zadace = razred != null
                    ? await _dbContext.Zadaca
                        .Where(z => z.RazredId == razred.Id && z.KorisnikId == ucenik.Id)
                        .Include(z => z.Ocjene)
                        .ToListAsync()
                    : new List<Zadaca>(); 

                if (zadace.Count > 0)
                {
                    double averageGrade = (double)zadace.Average(z => z.Ocjene.Ocjena);
                    ucenik.Prosjek = Math.Round(averageGrade, 1);
                }
                else
                {
                    ucenik.Prosjek = 0;
                }

                ucenik.NazivRazreda = razred?.Naziv ?? "N/A";
            }

            PagedResult<KorisnikM> result = new PagedResult<KorisnikM>
            {
                Count = uceniciWithAttendance.Count,
                Result = _mapper.Map<List<KorisnikM>>(uceniciWithAttendance.Select(ud => ud.Korisnik).Distinct().ToList())
            };

            return result;
        }

       
        public override async Task<KorisnikM> GetById(int id)
        {
            var korisnik = await _dbContext.Set<Korisnik>()
                .Where(k => k.Id == id)
                .FirstOrDefaultAsync();

            if (korisnik == null)
            {
                throw new Exception("Korisnik not found");
            }

            var lastAkademskaGodinaId = await _dbContext.AkademskaGodina
                .OrderByDescending(ag => ag.Id)
                .Select(ag => ag.Id)
                .FirstOrDefaultAsync();

            var korisnikRazredData = await _dbContext.RazredKorisnik
                .Where(kr => kr.KorisnikId == korisnik.Id)
                .Join(_dbContext.Razred,
                      kr => kr.RazredId,
                      r => r.Id,
                      (kr, r) => new { KorisnikRazred = kr, Razred = r })
                .Join(_dbContext.AkademskaRazred,
                      r => r.Razred.Id,
                      ra => ra.RazredId,
                      (r, ra) => new { r.KorisnikRazred, r.Razred, RazredAkademska = ra })
                .Where(ra => ra.RazredAkademska.AkademskaGodinaId == lastAkademskaGodinaId)
                .OrderByDescending(ra => ra.KorisnikRazred.Id) 
                .FirstOrDefaultAsync(); 

            if (korisnikRazredData == null)
            {
                korisnik.NazivRazreda = "N/A";
                korisnik.IdRazreda = 0;
                korisnik.Prisustvo = 0;
                korisnik.Prosjek = 0;
            }
            else
            {
                var razred = korisnikRazredData.Razred;

                var attendanceRecords = await _dbContext.Prisustvo
                    .Where(p => p.KorisnikId == korisnik.Id && p.RazredId == razred.Id)
                    .ToListAsync();

                int totalClasses = attendanceRecords.Count;
                if (totalClasses > 0)
                {
                    int presentCount = attendanceRecords.Count(p => p.Prisutan == true);
                    double attendancePercentage = (double)presentCount / totalClasses * 100;
                    korisnik.Prisustvo = Math.Round(attendancePercentage, 0); 
                }
                else
                {
                    korisnik.Prisustvo = 0;
                }

                var zadace = await _dbContext.Zadaca
                    .Where(z => z.RazredId == razred.Id && z.KorisnikId == korisnik.Id)
                    .Include(z => z.Ocjene)
                    .ToListAsync();

                if (zadace.Count > 0)
                {
                    double averageGrade = (double)zadace.Average(z => z.Ocjene.Ocjena);
                    korisnik.Prosjek = Math.Round(averageGrade, 1); 
                }
                else
                {
                    korisnik.Prosjek = 0; 
                }

                korisnik.NazivRazreda = razred.Naziv;
                korisnik.IdRazreda = razred.Id;
            }

            var result = _mapper.Map<KorisnikM>(korisnik);
            return result;
        }

        //Get ucenici by mekteb && Get svi ucenici
        public async Task<PagedResult<KorisnikM>> GetUcenici(int? mektebId, int? MedzlisId)
        {
            var ucenikRoleName = "Ucenik";

            var lastAkademskaGodinaId = await _dbContext.AkademskaGodina
                .OrderByDescending(ag => ag.Id)
                .Select(ag => ag.Id)
                .FirstOrDefaultAsync();

            var uceniciQuery = _dbContext.Set<Korisnik>()
                 .Where(k => k.KorisniciUloge.Any(ku => ku.Uloga.Naziv == ucenikRoleName) && k.Status == "Aktivan")
                 .Join(_dbContext.RazredKorisnik,
                       k => k.Id,
                       kr => kr.KorisnikId,
                       (k, kr) => new { Korisnik = k, KorisnikRazred = kr })
                 .Join(_dbContext.Razred,
                       kr => kr.KorisnikRazred.RazredId,
                       r => r.Id,
                       (kr, r) => new { kr.Korisnik, Razred = r })
                 .Join(_dbContext.Mekteb,
                       r => r.Razred.MektebId,
                       m => m.Id,
                       (r, m) => new { r.Korisnik, Razred = r.Razred, Mekteb = m })
                 .Join(_dbContext.AkademskaRazred,
                       r => r.Razred.Id,
                       ra => ra.RazredId,
                       (r, ra) => new { r.Korisnik, r.Razred, r.Mekteb, RazredAkademska = ra })
                 .Where(ra => ra.RazredAkademska.AkademskaGodinaId == lastAkademskaGodinaId)
                 .Distinct();

            if (mektebId.HasValue)
            {
                uceniciQuery = uceniciQuery.Where(k => k.Razred.MektebId == mektebId.Value);
            }
            if (MedzlisId.HasValue)
            {
                uceniciQuery = uceniciQuery.Where(k => k.Mekteb.MedzlisId == MedzlisId.Value);
            }

            var uceniciWithAttendance = await uceniciQuery
                .Distinct()
                .ToListAsync();

            foreach (var ucenikData in uceniciWithAttendance)
            {
                var ucenik = ucenikData.Korisnik;
                var razred = ucenikData.Razred;

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

                var zadace = await _dbContext.Zadaca
                    .Where(z => z.RazredId == razred.Id && z.KorisnikId == ucenik.Id)
                    .Include(z => z.Ocjene)
                    .ToListAsync();

                if (zadace.Count > 0)
                {
                    double averageGrade = (double)zadace.Average(z => z.Ocjene.Ocjena);
                    ucenik.Prosjek = averageGrade;
                }
                else
                {
                    ucenik.Prosjek = 0;
                }

                ucenik.NazivRazreda = razred.Naziv;
                ucenik.IdRazreda = razred.Id;
            }

            PagedResult<KorisnikM> result = new PagedResult<KorisnikM>
            {
                Count = uceniciWithAttendance.Select(ud => ud.Korisnik.Id).Distinct().Count(),
                Result = _mapper.Map<List<KorisnikM>>(uceniciWithAttendance.Select(ud => ud.Korisnik).Distinct().ToList())
            };

            return result;
        }

        public async Task<PagedResult<KorisnikM>> GetArhivUcenika(int? mektebId, int? MedzlisId)
        {
            var ucenikRoleName = "Ucenik";

            var lastAkademskaGodinaId = await _dbContext.AkademskaGodina
                .OrderByDescending(ag => ag.Id)
                .Select(ag => ag.Id)
                .FirstOrDefaultAsync();

            var uceniciQuery = _dbContext.Set<Korisnik>()
                 .Where(k => k.KorisniciUloge.Any(ku => ku.Uloga.Naziv == ucenikRoleName) &&
                             (k.Status == "Završio" || k.Status == "Neaktivan"))
                 .Join(_dbContext.RazredKorisnik,
                       k => k.Id,
                       kr => kr.KorisnikId,
                       (k, kr) => new { Korisnik = k, KorisnikRazred = kr })
                 .Join(_dbContext.Razred,
                       kr => kr.KorisnikRazred.RazredId,
                       r => r.Id,
                       (kr, r) => new { kr.Korisnik, Razred = r })
                 .Join(_dbContext.Mekteb,
                       r => r.Razred.MektebId,
                       m => m.Id,
                       (r, m) => new { r.Korisnik, Razred = r.Razred, Mekteb = m })
                 .Join(_dbContext.AkademskaRazred,
                       r => r.Razred.Id,
                       ra => ra.RazredId,
                       (r, ra) => new { r.Korisnik, r.Razred, r.Mekteb, RazredAkademska = ra })
                 .Where(ra => ra.RazredAkademska.AkademskaGodinaId == lastAkademskaGodinaId)
                 .Distinct();

            if (mektebId.HasValue)
            {
                uceniciQuery = uceniciQuery.Where(k => k.Razred.MektebId == mektebId.Value);
            }
            if (MedzlisId.HasValue)
            {
                uceniciQuery = uceniciQuery.Where(k => k.Mekteb.MedzlisId == MedzlisId.Value);
            }

            var uceniciWithAttendance = await uceniciQuery
                .Distinct()
                .ToListAsync();

            foreach (var ucenikData in uceniciWithAttendance)
            {
                var ucenik = ucenikData.Korisnik;
                var razred = ucenikData.Razred;

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

                var zadace = await _dbContext.Zadaca
                    .Where(z => z.RazredId == razred.Id && z.KorisnikId == ucenik.Id)
                    .Include(z => z.Ocjene)
                    .ToListAsync();

                if (zadace.Count > 0)
                {
                    double averageGrade = (double)zadace.Average(z => z.Ocjene.Ocjena);
                    ucenik.Prosjek = averageGrade;
                }
                else
                {
                    ucenik.Prosjek = 0;
                }

                ucenik.NazivRazreda = razred.Naziv;
                ucenik.IdRazreda = razred.Id;
            }

            PagedResult<KorisnikM> result = new PagedResult<KorisnikM>
            {
                Count = uceniciWithAttendance.Select(ud => ud.Korisnik.Id).Distinct().Count(),
                Result = _mapper.Map<List<KorisnikM>>(uceniciWithAttendance.Select(ud => ud.Korisnik).Distinct().ToList())
            };

            return result;
        }


        private string GenerateRandomPassword(int length = 10)
        {
            const string valid = "ABCDEFGHJKLMNOPQRSTUVWXYZabcdefghijkmnopqrstuvwxyz0123456789!@#$";
            var res = new StringBuilder();
            using (var rng = RandomNumberGenerator.Create())
            {
                var uintBuffer = new byte[sizeof(uint)];
                while (res.Length < length)
                {
                    rng.GetBytes(uintBuffer);
                    var num = BitConverter.ToUInt32(uintBuffer, 0);
                    res.Append(valid[(int)(num % (uint)valid.Length)]);
                }
            }
            return res.ToString();
        }
        public async Task<bool> ResetPassword(string email)
        {
            var korisnik = _dbContext.Korisnik.FirstOrDefault(x => x.Mail == email);

            if (korisnik == null)
                return false;

            var novaLozinka = GenerateRandomPassword();

            korisnik.LozinkaSalt = GenerateSalt();
            korisnik.LozinkaHash = GenerateHash(korisnik.LozinkaSalt, novaLozinka);

            await _dbContext.SaveChangesAsync();

            var mail = new MailObjekat
            {
                mailAdresa = korisnik.Mail,
                subject = "Reset lozinke - eMekteb",
                poruka = $"Vaša nova lozinka je: <b>{novaLozinka}</b><br>Molimo vas da je promijenite nakon prve prijave."
            };

            var mailService = new MailSendingService();
            mailService.PosaljiMail(mail);

            return true;
        }




    }

}
