import 'package:emekteb_mobile/Widgets/master_screen.dart';
import 'package:emekteb_mobile/providers/dodatnalekcija_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/obavijest_provider.dart';
import '../providers/user_provider.dart';

class ObavijestInsert extends StatefulWidget {
  const ObavijestInsert({super.key});

  @override
  State<ObavijestInsert> createState() => _ObavijestInsertState();
}

class _ObavijestInsertState extends State<ObavijestInsert> {
  final _formKey = GlobalKey<FormState>();
  late UserProvider _UserProvider;
  late ObavijestProvider _obavijestProvider;
  String naslov = '';
  String opis = '';
  DateTime datumObjave = DateTime.now();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _obavijestProvider= context.read<ObavijestProvider>();
    _UserProvider = context.read<UserProvider>();
  }

  @override
  Widget build(BuildContext context) {
    return MasterScreen(
      title: "Obavijest - admin",
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
          "Nova obavijest",
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }

  Widget divider() {
    return SizedBox(
      width: 280, // Set the desired width here
      child: Divider(
        color: Colors.yellow.shade600, // You can change the color to your preference
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
            decoration: InputDecoration(labelText: 'Naslov'),
            textCapitalization: TextCapitalization.sentences,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Unesite naslov';
              }
              return null;
            },
            onSaved: (value) {
              naslov = value!;
            },
          ),
          TextFormField(
            decoration: InputDecoration(labelText: 'Opis'),
            textCapitalization: TextCapitalization.sentences,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Unesite Opis';
              }
              return null;
            },
            onSaved: (value) {
              opis = value!;
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
          backgroundColor: Colors.yellow.shade800,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 36.0, vertical: 12.0),
        ),
        onPressed: () async {
          if (_formKey.currentState!.validate()) {
            _formKey.currentState!.save();
            bool result = await _obavijestProvider.insert(naslov, opis, datumObjave, _UserProvider.user!.mektebId);
            if (result) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Obavijest uspješno dodana.')),
              );
              Navigator.of(context).pop(true); // Close the form after saving
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Greška pri dodavanju.')),
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
