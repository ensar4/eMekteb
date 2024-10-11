import 'package:emekteb_mobile/Widgets/master_screen.dart';
import 'package:emekteb_mobile/models/obavijest.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';


void main() {
  runApp(const ObavijestDetalji(
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
              style: const TextStyle(fontSize: 24),
            ),
            Text(
              DateFormat('d.M.yyyy').format( widget.obavijest!.datumObjave),
              style: const TextStyle(fontSize: 18),
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
      child: Text(
        widget.obavijest!.opis.toString(),
        style: const TextStyle(fontSize: 18,),
      ),
    );
  }


}
