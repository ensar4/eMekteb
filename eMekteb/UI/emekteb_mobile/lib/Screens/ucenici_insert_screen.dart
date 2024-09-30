import 'package:emekteb_mobile/Widgets/master_screen.dart';
import 'package:emekteb_mobile/models/mekteb.dart';
import 'package:emekteb_mobile/models/razred.dart';
import 'package:emekteb_mobile/providers/razred_provider.dart';
import 'package:emekteb_mobile/providers/ucenici_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/searches/search_result.dart';
import '../models/ucenik.dart';
import '../providers/mekteb_provider.dart';
import '../providers/user_provider.dart';

class UceniciInsert extends StatefulWidget {
  const UceniciInsert({super.key});

  @override
  State<UceniciInsert> createState() => _InsertUceniciState();
}

class _InsertUceniciState extends State<UceniciInsert> {
  final _formKey = GlobalKey<FormState>();
  late UserProvider _UserProvider;
  late UceniciProvider _uceniciProvider;
  late RazredProvider _nivoProvider;

  TextEditingController _imeController = TextEditingController();
  TextEditingController _prezimeController = TextEditingController();
  TextEditingController _imeRoditeljaController = TextEditingController();
  TextEditingController _korisnickoImeController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _passwordPotvrdaController = TextEditingController();
  TextEditingController _brojTelefonaController = TextEditingController();
  TextEditingController _datumRodjenjaController = TextEditingController();
  TextEditingController _mailController = TextEditingController();

  String? selectedSpol;
  String? nivo;

  bool isLoading2 = false;
  int ukupno2 = 1;
  List<dynamic> filteredListNivo = [];
  dynamic listaNivo;



  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _UserProvider = context.read<UserProvider>();
    _uceniciProvider = context.read<UceniciProvider>();
    _nivoProvider = context.read<RazredProvider>();
    fetchDataKategorije();
  }

  Future<void> fetchDataKategorije() async {
    if (!isLoading2) {
      setState(() {
        isLoading2 = true;
        // Clear existing data when the filter changes
        listaNivo = null;
        filteredListNivo.clear();
      });

      var data = await _nivoProvider.get(page: 1, pageSize: 100);

      setState(() {
        if (listaNivo == null) {
          listaNivo = data;
          ukupno2 = data.count;
        } else {
          listaNivo!.result.addAll(data.result);
        }
        filteredListNivo = listaNivo?.result ?? [];
        // print(filteredList.isNotEmpty ? filteredList[0].naziv : 'No data');
        isLoading2 = false;  // Corrected from isLoading to isLoading2
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MasterScreen(
      title: "Upis",
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
      padding: const EdgeInsets.only(top: 12.0, bottom: 10.0),
      child: Center(
        child: Text(
          "Novi učenik",
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }

  Widget divider() {
    return const SizedBox(
      width: 280,
      child: Divider(
        color: Colors.lightGreen,
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
            controller: _imeController,
            decoration: InputDecoration(labelText: 'Ime:'),
            textCapitalization: TextCapitalization.sentences,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Unesite ime';
              }
              return null;
            }, onChanged: (value) => _updateKorisnickoIme()

          ),
          TextFormField(
            controller: _prezimeController,
            decoration: InputDecoration(labelText: 'Prezime:'),
            textCapitalization: TextCapitalization.sentences,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Unesite prezime';
              }
              return null;
            },
              onChanged: (value) => _updateKorisnickoIme()
          ),
          TextFormField(
            controller: _imeRoditeljaController,
            decoration: InputDecoration(labelText: 'Ime roditelja:'),
            textCapitalization: TextCapitalization.sentences,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Unesite ime roditelja';
              }
              return null;
            },
          ),
          TextFormField(
            enabled: false,
            //controller: _korisnickoImeController,
            decoration: InputDecoration(labelText: 'Korisničko ime (automatski)'),
            textCapitalization: TextCapitalization.sentences,
          //validator: (value) {
          //  if (value == null || value.isEmpty) {
          //    return 'Unesite korisničko ime';
          //  }
          //  return null;
          //},
          ),
          DropdownButtonFormField<String>(
            decoration: InputDecoration(labelText: 'Spol'),
            value: selectedSpol,
            items: ['M', 'Ž'].map((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
            onChanged: (newValue) {
              setState(() {
                selectedSpol = newValue;
              });
            },
          ),
          TextFormField(
            controller: _datumRodjenjaController,
            decoration: const InputDecoration(labelText: 'Datum rođenja:'),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Unesite datum rođenja';
              }
              return null;
            },
            onTap: () async {
              FocusScope.of(context).requestFocus(FocusNode());
              DateTime? picked = await showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime(1900),
                lastDate: DateTime(2100),
              );
              if (picked != null) {
                setState(() {
                  _datumRodjenjaController.text = picked.toLocal().toString().split(' ')[0];
                });
              }
            },
          ),
          TextFormField(
            controller: _passwordController,
            decoration: InputDecoration(labelText: 'Password:'),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Unesite password';
              }
              return null;
            },
          ),
          TextFormField(
            controller: _passwordPotvrdaController,
            decoration: InputDecoration(labelText: 'Password potvrda:'),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Unesite potvrdu passworda';
              }
              if (value != _passwordController.text) {
                return 'Passwordi se ne poklapaju';
              }
              return null;
            },
          ),
          TextFormField(
            controller: _brojTelefonaController,
            decoration: InputDecoration(labelText: 'Broj telefona:'),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Unesite broj telefona';
              }
              return null;
            },
          ),
          TextFormField(
            controller: _mailController,
            decoration: InputDecoration(labelText: 'Mail:'),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Unesite mail';
              }
              return null;
            },
          ),
          DropdownButtonFormField<String>(
            decoration: InputDecoration(
              labelText: 'Kategorija',
              border: InputBorder.none,
            ),
            hint: Text("Kategorija"),
            value: nivo, // Correctly set the current value
            onChanged: (newValue) {
              setState(() {
                nivo = newValue; // Properly update the state with the new value
              });
            },
            items: filteredListNivo.map<DropdownMenuItem<String>>((nivoItem) {
              return DropdownMenuItem<String>(
                value: nivoItem.id.toString(),
                child: Text(nivoItem.naziv),
              );
            }).toList(),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Odaberite kategoriju';
              }
              return null;
            },
          ),
        ],
      ),
    );
  }
  void _updateKorisnickoIme() {
    setState(() {
      String ime = _imeController.text.trim().toLowerCase();
      String prezime = _prezimeController.text.trim().toLowerCase();
      if (ime.isNotEmpty && prezime.isNotEmpty) {
        _korisnickoImeController.text = "$ime.$prezime"; // Combine 'ime' and 'prezime'
      } else {
        _korisnickoImeController.text = ""; // Clear if either field is empty
      }
    });
  }
  Widget saveButton() {
    return Padding(
      padding: const EdgeInsets.only(top: 20.0),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.lightGreen,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 36.0, vertical: 12.0),
        ),
        onPressed: () async {
          if (_formKey.currentState!.validate()) {
            // Retrieve values from the form
            String ime = _imeController.text;
            String prezime = _prezimeController.text;
            String imeRoditelja = _imeRoditeljaController.text;
            String korisnickoIme = _korisnickoImeController.text;
            String telefon = _brojTelefonaController.text;
            DateTime datumRodjenja = DateTime.parse(_datumRodjenjaController.text);
            int nivoId = int.parse(nivo!);
            String password = _passwordController.text;
            String passwordPotvrda = _passwordPotvrdaController.text;
            String username = _korisnickoImeController.text;
            String mail = _mailController.text;
            String? spol = selectedSpol;
            String status = "aktivan";

            if (spol == null) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Please select a gender')),
              );
              return;
            }

            bool result = await _uceniciProvider.insertOboje(
              ime,
              prezime,
              username,
              telefon,
              mail,
              spol,
              status,
              datumRodjenja,
              imeRoditelja,
              password,
              passwordPotvrda,
              _UserProvider.user?.mektebId,
              nivoId,
            );

            if (result) {
              // Show success message
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Učenik uspješno dodan')),
              );

              // Clear the form fields
              _imeController.clear();
              _prezimeController.clear();
              _imeRoditeljaController.clear();
              _korisnickoImeController.clear();
              _brojTelefonaController.clear();
              _datumRodjenjaController.clear();
              _passwordController.clear();
              _passwordPotvrdaController.clear();
              _mailController.clear();
              setState(() {
                selectedSpol = null;
                nivo = null;
              });
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Greška pri dodavanju učenika')),
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
