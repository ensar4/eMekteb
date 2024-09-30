import 'package:emekteb_mobile/Screens/kamp_screen.dart';
import 'package:emekteb_mobile/Widgets/master_screen.dart';
import 'package:emekteb_mobile/models/dodatna_lekcija.dart';
import 'package:emekteb_mobile/models/kamp_korisnik.dart';
import 'package:emekteb_mobile/models/korisnik.dart';
import 'package:emekteb_mobile/models/obavijest.dart';
import 'package:emekteb_mobile/models/user.dart';
import 'package:emekteb_mobile/providers/kampkorisnik_provider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../models/kamp.dart';
import '../models/searches/search_result.dart';
import '../providers/user_provider.dart';

void main() {
  runApp(ObavijestDetalji(
    obavijest: null,
  ));
}

class ObavijestDetalji extends StatefulWidget {
  final Obavijest? obavijest;
  const ObavijestDetalji({super.key, this.obavijest});

  @override
  State<ObavijestDetalji> createState() => _ObavijestDetaljiState();
}

class _ObavijestDetaljiState extends State<ObavijestDetalji> {

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
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
        child: Column(
          children: [
            Text(
              widget.obavijest!.naslov.toString(),
              style: TextStyle(fontSize: 24),
            ),
            Text(
              "${DateFormat('d.M.yyyy').format( widget.obavijest!.datumObjave)}",
              style: TextStyle(fontSize: 18),
            ),
          ],
        ),

      ),
    );
  }

  Widget divider() {
    return SizedBox(
      width: 280,
      child: Divider(
        color: Colors.yellow.shade600,
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
          widget.obavijest!.opis.toString(),
          style: TextStyle(fontSize: 18,),
        ),
      ),
    );
  }


}
