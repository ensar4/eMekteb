// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:emekteb_mobile/Screens/lekcija_details_screen.dart';
import 'package:emekteb_mobile/Screens/lekcija_insert_screen.dart';
import 'package:emekteb_mobile/Widgets/master_screen.dart';
import 'package:emekteb_mobile/models/dodatna_lekcija.dart';
import 'package:emekteb_mobile/models/korisnik.dart';
import 'package:emekteb_mobile/providers/dodatnalekcija_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/searches/search_result.dart';
import '../providers/user_provider.dart';

void main() {
  runApp(const Lekcija());
}

class Lekcija extends StatefulWidget {
  const Lekcija({super.key});

  @override
  State<Lekcija> createState() => _ProfilInfoState();
}

class _ProfilInfoState extends State<Lekcija> {
  late DodatnaLekcijaProvider _dodatnaLekcijaProvider;
  late UserProvider _userProvider;

  int currentPage = 1;
  int numPages = 12;
  bool isLoading = false;
  int ukupno = 1;

  SearchResult<DodatnaLekcija>? listaLekcija;
  List<DodatnaLekcija> filteredList = [];

  List<int> omiljenaLekcijaIds = [];
  bool showFavoritesOnly = false;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _dodatnaLekcijaProvider = context.read<DodatnaLekcijaProvider>();
    _userProvider = context.read<UserProvider>();
    if (_userProvider.user == null) {
      _userProvider.getKorisnik(Korisnik.id).then((_) {
        fetchData();
      });
    } else {
      fetchData();
    }
    loadFavorites();
  }

  Future<void> loadFavorites() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? savedFavorites = prefs.getStringList('favoriteLekcijaIds');
    if (savedFavorites != null) {
      setState(() {
        omiljenaLekcijaIds = savedFavorites.map((id) => int.parse(id)).toList();
      });
    }
  }

  Future<void> toggleFavorite(int? lekcijaId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      if (omiljenaLekcijaIds.contains(lekcijaId)) {
        omiljenaLekcijaIds.remove(lekcijaId);
      } else {
        omiljenaLekcijaIds.add(lekcijaId!);
      }
    });
    prefs.setStringList('favoriteLekcijaIds',
        omiljenaLekcijaIds.map((id) => id.toString()).toList());
  }

  Future<void> fetchData({String? filter}) async {
    if (!isLoading) {
      setState(() {
        isLoading = true;
        listaLekcija = null;
        filteredList.clear();
      });

      var data =
          await _dodatnaLekcijaProvider.getById2(_userProvider.user!.mektebId);

      setState(() {
        if (listaLekcija == null) {
          listaLekcija = data;
          ukupno = data.count;
        } else {
          listaLekcija!.result.addAll(data.result);
        }
        filteredList = listaLekcija?.result ?? [];
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MasterScreen(
      title: "Dodatne lekcije",
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
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Column(
          children: [
            if (!isUcenik)
              Padding(
                padding: const EdgeInsets.only(top: 25.0),
                child: btnAdd(),
              ),
            omiljene(),
            lista(),
          ],
        ),
      ],
    );
  }

  Set<int?> ratedItems = {};
  Set<int?> ratedItemsLikes = {};
  Widget lista() {
    String userRole = getCurrentUserRole();
    bool isUcenik = userRole == "Ucenik";
    final screenWidth = MediaQuery.of(context).size.width;
    List<DodatnaLekcija> displayedList = showFavoritesOnly
        ? filteredList
            .where((lekcija) => omiljenaLekcijaIds.contains(lekcija.id))
            .toList()
        : filteredList;

    return Column(children: [
      Container(
        width: screenWidth * 0.9,
        height: 550,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
        ),
        child: isLoading
            ? Center(child: CircularProgressIndicator())
            : ListView.builder(
                itemCount: displayedList.length,
                itemBuilder: (context, index) {
                  var lekcija = displayedList[index];
                  bool isFavorite = omiljenaLekcijaIds.contains(lekcija.id);

                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                LekcijaDetalji(lekcija: lekcija),
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
                                    lekcija.naziv,
                                    style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.normal,
                                    ),
                                    softWrap: true,
                                    overflow: TextOverflow.visible,
                                  ),
                                  const Spacer(),
                                  IconButton(
                                    icon: Icon(
                                      isFavorite ? Icons.favorite : Icons.favorite_border,
                                      color: isFavorite ? Colors.red : Colors.black,
                                    ),
                                    onPressed: () => toggleFavorite(lekcija.id),
                                  ),
                                ],
                              ),
                              SizedBox(height: 10),
                              Divider(
                                color: Colors.blue,
                                thickness: 2,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text(lekcija.likes.toString()),
                                  ratedItemsLikes.contains(lekcija.id)
                                      ? IconButton(
                                          icon: Icon(Icons.thumb_up,
                                              color: Colors.grey),
                                          onPressed: () {},
                                        )
                                      : IconButton(
                                          icon: Icon(
                                            Icons.thumb_up,
                                            color: Colors.blue,
                                          ),
                                          onPressed: () async {
                                            bool success =
                                                await _dodatnaLekcijaProvider
                                                    .addLike(lekcija.id, 1);
                                            if (success) {
                                              setState(() {
                                                lekcija.likes += 1;
                                                ratedItemsLikes.add(lekcija
                                                    .id);
                                              });
                                            }
                                          },
                                        ),
                                  SizedBox(width: 5),
                                  Text(lekcija.dislikes.toString()),
                                  ratedItems.contains(lekcija.id)
                                      ? IconButton(
                                          icon: Icon(Icons.thumb_down,
                                              color: Colors.grey),
                                          onPressed: () {},
                                        )
                                      : IconButton(
                                          icon: Icon(
                                            Icons.thumb_down,
                                            color: Colors.redAccent,
                                          ),
                                          onPressed: () async {
                                            bool success =
                                                await _dodatnaLekcijaProvider
                                                    .addDislike(
                                                        lekcija.id, 1);
                                            if (success) {
                                              setState(() {
                                                lekcija.dislikes += 1;
                                                ratedItems.add(lekcija
                                                    .id); 
                                              });
                                            }
                                          },
                                        ),
                                  if (!isUcenik)
                                    IconButton(
                                      icon: Icon(Icons.delete,
                                          color: Colors.black),
                                      onPressed: () async {
                                        bool confirmed = await showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                              title: Text('Potvrda'),
                                              content: Text(
                                                  'Da li ste sigurni da želite izbrisati obavijest?'),
                                              actions: [
                                                TextButton(
                                                  child: Text('Ne'),
                                                  onPressed: () {
                                                    Navigator.of(context).pop(
                                                        false); // Return false if "No" is pressed
                                                  },
                                                ),
                                                TextButton(
                                                  child: Text('Da'),
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
                                              await _dodatnaLekcijaProvider
                                                  .delete(lekcija.id);
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
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
      ),
    ]);
  }

  Widget omiljene() {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0),
      child: IconButton(
        icon: Icon(
          showFavoritesOnly ? Icons.favorite : Icons.favorite_border,
          color: Colors.red,
        ),
        onPressed: () {
          setState(() {
            showFavoritesOnly = !showFavoritesOnly; // Toggle the state
          });
        },
      ),
    );
  }

  Widget btnAdd() {
    return SizedBox(
      width: 170,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.blue, // Set the button color to orange
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 28.0, vertical: 12.0),
        ),
        onPressed: () async {
          final result = await Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => DodatnaLekcijaInsert(),
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
              "LEKCIJA",
              style: TextStyle(fontSize: 18, color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }

  String getCurrentUserRole() {
    if (Korisnik.uloge.contains("Imam")) {
      return "Imam";
    } else if (Korisnik.uloge.contains("Ucenik")) {
      return "Ucenik";
    } else {
      return "Roditelj";
    }
  }

}
