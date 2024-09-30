using AutoMapper;
using eMekteb.Model;
using eMekteb.Model.Request;
using eMekteb.Services.Database;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;


namespace eMekteb.Services
{
    public class MappingProfile : Profile
    {
        public MappingProfile()
        {
            CreateMap<Mekteb, MektebM>();
            CreateMap<MektebM, Mekteb>();
            CreateMap<MektebInsert, Mekteb>();
            CreateMap<MektebUpdate, Mekteb>();

            CreateMap<Medzlis, MedzlisM>();
            CreateMap<MedzlisM, Medzlis>();
            CreateMap<MedzlisInsert, Medzlis>();
            CreateMap<MedzlisUpdate, Medzlis>();

            CreateMap<Obavijest, ObavijestM>();
            CreateMap<ObavijestM, Obavijest>();
            CreateMap<ObavijestInsert, Obavijest >();
            CreateMap<ObavijestUpdate, Obavijest>();

            CreateMap<Ocjene, OcjeneM>();
            CreateMap<OcjeneM, Ocjene>();
            CreateMap<OcjeneInsert, Ocjene>();
            CreateMap<OcjeneUpdate, Ocjene>();

            CreateMap<Prisustvo, PrisustvoM>();
            CreateMap<PrisustvoM, Prisustvo>();
            CreateMap<PrisustvoInsert, Prisustvo>();

            CreateMap<Razred, RazredM>();
            CreateMap<RazredM, Razred>();
            CreateMap<RazredInsert, Razred>();
            CreateMap<RazredUpdate, Razred>();

            CreateMap<Takmicar, TakmicarM>();
            CreateMap<TakmicarM, Takmicar>();
            CreateMap<TakmicarInsert, Takmicar>();
            CreateMap<TakmicarUpdate, Takmicar>();

            CreateMap<Takmicenje, TakmicenjeM>();
            CreateMap<TakmicenjeM, Takmicenje>();
            CreateMap<TakmicenjeInsert, Takmicenje>();
            CreateMap<TakmicenjeUpdate, Takmicenje>();

            CreateMap<Kategorija, KategorijaM>();
            CreateMap<KategorijaM, Kategorija>();
            CreateMap<KategorijaInsert, Kategorija>();

            CreateMap<TakmicenjeKategorija, TakmicenjeKategorijaM>();
            CreateMap<TakmicenjeKategorijaM, TakmicenjeKategorija>();
            CreateMap<TakmicenjeKategorijaInsert, TakmicenjeKategorija>();

            CreateMap<Uloga, UlogaM>();
            CreateMap<UlogaM, Uloga>();
            CreateMap<UlogaInsert, Uloga>();

            CreateMap<Zadaca, ZadacaM>();
            CreateMap<ZadacaM, Zadaca>();
            CreateMap<ZadacaInsert, Zadaca>();
            CreateMap<ZadacaUpdate, Zadaca>();

            CreateMap<AkademskaGodina, AkademskaGodinaM>();
            CreateMap<AkademskaGodinaM, AkademskaGodina>();
            CreateMap<AkademskaGodinaInsert, AkademskaGodina>();
            CreateMap<AkademskaGodinaUpdate, AkademskaGodina>();


            CreateMap<DodatneLekcije, DodatneLekcijeM>();
            CreateMap<DodatneLekcijeM, DodatneLekcije>();
            CreateMap<DodatneLekcijeInsert, DodatneLekcije>();
            CreateMap<DodatneLekcijeUpdate, DodatneLekcije>();

            CreateMap<Kamp, KampM>();
            CreateMap<KampM, Kamp>();
            CreateMap<KampInsert, Kamp>();
            CreateMap<KampUpdate, Kamp>();

            CreateMap<Korisnik, KorisnikM>();
            CreateMap<KorisnikM, Korisnik>();
            CreateMap<KorisnikInsert, Korisnik>();
            CreateMap<KorisnikUpdate, Korisnik>();

            CreateMap<KorisniciUloge, KorisniciUlogeM>();
            CreateMap<KorisniciUlogeM, KorisniciUloge>();
            CreateMap<KorisniciUlogeInsert, KorisniciUloge>();
            CreateMap<KorisniciUlogeUpdate, KorisniciUloge>();

            CreateMap<Cas, CasM>();
            CreateMap<CasM, Cas>();
            CreateMap<CasInsert, Cas>();
            CreateMap<CasUpdate, Cas>();

            CreateMap<KampKorisnik, KampKorisnikM>();
            CreateMap<KampKorisnikM, KampKorisnik>();
            CreateMap<KampKorisnikInsert, KampKorisnik>();
            CreateMap<KampKorisnikUpdate, KampKorisnik>();

            CreateMap<Slika, SlikaM>();
            CreateMap<SlikaM, Slika>();
            CreateMap<SlikaInsert, Slika>();
            CreateMap<SlikaUpdate, Slika>();

            CreateMap<AkademskaMekteb, AkademskaMektebM>();
            CreateMap<AkademskaMektebM, AkademskaMekteb>();
            CreateMap<AkademskaMektebInsert, AkademskaMekteb>();
            CreateMap<AkademskaGodinaUpdate, AkademskaMekteb>();


        }


    }
}
