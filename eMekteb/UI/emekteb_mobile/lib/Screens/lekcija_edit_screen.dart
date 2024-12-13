import 'package:emekteb_mobile/Widgets/master_screen.dart';
import 'package:emekteb_mobile/providers/dodatnalekcija_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/dodatna_lekcija.dart';
import '../providers/user_provider.dart';
import 'lekcija_screen.dart';

void main() {
  runApp(const DodatnaLekcijaEdit(
    lekcija: null,
  ));
}

class DodatnaLekcijaEdit extends StatefulWidget {
  final DodatnaLekcija? lekcija;

  const DodatnaLekcijaEdit({super.key, this.lekcija});

  @override
  State<DodatnaLekcijaEdit> createState() => _DodatnaLekcijaEditState();
}

class _DodatnaLekcijaEditState extends State<DodatnaLekcijaEdit> {
  final _formKey = GlobalKey<FormState>();
  late UserProvider _UserProvider;
  late DodatnaLekcijaProvider _DodatnaLekcijaProvider;
  late String naziv;
  late String tekst;
  late int id;
  late int likes;
  late int dislikes;
  late DateTime datumObjavljivanja;

  @override
  void initState() {
    super.initState();
    id = widget.lekcija?.id ?? 1;
    naziv = widget.lekcija?.naziv ?? '';
    tekst = widget.lekcija?.tekst ?? '';
    likes = widget.lekcija?.likes ?? 0;
    dislikes = widget.lekcija?.dislikes ?? 0;
    datumObjavljivanja = widget.lekcija?.datumObjavljivanja ?? DateTime.now();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _DodatnaLekcijaProvider = context.read<DodatnaLekcijaProvider>();
    _UserProvider = context.read<UserProvider>();
  }

  @override
  Widget build(BuildContext context) {
    return MasterScreen(
      title: "Lekcije - admin",
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            nazivSection(),
            divider(),
            formSection(),
            saveButton(),
          ],
        ),
      ),
    );
  }

  Widget nazivSection() {
    return Padding(
      padding: const EdgeInsets.only(top: 25.0, bottom: 20.0),
      child: Center(
        child: Text(
          "Uredi lekciju",
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

  Widget formSection() {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            initialValue: naziv, // Pre-fill with initial value
            decoration: InputDecoration(labelText: 'Naziv'),
            textCapitalization: TextCapitalization.sentences,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Naziv je obavezan!';
              }
              return null;
            },
            onSaved: (value) {
              naziv = value!;
            },
          ),
          SizedBox(height: 10,),
          TextFormField(
            initialValue: tekst, // Pre-fill with initial value
            decoration: InputDecoration(labelText: 'Tekst'),
            textCapitalization: TextCapitalization.sentences,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Unesite tekst!';
              }
              return null;
            },
            onSaved: (value) {
              tekst = value!;
            },
            minLines: 1,
            maxLines: null,
          ),
        ],
      ),
    );
  }

  Widget saveButton() {
    return Padding(
      padding: const EdgeInsets.only(top: 20.0),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.blue,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 36.0, vertical: 12.0),
        ),
        onPressed: () async {
          if (_formKey.currentState!.validate()) {
            _formKey.currentState!.save();
            bool result = await _DodatnaLekcijaProvider.update(id, naziv, tekst, datumObjavljivanja,likes , dislikes, _UserProvider.user?.mektebId);
            if (result) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Lekcija uspješno uređena!')),
              );
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const Lekcija(),
                ),
              );
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Greška pri spašavanju promjena!')),
              );
            }
          }
        },
        child: Text(
          'SPASI',
          style: TextStyle(fontSize: 18, color: Colors.white),
        ),
      ),
    );
  }
}
