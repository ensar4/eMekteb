// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:emekteb_mobile/Screens/kamp_details_screen.dart';
import 'package:emekteb_mobile/Screens/kamp_edit_screen.dart';
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
  late KampProvider _kampProvider;
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
    _kampProvider = context.read<KampProvider>();
    _UserProvider = context.read<UserProvider>();
    fetchData();
  }

  Future<void> fetchData({String? filter}) async {
    if (!isLoading) {
      setState(() {
        isLoading = true;
        listaKamp = null;
        filteredList.clear();
      });

      var data = await _kampProvider.getById2(_UserProvider.user!.mektebId);

      setState(() {
        if (listaKamp == null) {
          listaKamp = data;
          ukupnoKamp = data.count;
        } else {
          listaKamp!.result.addAll(data.result);
        }
        filteredList = listaKamp?.result ?? [];
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
        ),
        child: isLoading
            ? const Center(child: CircularProgressIndicator())
            : ListView.builder(
          itemCount: filteredList.length,
          itemBuilder: (context, index) {
            var kamp = filteredList[index];
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => KampDetalji(kamp: kamp),
                    ),
                  );
                },
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  elevation: 4,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 36.0, vertical: 20.0),
                        child: Text(
                          kamp.naziv, // Assuming Kamp has a 'naziv' property
                          style: const TextStyle(fontSize: 18, color: Colors.black),
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.edit),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  KampEdit(kamp: kamp),
                            ),
                          );
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.delete,
                            color: Colors.black),
                        onPressed: () async {
                          bool confirmed = await showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text('Potvrda brisanja'),
                                content: Text(
                                    'Da li ste sigurni da želite izbrisati kamp?'),
                                actions: [
                                  TextButton(
                                    child: Text('Odustani'),
                                    onPressed: () {
                                      Navigator.of(context).pop(
                                          false); // Return false if "No" is pressed
                                    },
                                  ),
                                  TextButton(
                                    child: Text('DA', style: TextStyle(color: Colors.red)),
                                    onPressed: () {
                                      Navigator.of(context).pop(
                                          true); // Return true if "Yes" is pressed
                                    },
                                  ),
                                ],
                              );
                            },
                          );
                          if (confirmed == true) {
                            bool success =
                            await _kampProvider
                                .delete(kamp.id);
                            if (success) {
                              // Remove the item from the list
                              setState(() {
                                filteredList.removeAt(index);
                              });
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(
                                SnackBar(
                                  content: Text(
                                      'Uspješno izbrisano.'),
                                ),
                              );
                            } else {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(
                                SnackBar(
                                  content: Text(
                                      'Greška pri brisanju.'),
                                ),
                              );
                            }
                          }
                        },
                      ),
                    ],
                  ),
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
          backgroundColor: Colors.cyan.shade400,
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
            fetchData();
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
}
