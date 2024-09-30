import 'package:emekteb_mobile/Widgets/master_screen.dart';
import 'package:emekteb_mobile/models/kamp_korisnik.dart';
import 'package:emekteb_mobile/models/user.dart';
import 'package:emekteb_mobile/providers/kampkorisnik_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/kamp.dart';
import '../models/searches/search_result.dart';
import '../providers/user_provider.dart';

void main() {
  runApp(KampDetalji(
    kamp: null,
  ));
}

class KampDetalji extends StatefulWidget {
  final Kamp? kamp;
  const KampDetalji({super.key, this.kamp});

  @override
  State<KampDetalji> createState() => _MektebDetaljiState();
}

class _MektebDetaljiState extends State<KampDetalji> {
  late KampKorisnikProvider _kampKorisnikProvider;
  late UserProvider _userProvider;

  int currentPage = 1;
  int numPages = 12;
  bool isLoading = false;
  int ukupno = 1;

  SearchResult<KampKorisnik>? listaKampKor;
  List<KampKorisnik> filteredList = [];
  Map<int?, User> korisniciMap = {};

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _kampKorisnikProvider = context.read<KampKorisnikProvider>();
    _userProvider = context.read<UserProvider>();
    fetchData();
  }

  Future<void> fetchData() async {
    if (!isLoading) {
      setState(() {
        isLoading = true;
        listaKampKor = null;
        filteredList.clear();
        korisniciMap.clear();
      });

      var data = await _kampKorisnikProvider.getById2(widget.kamp?.id);

      for (var kampKorisnik in data.result) {
        var korisnik = await _userProvider.getKorisnik(kampKorisnik.korisnikId);
        korisniciMap[kampKorisnik.korisnikId] = korisnik as User;
      }

      setState(() {
        if (listaKampKor == null) {
          listaKampKor = data;
          ukupno = data.count;
        } else {
          listaKampKor!.result.addAll(data.result);
        }
        filteredList = listaKampKor?.result ?? [];
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MasterScreen(
      title: "Kamp",
      child: SingleChildScrollView(
        child: Column(
          children: [
            naziv(),
            divider(),
            listaKorisnikaSection(),
          ],
        ),
      ),
    );
  }

  Widget naziv() {
    return Padding(
      padding: const EdgeInsets.only(top: 25.0, bottom: 20.0),
      child: Center(
        child: Text(
          this.widget.kamp!.naziv.toString(),
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }

  Widget divider() {
    return SizedBox(
      width: 280,
      child: Divider(
        color: Colors.cyan.shade400,
        thickness: 3,
      ),
    );
  }

  Widget listaKorisnikaSection() {
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: filteredList.length,
      itemBuilder: (context, index) {
        final kampKorisnik = filteredList[index];
        final korisnik = korisniciMap[kampKorisnik.korisnikId];
        return Card(
          child: ListTile(
            title: Text(korisnik != null ? korisnik.ime : 'Loading...' ),
            subtitle: Text(korisnik != null ? korisnik.prezime : ''),
            trailing: IconButton(
              icon: Icon(Icons.more_vert),
              onPressed: () {
                if (korisnik != null) {
                  showKorisnikDetailsDialog(context, korisnik);
                }
              },
            ),
          ),
        );
      },
    );
  }

  void showKorisnikDetailsDialog(BuildContext context, User korisnik) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("${korisnik.ime} ${korisnik.prezime}"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                leading: Icon(Icons.phone),
                title: Text(korisnik.telefon ?? "N/A"),
              ),
              ListTile(
                leading: Icon(Icons.email),
                title: Text(korisnik.mail ?? "N/A"),
              ),
              ListTile(
                leading: Icon(Icons.person),
                title: Text(korisnik.spol ?? "N/A"),
              ),
              ListTile(
                leading: Icon(Icons.cake),
                title: Text(korisnik.datumRodjenja != null ? korisnik.datumRodjenja!.toLocal().toString().split(' ')[0] : "N/A"),
              ),
              ListTile(
                leading: Icon(Icons.family_restroom),
                title: Text(korisnik.imeRoditelja ?? "N/A"),
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: Text("Close"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
