
using eMekteb.Services.Database;
using Microsoft.EntityFrameworkCore.Metadata.Builders;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eMekteb.Services.Seed
{
    public static class DodatneLekcijeData
    {
        public static void SeedData(this EntityTypeBuilder<DodatneLekcije> entity)
        {
            entity.HasData(
                new DodatneLekcije
                {
                    Id = 1,
                    Naziv = "Bereket masline",
                    Tekst = "U svome životu čovjek često dobiva samo jednu priliku da učini neko dobro djelo, vezano za njegovo trenutno stanje, trenutnu preokupaciju. Što se tiče uzroka na ovome svijetu, jedina stvar koja ga može nagnati i inspirirati da u pravome trenu uradi pravu stvar jeste njegovo društvo, osobe s kojima je često u kontaktu.\r\n\r\nUkoliko je čovjekovo društvo zdravo i pobožno, i on će uživati tu pobožnost makar sâm i ne bio toliko otvoren za vjeru. Kako naš narod izražava hazreti Pejgamberovu, alejhisselam, preporuku u formi vlastite mudrosti: „S kim si, takav si.“\r\n\r\nMaslinovo stablo blagoslovljeno je budući da je prvi put niklo na mjestu na kojemu se konstantno veličao uzvišeni Allah. Od toga vremena i od toga mjesta, svaka maslinova grančica blagoslovljena je baš kao i njen predak – stablo iz kojega je svo maslinovo drveće poteklo.\r\n\r\nI nadalje, svako ko u sebe unese sok, ulje, koje se dobiva iz ploda maslinovog stabla, i sâm će dobiti od njegovog berićeta, blagoslova, makar ga ne zasluživao. Jednostavno, stvorenje na koje uzvišeni Bog spusti Svoj blagoslov, taj će blagoslov širiti na sve s čime dođe u kontakt. Zato mudar vjernik traga za iskrenim Božijim robovima kojih, i pored sve žestine smutnje koja se može spustiti  na Zemlji, ima u svakome vremenu, na skoro svim mjestima.\r\n\r\nNeodgojen čovjek često odlazi u krajnost pa kada mu dragi Allah i podari da pronađe Njegovog iskrenog roba, neodgojeni ga prisvoji za sebe, guši ga svojom napadnošću, druge lišava berićeta a zaboravi i sâm sebe te se osloni da će ga sâmo druženje s takvom osobom, bez daljnjega rada na sebi, na odgoju vlastite duše, odvesti u džennet. U svemu treba mjera.",
                    DatumObjavljivanja = new DateTime(2024, 09, 12),
                    Likes = 2,
                    MektebId = 1,
                    Dislikes = 0
                },
                new DodatneLekcije
                {
                    Id = 2,
                    Naziv = "U dobrom društvu",
                    Tekst= "Insanu godi osama. Da se liši dunjaluka, svega što ga vezuje za ovaj dunjaluk, da se liši jastva. Da se liši i ahireta. Razmišljanja i želja vezanih za ahiret. Da se liši lišavanja. I ostane u Jednosti. U toj osami insanu godi društvo. Godi mu društvo dragih ljudi, dobrih ljudi. Društvo dobrih, koji su postigli Jedinstvo u mnoštvu. Da se ogleda u njihovom primjeru, u predajama o tim dobrima. Da osjećaj nedostajanja dobrih nadomjesti sjećanjem na njih, kroz značenjski duboke i slojevite predaje o dobrima. Naravno, želim podvući kako ove predaje ne treba doživljavati doslovno, banalno, već kroz njihovu značenjsku slojevitost. Da bismo dobili nadahnuće, da bismo ih imali kao lučonoše svjetlosti Istine.\r\n\r\nKako u tezkirama – spomenicama dobrih budem nalazila predaje o ovim velikanima, o ovom dobrom društvu, ja ću neke od njih prepričati na bosanskom jeziku, i tako ih dovoditi u naše vrijeme i naš, bosanski jezik. E da nam ZNACI ostanu. I za prijatelja koji nam na dunjalučki nedostaje, a koji je, čini se, pripadao ovome društvu.",
                    DatumObjavljivanja = new DateTime(2024, 09, 12),
                    Likes = 2,
                    MektebId = 1,
                    Dislikes = 0
                },        
                new DodatneLekcije
                {
                    Id = 3,
                    Naziv = "Islam i moderna nauka",
                    Tekst = "Ibn Haldun i filozofija historije\r\n\r\nU želji da koliko toliko upotpunimo predstavu o ortodoksnom stavu prema racionalnoj (modernoj) nauci u islamu obratit ćemo se na još jednog velikog učenjaka iz islamske tradicije sa izrazitim uticajem na modernu misao. Od kada su se krajem osamnaestog stoljeća, na Zapadu upoznali sa njegovim najpoznatijim djelom „Muqaddima“ („Uvod“), koji je uvod u njegovo historijsko djelo „Kitab al-'Ibar“, Ibn Haldun se konstantno označava pretečom moderne sociologije i filozofije povijesti. Izražen interes za proučavanje povijesti i društva koji se na Zapadu posebno razvio u moderno doba, povećao je interesovanje za ovog islamskog mislioca, dajući mu nerijetko status najvažnije ličnosti u historiji islamske misli.\r\n\r\nPosebno su izražena zapažanja da se Ibn Haldun svojim naučnim pristupom (i metodologijom u izvođenju stavova i zaključaka) izdvojio od, pa čak i suprostavio dotadašnjoj islamskoj tradicionalnoj filozofiji i nauci. Nama je u ovom tekstu Ibn Haldun važan iz nekoliko razloga.\r\n\r\nPrvo, zato što ne izlazeći iz okvira islamske ortodoksije baštini jedan (od el-Gazalija) racionalniji pristup islamskom svjetopogledu , pa želimo čuti i njegove stavove o modernoj nauci, posebno historiji. Drugi je razlog njegovo podrobnije bavljenje onim što se danas naziva društvena nauka, oblast koja nema centralno mjesto u el-Gazalijevom opusu. I treći razlog je da Ibn Haldun živi u vremenu u kojem je već moguć stanoviti historijski otklon od 'zlatnog doba' nauke u islamu, što mu daje mogućnost da istražuje uzroke stagnacije naučne aktivnosti.",
                    DatumObjavljivanja = new DateTime(2024, 09, 12),
                    Likes = 2,
                    MektebId = 1,
                    Dislikes = 0
                },
                new DodatneLekcije
                {
                    Id = 4,
                    Naziv = "U dobrom društvu",
                    Tekst = "Insanu godi osama. Da se liši dunjaluka, svega što ga vezuje za ovaj dunjaluk, da se liši jastva. Da se liši i ahireta. Razmišljanja i želja vezanih za ahiret. Da se liši lišavanja. I ostane u Jednosti. U toj osami insanu godi društvo. Godi mu društvo dragih ljudi, dobrih ljudi. Društvo dobrih, koji su postigli Jedinstvo u mnoštvu. Da se ogleda u njihovom primjeru, u predajama o tim dobrima. Da osjećaj nedostajanja dobrih nadomjesti sjećanjem na njih, kroz značenjski duboke i slojevite predaje o dobrima. Naravno, želim podvući kako ove predaje ne treba doživljavati doslovno, banalno, već kroz njihovu značenjsku slojevitost. Da bismo dobili nadahnuće, da bismo ih imali kao lučonoše svjetlosti Istine.\r\n\r\nKako u tezkirama – spomenicama dobrih budem nalazila predaje o ovim velikanima, o ovom dobrom društvu, ja ću neke od njih prepričati na bosanskom jeziku, i tako ih dovoditi u naše vrijeme i naš, bosanski jezik. E da nam ZNACI ostanu. I za prijatelja koji nam na dunjalučki nedostaje, a koji je, čini se, pripadao ovome društvu.",
                    DatumObjavljivanja = new DateTime(2024, 09, 12),
                    Likes = 2,
                    MektebId = 2,
                    Dislikes = 0
                },        
                new DodatneLekcije
                {
                    Id = 5,
                    Naziv = "U dobrom društvu",
                    Tekst = "Insanu godi osama. Da se liši dunjaluka, svega što ga vezuje za ovaj dunjaluk, da se liši jastva. Da se liši i ahireta. Razmišljanja i želja vezanih za ahiret. Da se liši lišavanja. I ostane u Jednosti. U toj osami insanu godi društvo. Godi mu društvo dragih ljudi, dobrih ljudi. Društvo dobrih, koji su postigli Jedinstvo u mnoštvu. Da se ogleda u njihovom primjeru, u predajama o tim dobrima. Da osjećaj nedostajanja dobrih nadomjesti sjećanjem na njih, kroz značenjski duboke i slojevite predaje o dobrima. Naravno, želim podvući kako ove predaje ne treba doživljavati doslovno, banalno, već kroz njihovu značenjsku slojevitost. Da bismo dobili nadahnuće, da bismo ih imali kao lučonoše svjetlosti Istine.\r\n\r\nKako u tezkirama – spomenicama dobrih budem nalazila predaje o ovim velikanima, o ovom dobrom društvu, ja ću neke od njih prepričati na bosanskom jeziku, i tako ih dovoditi u naše vrijeme i naš, bosanski jezik. E da nam ZNACI ostanu. I za prijatelja koji nam na dunjalučki nedostaje, a koji je, čini se, pripadao ovome društvu.",
                    DatumObjavljivanja = new DateTime(2024, 09, 12),
                    Likes = 2,
                    MektebId = 3,
                    Dislikes = 0
                },
                new DodatneLekcije
                {
                    Id = 6,
                    Naziv = "U dobrom društvu",
                    Tekst = "Insanu godi osama. Da se liši dunjaluka, svega što ga vezuje za ovaj dunjaluk, da se liši jastva. Da se liši i ahireta. Razmišljanja i želja vezanih za ahiret. Da se liši lišavanja. I ostane u Jednosti. U toj osami insanu godi društvo. Godi mu društvo dragih ljudi, dobrih ljudi. Društvo dobrih, koji su postigli Jedinstvo u mnoštvu. Da se ogleda u njihovom primjeru, u predajama o tim dobrima. Da osjećaj nedostajanja dobrih nadomjesti sjećanjem na njih, kroz značenjski duboke i slojevite predaje o dobrima. Naravno, želim podvući kako ove predaje ne treba doživljavati doslovno, banalno, već kroz njihovu značenjsku slojevitost. Da bismo dobili nadahnuće, da bismo ih imali kao lučonoše svjetlosti Istine.\r\n\r\nKako u tezkirama – spomenicama dobrih budem nalazila predaje o ovim velikanima, o ovom dobrom društvu, ja ću neke od njih prepričati na bosanskom jeziku, i tako ih dovoditi u naše vrijeme i naš, bosanski jezik. E da nam ZNACI ostanu. I za prijatelja koji nam na dunjalučki nedostaje, a koji je, čini se, pripadao ovome društvu.",
                    DatumObjavljivanja = new DateTime(2024, 09, 12),
                    Likes = 2,
                    MektebId = 4,
                    Dislikes = 0
                },        
                new DodatneLekcije
                {
                    Id = 7,
                    Naziv = "U dobrom društvu",
                    Tekst = "Insanu godi osama. Da se liši dunjaluka, svega što ga vezuje za ovaj dunjaluk, da se liši jastva. Da se liši i ahireta. Razmišljanja i želja vezanih za ahiret. Da se liši lišavanja. I ostane u Jednosti. U toj osami insanu godi društvo. Godi mu društvo dragih ljudi, dobrih ljudi. Društvo dobrih, koji su postigli Jedinstvo u mnoštvu. Da se ogleda u njihovom primjeru, u predajama o tim dobrima. Da osjećaj nedostajanja dobrih nadomjesti sjećanjem na njih, kroz značenjski duboke i slojevite predaje o dobrima. Naravno, želim podvući kako ove predaje ne treba doživljavati doslovno, banalno, već kroz njihovu značenjsku slojevitost. Da bismo dobili nadahnuće, da bismo ih imali kao lučonoše svjetlosti Istine.\r\n\r\nKako u tezkirama – spomenicama dobrih budem nalazila predaje o ovim velikanima, o ovom dobrom društvu, ja ću neke od njih prepričati na bosanskom jeziku, i tako ih dovoditi u naše vrijeme i naš, bosanski jezik. E da nam ZNACI ostanu. I za prijatelja koji nam na dunjalučki nedostaje, a koji je, čini se, pripadao ovome društvu.",
                    DatumObjavljivanja = new DateTime(2024, 09, 12),
                    Likes = 2,
                    MektebId = 5,
                    Dislikes = 0
                },
                new DodatneLekcije
                {
                    Id = 8,
                    Naziv = "U dobrom društvu",
                    Tekst = "Insanu godi osama. Da se liši dunjaluka, svega što ga vezuje za ovaj dunjaluk, da se liši jastva. Da se liši i ahireta. Razmišljanja i želja vezanih za ahiret. Da se liši lišavanja. I ostane u Jednosti. U toj osami insanu godi društvo. Godi mu društvo dragih ljudi, dobrih ljudi. Društvo dobrih, koji su postigli Jedinstvo u mnoštvu. Da se ogleda u njihovom primjeru, u predajama o tim dobrima. Da osjećaj nedostajanja dobrih nadomjesti sjećanjem na njih, kroz značenjski duboke i slojevite predaje o dobrima. Naravno, želim podvući kako ove predaje ne treba doživljavati doslovno, banalno, već kroz njihovu značenjsku slojevitost. Da bismo dobili nadahnuće, da bismo ih imali kao lučonoše svjetlosti Istine.\r\n\r\nKako u tezkirama – spomenicama dobrih budem nalazila predaje o ovim velikanima, o ovom dobrom društvu, ja ću neke od njih prepričati na bosanskom jeziku, i tako ih dovoditi u naše vrijeme i naš, bosanski jezik. E da nam ZNACI ostanu. I za prijatelja koji nam na dunjalučki nedostaje, a koji je, čini se, pripadao ovome društvu.",
                    DatumObjavljivanja = new DateTime(2024, 09, 12),
                    Likes = 2,
                    MektebId = 6,
                    Dislikes = 0
                }
            );
        }
    }
}
