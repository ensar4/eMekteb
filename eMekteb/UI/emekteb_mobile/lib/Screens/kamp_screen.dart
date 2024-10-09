// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:emekteb_mobile/Screens/kamp_details_screen.dart';
import 'package:emekteb_mobile/Screens/kamp_insert_screen.dart';
import 'package:emekteb_mobile/Widgets/master_screen.dart';
import 'package:emekteb_mobile/models/korisnik.dart';
import 'package:emekteb_mobile/providers/kamp_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/searches/search_result.dart';
import '../models/kamp.dart';
import '../providers/user_provider.dart';

void main() {
  runApp(const Kamps());
}

class Kamps extends StatefulWidget {
  const Kamps({super.key});

  @override
  State<Kamps> createState() => _ProfilInfoState();

}

class _ProfilInfoState extends State<Kamps> {
  late KampProvider _KampProvider;
  late UserProvider _UserProvider;

  int currentPage = 1;
  int numPages = 12;
  bool isLoading = false;
  int ukupnoKamp = 1;

  SearchResult<Kamp>? listaKamp;
  List<Kamp> filteredList = [];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _KampProvider = context.read<KampProvider>();
    _UserProvider = context.read<UserProvider>();
    if (_UserProvider.user == null) {
      _UserProvider.getKorisnik(Korisnik.id).then((_) {
        fetchData();
      });
    } else {
      fetchData();
    }
  }

  Future<void> fetchData({String? filter}) async {
    if (!isLoading) {
      setState(() {
        isLoading = true;
        // Clear existing data when the filter changes
        listaKamp = null;
        filteredList.clear();
      });

      var data = await _KampProvider.getById2(_UserProvider.user!.mektebId);

      setState(() {
        if (listaKamp == null) {
          listaKamp = data;
          ukupnoKamp = data.count;
        } else {
          listaKamp!.result.addAll(data.result);
        }
        filteredList = listaKamp?.result ?? [];
       // print(filteredList.isNotEmpty ? filteredList[0].naziv : 'No data');
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
            main(),
          ],
        ),
      ),
    );
  }

  Widget main() {
    return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 25.0),
                child: btnAdd(),
              ),
              listaKampova(),
            ],
          ),
        ],
      );
  }

  Widget listaKampova() {
    final screenWidth = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.only(top: 30.0),
      child: Container(
        width: screenWidth * 0.9, // 80% of the screen width
        height: 500,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
         //boxShadow: [
         //  BoxShadow(
         //    color: Colors.grey.withOpacity(0.5),
         //    spreadRadius: 5,
         //    blurRadius: 7,
         //    offset: Offset(0, 3),
         //  ),
         //],
        ),
        child: isLoading
            ? Center(child: CircularProgressIndicator())
            : ListView.builder(
          itemCount: filteredList.length,
          itemBuilder: (context, index) {
            var kamp = filteredList[index];
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 36.0, vertical: 12.0),
                ),
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => KampDetalji(kamp: kamp),
                    ),
                  );
                },
                child: Text(
                  kamp.naziv, // Assuming Kamp has a 'name' property
                  style: TextStyle(fontSize: 18, color: Colors.black),
                ),
              ),
            );
          },
        ),
      ),
    );
  }



  Widget btnAdd() {
    return Container(
      width: 180,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.cyan.shade400, // Set the button color to orange
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 36.0, vertical: 12.0),
        ),
        onPressed: () async {
          final result = await Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => KampInsert(),
            ),
          );
          if (result == true) {
            fetchData(); // Refresh data if a new kamp was added
          }
        },
        child: const Row(
          children: [
            Icon(
              Icons.add,
              color: Colors.white,
            ),
            SizedBox(width: 10),
            Text(
              "KAMP",
              style: TextStyle(fontSize: 18, color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }

  void _showCreateForm(BuildContext context, KampProvider provider) {
    final formKey = GlobalKey<FormState>();
    String lokacija = '';
    String vrijemePocetka = '';
    String info = '';
    DateTime datumOdrzavanja = DateTime.now();

    final TextEditingController datumOdrzavanjaController =
        TextEditingController();

    // Initializing the text fields with the current date values
    datumOdrzavanjaController.text =
        datumOdrzavanja.toLocal().toString().split(' ')[0];

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Novi kamp'),
          content: Form(
            key: formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Godina'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Unesite godinu takmičenja';
                    }
                    return null;
                  },
                  onSaved: (value) {
                  },
                ),
                TextFormField(
                  decoration:
                      const InputDecoration(labelText: 'Lokacija održavanja'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Unesite lokaciju održavanja';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    lokacija = value!;
                  },
                ),
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Vrijeme'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Unesite vrijeme početka';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    vrijemePocetka = value!;
                  },
                ),
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Dodatni info'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Unesite dodatne informacije';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    info = value!;
                  },
                ),
                TextFormField(
                  controller: datumOdrzavanjaController,
                  decoration: const InputDecoration(labelText: 'Datum'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Unesite datum takmičenja';
                    }
                    return null;
                  },
                  onTap: () async {
                    FocusScope.of(context).requestFocus(FocusNode());
                    DateTime? picked = await showDatePicker(
                      context: context,
                      initialDate: datumOdrzavanja,
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2101),
                    );
                    if (picked != null && picked != datumOdrzavanja) {
                      setState(() {
                        datumOdrzavanja = picked;
                        datumOdrzavanjaController.text =
                            datumOdrzavanja.toLocal().toString().split(' ')[0];
                      });
                    }
                  },
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              child: const Text('Odustani'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            ElevatedButton(
              child: const Text('Spremi'),
              onPressed: () async {
                //if (formKey.currentState!.validate()) {
                //  formKey.currentState!.save();
                //  bool result = await provider.createTakmicenje(naziv, datumOdrzavanja, lokacija, vrijemePocetka, info);
                //  if (result) {
                //    ScaffoldMessenger.of(context).showSnackBar(
                //      const SnackBar(content: Text('Takmičenje uspješno dodano')),
                //    );
                //    fetchData();
                //    Navigator.of(context).pop();
                //  } else {
                //    ScaffoldMessenger.of(context).showSnackBar(
                //      const SnackBar(content: Text('Greška pri dodavanju takmičenja')),
                //    );
                //  }
                //}
              },
            ),
          ],
        );
      },
    );
  }
}
