import 'package:emekteb_mobile/Widgets/master_screen.dart';
import 'package:emekteb_mobile/providers/dodatnalekcija_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/user_provider.dart';

class DodatnaLekcijaInsert extends StatefulWidget {
  const DodatnaLekcijaInsert({super.key});

  @override
  State<DodatnaLekcijaInsert> createState() => _DodatnaLekcijaInsertState();
}

class _DodatnaLekcijaInsertState extends State<DodatnaLekcijaInsert> {
  final _formKey = GlobalKey<FormState>();
  late UserProvider _UserProvider;
  late DodatnaLekcijaProvider _DodatnaLekcijaProvider;
  String naziv = '';
  String tekst = '';
  DateTime datumObjavljivanja = DateTime.now();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _DodatnaLekcijaProvider= context.read<DodatnaLekcijaProvider>();
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
          "Nova lekcija",
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }

  Widget divider() {
    return const SizedBox(
      width: 280, // Set the desired width here
      child: Divider(
        color: Colors.blue, // You can change the color to your preference
        thickness: 3, // Adjust the thickness as needed
      ),
    );
  }

  Widget formSection() {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            decoration: InputDecoration(labelText: 'Naziv'),
            textCapitalization: TextCapitalization.sentences,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Unesite naziv';
              }
              return null;
            },
            onSaved: (value) {
              naziv = value!;
            },
          ),
          TextFormField(
            decoration: InputDecoration(labelText: 'Tekst'),
            textCapitalization: TextCapitalization.sentences,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Unesite tekst';
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
            bool result = await _DodatnaLekcijaProvider.insertLekcija(tekst, datumObjavljivanja, naziv, _UserProvider.user?.mektebId);
            if (result) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Lekcija uspješno dodana')),
              );
              Navigator.of(context).pop(true); // Close the form after saving
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Greška pri dodavanju lekcije')),
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
