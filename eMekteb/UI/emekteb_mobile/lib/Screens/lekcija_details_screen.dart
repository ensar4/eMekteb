import 'package:emekteb_mobile/Screens/kamp_screen.dart';
import 'package:emekteb_mobile/Widgets/master_screen.dart';
import 'package:emekteb_mobile/models/dodatna_lekcija.dart';
import 'package:emekteb_mobile/models/kamp_korisnik.dart';
import 'package:emekteb_mobile/models/korisnik.dart';
import 'package:emekteb_mobile/models/user.dart';
import 'package:emekteb_mobile/providers/kampkorisnik_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/kamp.dart';
import '../models/searches/search_result.dart';
import '../providers/user_provider.dart';

void main() {
  runApp(LekcijaDetalji(
    lekcija: null,
  ));
}

class LekcijaDetalji extends StatefulWidget {
  final DodatnaLekcija? lekcija;
  const LekcijaDetalji({super.key, this.lekcija});

  @override
  State<LekcijaDetalji> createState() => _LekcijaDetaljiState();
}

class _LekcijaDetaljiState extends State<LekcijaDetalji> {

  late UserProvider _userProvider;

  int currentPage = 1;
  int numPages = 12;
  bool isLoading = false;
  int ukupno = 1;

  SearchResult<DodatnaLekcija>? lista;
  List<DodatnaLekcija> filteredList = [];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _userProvider = context.read<UserProvider>();
   // fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return MasterScreen(
      title: "Dodatna lekcija",
      child: SingleChildScrollView(
        child: Column(
          children: [
            naziv(),
            divider(),
            showText()
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
          widget.lekcija!.naziv.toString(),
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }

  Widget divider() {
    return const SizedBox(
      width: 280,
      child: Divider(
        color: Colors.blue,
        thickness: 3,
      ),
    );
  }

  Widget showText(){
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Container(
        child:
        Text(
          widget.lekcija!.tekst.toString(),
          style: TextStyle(fontSize: 18,),
        ),
      ),
    );
  }


}