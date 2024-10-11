import 'package:emekteb_mobile/Widgets/master_screen.dart';
import 'package:emekteb_mobile/providers/kamp_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/user_provider.dart';

class KampInsert extends StatefulWidget {
  const KampInsert({super.key});

  @override
  State<KampInsert> createState() => _KampInsertState();
}

class _KampInsertState extends State<KampInsert> {
  final _formKey = GlobalKey<FormState>();
  late UserProvider _UserProvider;
  late KampProvider _kampProvider;
  String naziv = '';
  String opis = '';
  DateTime datumPocetka = DateTime.now();
  DateTime datumZavrsetka = DateTime.now();
  final TextEditingController _datumPocetkaController = TextEditingController();
  final TextEditingController _datumZavrsetkaController = TextEditingController();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _kampProvider = context.read<KampProvider>();
    _UserProvider = context.read<UserProvider>();
    _datumPocetkaController.text = datumPocetka.toLocal().toString().split(' ')[0];
    _datumZavrsetkaController.text = datumZavrsetka.toLocal().toString().split(' ')[0];
  }

  @override
  Widget build(BuildContext context) {
    return MasterScreen(
      title: "Kamp",
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
          "Novi kamp",
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
            decoration: InputDecoration(labelText: 'Opis'),
            textCapitalization: TextCapitalization.sentences,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Unesite opis';
              }
              return null;
            },
            onSaved: (value) {
              opis = value!;
            },
          ),
          TextFormField(
            controller: _datumPocetkaController,
            decoration: const InputDecoration(labelText: 'Datum početka'),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Unesite datum početka';
              }
              return null;
            },
            onTap: () async {
              FocusScope.of(context).requestFocus(FocusNode());
              DateTime? picked = await showDatePicker(
                context: context,
                initialDate: datumPocetka,
                firstDate: DateTime(2000),
                lastDate: DateTime(2101),
              );
              if (picked != null && picked != datumPocetka) {
                setState(() {
                  datumPocetka = picked;
                  _datumPocetkaController.text = datumPocetka.toLocal().toString().split(' ')[0];
                });
              }
            },
          ),
          TextFormField(
            controller: _datumZavrsetkaController,
            decoration: const InputDecoration(labelText: 'Datum završetka'),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Unesite datum završetka';
              }
              return null;
            },
            onTap: () async {
              FocusScope.of(context).requestFocus(FocusNode());
              DateTime? picked = await showDatePicker(
                context: context,
                initialDate: datumZavrsetka,
                firstDate: DateTime(2000),
                lastDate: DateTime(2101),
              );
              if (picked != null && picked != datumZavrsetka) {
                setState(() {
                  datumZavrsetka = picked;
                  _datumZavrsetkaController.text = datumZavrsetka.toLocal().toString().split(' ')[0];
                });
              }
            },
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
          backgroundColor: Colors.cyan.shade400,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 36.0, vertical: 12.0),
        ),
        onPressed: () async {
          if (_formKey.currentState!.validate()) {
            _formKey.currentState!.save();
            bool result = await _kampProvider.insertKamp(opis, datumPocetka, datumZavrsetka, naziv, _UserProvider.user?.mektebId);
            if (result) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Kamp uspješno dodan')),
              );
              Navigator.of(context).pop(true); // Close the form after saving
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Greška pri dodavanju kampa')),
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
