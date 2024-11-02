// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:emekteb_mobile/Screens/obavijest_details_screen.dart';
import 'package:emekteb_mobile/Screens/obavijest_edit_screen.dart';
import 'package:emekteb_mobile/Screens/obavijest_insert_screen.dart';
import 'package:emekteb_mobile/Widgets/master_screen.dart';
import 'package:emekteb_mobile/models/korisnik.dart';
import 'package:emekteb_mobile/providers/obavijest_provider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../models/obavijest.dart';
import '../models/searches/search_result.dart';
import '../providers/user_provider.dart';

void main() {
  runApp(const ObavijestiScreen());
}

class ObavijestiScreen extends StatefulWidget {
  const ObavijestiScreen({super.key});

  @override
  State<ObavijestiScreen> createState() => _ObavijestiScreenState();
}

class _ObavijestiScreenState extends State<ObavijestiScreen> {
  late ObavijestProvider _obavijestProviderProvider;
  late UserProvider _userProvider;

  int currentPage = 1;
  int numPages = 12;
  bool isLoading = false;
  int ukupno = 1;
  TextEditingController searchController = TextEditingController();
  SearchResult<Obavijest>? listaObavijesti;
  List<Obavijest> filteredList = [];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _obavijestProviderProvider = context.read<ObavijestProvider>();
    _userProvider = context.read<UserProvider>();
    fetchData();
  }

  Future<void> fetchData({String? filter}) async {
    if (!isLoading) {
      setState(() {
        isLoading = true;
        listaObavijesti = null;
        filteredList.clear();
      });

      var data = await _obavijestProviderProvider
          .getById2(_userProvider.user!.mektebId);

      setState(() {
        if (listaObavijesti == null) {
          listaObavijesti = data;
          ukupno = data.count;
        } else {
          listaObavijesti!.result.addAll(data.result);
        }
        filteredList = listaObavijesti?.result ?? [];
        isLoading = false;
      });
    }
  }

  String _getFirstThreeWords(String text) {
    List<String> words = text.split(' ');
    if (words.length <= 3) {
      return text;
    }
    return '${words.take(3).join(' ')}...';
  }

  void searchByName(String query) {
    setState(() {
      if (query.isEmpty) {
        filteredList = listaObavijesti?.result ?? [];
      } else {
        filteredList = listaObavijesti?.result
                .where((ob) =>
                    (ob.naslov.toLowerCase().contains(query.toLowerCase())) ||
                    (ob.opis.toLowerCase().contains(query.toLowerCase())))
                .toList() ??
            [];
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MasterScreen(
      title: "Obavijesti",
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
    String userRole = getCurrentUserRole();
    bool isUcenik = userRole == "Ucenik";
    bool isRoditelj = userRole == "Roditelj";
    bool isImam = userRole == "Imam";
    return Center(
      // Ensures the content is centered
      child: SingleChildScrollView(
        // Allows scrolling if needed
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 25.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildSearchField(),
                  SizedBox(
                    width: 20,
                  ),
                  if (!isUcenik && !isRoditelj) btnAdd(),
                ],
              ),
            ),
            if (!isImam) listaForUcenici(),
            if (!isUcenik && !isRoditelj) lista(),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchField() {
    return Container(
      width: 140,
      height: 45,
      child: TextField(
        controller: searchController,
        onChanged: searchByName,
        style: const TextStyle(fontSize: 14),
        decoration: InputDecoration(
          hintText: "...",
          isDense: true,
          contentPadding:
              const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          prefixIcon: const Icon(Icons.search, size: 20),
        ),
      ),
    );
  }

  Widget lista() {
    String userRole = getCurrentUserRole();
    bool isUcenik = userRole == "Ucenik";
    bool isRoditelj = userRole == "Roditelj";
    final screenWidth = MediaQuery.of(context).size.width;

    return Padding(
      padding: const EdgeInsets.only(top: 20.0),
      child: Container(
        width: screenWidth * 0.9,
        height: 550,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
        ),
        child: ListView.builder(
          itemCount: filteredList.length,
          itemBuilder: (context, index) {
            var obavijest = filteredList[index];
            return Padding(
              padding: const EdgeInsets.all(10.0),
              child: InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          ObavijestDetalji(obavijest: obavijest),
                    ),
                  );
                },
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  color: Colors.white,
                  elevation: 3,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              obavijest.naslov,
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                            IconButton(
                              icon: const Icon(Icons.edit),
                              onPressed: () {
                                if (obavijest.stateMachine == "active") {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content: Text(
                                            'Nije moguće editovati aktivnu obavijest!')),
                                  );
                                } else {
                                  // Navigate to the edit page if not active
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          ObavijestEdit(obavijest: obavijest),
                                    ),
                                  );
                                }
                              },
                            ),
                          ],
                        ),
                        Text(
                          "${DateFormat('d.M.yyyy').format(obavijest.datumObjave)}",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                        Divider(
                          color: Colors.yellow.shade600,
                          thickness: 2,
                        ),
                        Row(
                          children: [
                            Text(
                              _getFirstThreeWords(obavijest.opis),
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                            Spacer(),
                            if (!isUcenik && !isRoditelj) ...[
                              // Button to activate/hide obavijest based on stateMachine
                              ElevatedButton(
                                onPressed: () async {
                                  if (obavijest.stateMachine == "draft") {
                                    // Activate obavijest
                                    bool success =
                                        await _obavijestProviderProvider
                                            .activateObavijest(obavijest.id);
                                    if (success) {
                                      setState(() {
                                        obavijest.stateMachine = "active";
                                      });
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                          content:
                                              Text('Obavijest aktivirana.'),
                                        ),
                                      );
                                    } else {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                          content: Text(
                                              'Greška pri aktiviranju obavijesti.'),
                                        ),
                                      );
                                    }
                                  } else if (obavijest.stateMachine ==
                                      "active") {
                                    // Hide obavijest
                                    bool success =
                                        await _obavijestProviderProvider
                                            .hideObavijest(obavijest.id);
                                    if (success) {
                                      setState(() {
                                        obavijest.stateMachine = "draft";
                                      });
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                          content: Text('Obavijest skrivena.'),
                                        ),
                                      );
                                    } else {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                          content: Text(
                                              'Greška pri skrivanju obavijesti.'),
                                        ),
                                      );
                                    }
                                  }
                                },
                                child: Text(obavijest.stateMachine == "draft"
                                    ? "Aktiviraj"
                                    : "Sakrij"),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                      obavijest.stateMachine == "draft"
                                          ? Colors.green
                                          : Colors.red,
                                ),
                              ),
                              IconButton(
                                icon: Icon(Icons.delete, color: Colors.black),
                                onPressed: () async {
                                  bool confirmed = await showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: Text('Potvrda brisanja'),
                                        content: Text(
                                            'Da li ste sigurni da želite izbrisati obavijest?'),
                                        actions: [
                                          TextButton(
                                            child: Text('Odustani'),
                                            onPressed: () {
                                              Navigator.of(context).pop(
                                                  false); // Return false if "No" is pressed
                                            },
                                          ),
                                          TextButton(
                                            child: Text('DA',
                                                style: TextStyle(
                                                    color: Colors.red)),
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
                                        await _obavijestProviderProvider
                                            .delete(obavijest.id);
                                    if (success) {
                                      // Remove the item from the list
                                      setState(() {
                                        filteredList.removeAt(index);
                                      });
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                          content: Text('Uspješno izbrisano.'),
                                        ),
                                      );
                                    } else {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                          content: Text('Greška pri brisanju.'),
                                        ),
                                      );
                                    }
                                  }
                                },
                              ),
                            ],
                          ],
                        ),
                      ],
                    ),
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
      width: 150,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.yellow.shade800,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14.0),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 10.0),
        ),
        onPressed: () async {
          final result = await Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => ObavijestInsert(),
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
              "NOVA",
              style: TextStyle(fontSize: 18, color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }

  String getCurrentUserRole() {
    if (Korisnik.uloge.contains("Imam")) {
      print(Korisnik.uloge.toString());
      return "Imam";
    } else if (Korisnik.uloge.contains("Ucenik")) {
      return "Ucenik";
    } else {
      return "Roditelj";
    }
  }

  Widget listaForUcenici() {
    final screenWidth = MediaQuery.of(context).size.width;
    var activeObavijesti = filteredList
        .where((obavijest) => obavijest.stateMachine == "active")
        .toList();

    return Padding(
      padding: const EdgeInsets.only(top: 20.0),
      child: Container(
        width: screenWidth * 0.9, // 80% of the screen width
        height: 500,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
        ),
        child: ListView.builder(
          itemCount: activeObavijesti.length,
          itemBuilder: (context, index) {
            var obavijest = activeObavijesti[index];
            return Padding(
              padding: const EdgeInsets.all(10.0),
              child: InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          ObavijestDetalji(obavijest: obavijest),
                    ),
                  );
                },
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  color: Colors.white,
                  elevation: 3,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              obavijest.naslov,
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ],
                        ),
                        Text(
                          "${DateFormat('d.M.yyyy').format(obavijest.datumObjave)}",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                        Divider(
                          color: Colors.yellow.shade600,
                          thickness: 2,
                        ),
                        Row(
                          children: [
                            Text(
                              _getFirstThreeWords(obavijest.opis),
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
