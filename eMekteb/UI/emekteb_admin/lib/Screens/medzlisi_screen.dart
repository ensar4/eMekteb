// ignore_for_file: prefer_const_constructors

import 'dart:async';
import 'package:emekteb_admin/Screens/medzlis_details_screen.dart';
import 'package:emekteb_admin/Widgets/master_screen.dart';
import 'package:emekteb_admin/models/korisnik.dart';
import 'package:emekteb_admin/models/medzlis.dart';
import 'package:emekteb_admin/providers/akademskagodina_provider.dart';
import 'package:emekteb_admin/providers/akademskamekteb_provider.dart';
import 'package:emekteb_admin/providers/mekteb_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:number_paginator/number_paginator.dart';
import '../models/mekteb.dart';
import '../models/searches/search_result.dart';
import '../providers/medzlis_provider.dart';
import 'mekteb_details_screen.dart';

void main() {
  runApp(const Medzlisi());
}

class Medzlisi extends StatefulWidget {
  const Medzlisi({super.key});

  @override
  State<Medzlisi> createState() => _ProfilInfoState();
}

class _ProfilInfoState extends State<Medzlisi> {
  late MedzlisProvider _medzlisProvider;
  late AkademskaMektebProvider _akademskaMektebProvider;
  late AkademskagodinaProvider _akademskaProvider;
  var medzlisIde = Korisnik.medzlisId;
  var muftijstvoIde = Korisnik.muftijstvoId;
  SearchResult<Medzlis>? listaMedzlisa;
  List<Medzlis> filteredList = [];
  
  TextEditingController searchController = TextEditingController();
  int currentPage = 1;
  int numPages = 12;
  bool isLoading = false;
  int ukupnoMedzlisa = 1;
  String dropdownValue = 'Broj učenika';
  String dropdownValue2 = 'Prosjek';
  bool isSortAsc = false;


  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _medzlisProvider = context.read<MedzlisProvider>();
    _akademskaProvider = context.read<AkademskagodinaProvider>();
    _akademskaMektebProvider = context.read<AkademskaMektebProvider>();
    fetchData();
  }

  Future<void> fetchData({String? filter}) async {
    if (!isLoading) {
      setState(() {
        isLoading = true;
        // Clear existing data when the filter changes
        listaMedzlisa = null;
        filteredList.clear();
      });

      var data = await _medzlisProvider.getForMuftijstvo(filterController: searchController, page: currentPage, pageSize: numPages, sort: isSortAsc, muftijstvoId: muftijstvoIde);

      setState(() {
        if (listaMedzlisa == null) {
          listaMedzlisa = data;
          ukupnoMedzlisa = data.count;
        } else {
          listaMedzlisa!.result.addAll(data.result);
        }

        filteredList = listaMedzlisa?.result ?? [];
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MasterScreen(
      title: "Medžlisi",
      child: Column(
        children: [
          headerPretraga_Dodaj(),
          Padding(
            padding: const EdgeInsets.only(left: 30, right: 30, bottom: 30),
            child: Row(
              children: [
                btnORderByBrojUcenika(),
                SizedBox(
                  width: 15,
                ),
                btnOrderByProsjek(),
                SizedBox(
                  width: 15,
                ),
                Spacer(),
                Text(
                  "Ukupno medžlisa: $ukupnoMedzlisa",
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w400),
                ),
              ],
            ),
          ),
          Expanded(
            child: gridView(),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 5),
            child: pageNumbers(),
          ),
        ],
      ),
    );
  }
  Widget headerPretraga_Dodaj() {
    return Padding(
      padding: const EdgeInsets.all(30.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: 250,
            child: TextField(
              controller: searchController,
              onChanged: (value) {
                fetchData();
              },
              decoration: InputDecoration(
                hintText: "Pretraga",
                isDense: true,
                contentPadding: const EdgeInsets.symmetric(horizontal: 20),
                border: const OutlineInputBorder(),
                prefixIcon: const Icon(Icons.search),
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              _showCreateForm(context, _medzlisProvider);
            },
            style: ElevatedButton.styleFrom(
              shape: const RoundedRectangleBorder(),
              padding: const EdgeInsets.symmetric(horizontal: 26.0, vertical: 16.0),
            ),
            child: Row(
              children: const [
                Icon(Icons.add),
                SizedBox(width: 10),
                Text(
                  "MEDŽLIS",
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget btnORderByBrojUcenika() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12),
      height: 36,
      decoration: BoxDecoration(
        color: Colors.blueGrey[50],
        border: Border.all(color: Colors.black),
        borderRadius: BorderRadius.all(Radius.circular(4.0)),
      ),
      child: DropdownButton<String>(
        value: dropdownValue,
        icon: const Icon(Icons.arrow_drop_down),
        elevation: 16,
        style: const TextStyle(color: Colors.black),
        underline: Container(), //za brisanje underline na butotnu
        onChanged: (String? value) {
          // This is called when the user selects an item.
          setState(() {
            dropdownValue = value!;
            promjeniSort();
            fetchData();
          });
        },
        items: ['Broj učenika', 'Manje - Veće', 'Veće - Manje']
            .map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
      ),
    );
  }

  Widget btnOrderByProsjek() {
    return Container(
      //-------button2
      padding: EdgeInsets.symmetric(horizontal: 12),
      height: 36,
      decoration: BoxDecoration(
        color: Colors.blueGrey[50],
        border: Border.all(color: Colors.black),
        borderRadius: BorderRadius.all(Radius.circular(4.0)),
      ),
      child: DropdownButton<String>(
        value: dropdownValue2,
        icon: const Icon(Icons.arrow_drop_down),
        elevation: 16,
        style: const TextStyle(color: Colors.black),
        underline: Container(),
        onChanged: (String? value) {
          setState(() {
            dropdownValue2 = value!;
            sortByProsjek(value);
          });
        },
        items: ['Prosjek', 'Manji - Veći', 'Veći - Manji']
            .map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
      ),
    );
  }

  Widget gridView() {
    return Padding(
      padding: const EdgeInsets.only(left: 30, right: 30, bottom: 30, top: 10),
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4, // Number of columns
          crossAxisSpacing: 22.0, // Spacing between columns
          mainAxisSpacing: 22.0, // Spacing between rows
          childAspectRatio: 2.5,
        ),
        itemCount: filteredList.length,
        itemBuilder: (BuildContext context, int index) {
          Medzlis mekteb = filteredList[index]; //RENAME mekteb---> MEDZLIS
          return InkWell(
            onTap: () {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) => MedzlisDetalji(medzlis: mekteb),
                ),
              );
            },
            child: Card(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.blueGrey[100],
                ),
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          mekteb.naziv ?? "N/A",
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        const Spacer(),
                        PopupMenuButton<int>(
                          icon: const Icon(Icons.more_vert),
                          itemBuilder: (BuildContext context) => <PopupMenuEntry<int>>[
                            const PopupMenuItem<int>(
                              value: 1,
                              child: Text("Izbriši"),
                            ),
                            const PopupMenuItem<int>(
                              value: 2,
                              child: Text("Uredi"),
                            ),
                          ],
                          onSelected: (int value) async {
                            if (value == 1) {
                              bool confirmDelete = await showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: const Text("Potvrda brisanja"),
                                    content: const Text("Jeste li sigurni da želite izbrisati medžlis?"),
                                    actions: [
                                      TextButton(
                                        child: const Text("Ne", style: TextStyle(fontSize: 18)),
                                        onPressed: () {
                                          Navigator.of(context).pop(false);
                                        },
                                      ),
                                      TextButton(
                                        child: const Text("Da", style: TextStyle(color: Colors.red, fontSize: 18)),
                                        onPressed: () {
                                          Navigator.of(context).pop(true);
                                        },
                                      ),
                                    ],
                                  );
                                },
                              );

                              if (confirmDelete) {
                                try {
                                  bool result = await _medzlisProvider.delete(mekteb.id);
                                  if (result) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(content: Text('Medžlis uspješno izbrisan')),
                                    );
                                    await fetchData();
                                  }
                                } catch (e) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text('Greška pri brisanju medžlisa: $e')),
                                  );
                                }
                              }
                            } else if (value == 2) {
                              _showEditForm(context, _medzlisProvider, mekteb);
                            }
                          },
                        ),
                      ],
                    ),
                    const SizedBox(height: 15),
                    Flexible(
                      child: Row(
                        children: [
                          const Text(
                            "Broj učenika: ",
                            style: TextStyle(fontSize: 16),
                          ),
                          Text(
                            mekteb.ukupnoUcenika.toString(),
                            style: const TextStyle(
                              color: Colors.indigoAccent,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Flexible(
                      child: Row(
                        children: [
                          const Text(
                            "Broj mekteba: ",
                            style: TextStyle(fontSize: 16),
                          ),
                          Text(
                            mekteb.ukupnoMekteba.toString() ?? "N/A",
                            style: const TextStyle(
                              color: Colors.indigoAccent,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  void _showEditForm(BuildContext context, MedzlisProvider provider, Medzlis medzlis) {
    final formKey = GlobalKey<FormState>();
    String naziv = medzlis.naziv ?? '';
    String telefon = medzlis.telefon ?? '';
    String adresa = medzlis.adresa ?? '';
    String mail = medzlis.mail ?? '';

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Uredi medžlis'),
          content: Form(
            key: formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  initialValue: naziv,
                  decoration: const InputDecoration(labelText: 'Naziv'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Unesite naziv medžlisa';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    naziv = value!;
                  },
                ),
                TextFormField(
                  initialValue: adresa,
                  decoration: const InputDecoration(labelText: 'Adresa medžlisa'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Unesite adresu medžlisa';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    adresa = value!;
                  },
                ),
                TextFormField(
                  initialValue: telefon,
                  decoration: const InputDecoration(labelText: 'Telefon'),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Unesite telefon';
                    } else if (!RegExp(r'^[0-9\s\-/]+$').hasMatch(value)) {
                      return 'Neispravan format!';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    telefon = value!;
                  },
                ),
                TextFormField(
                  initialValue: mail,
                  decoration: const InputDecoration(labelText: 'Mail'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Unesite mail';
                    } else if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
                      return 'Neispravan format maila!';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    mail = value!;
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
               if (formKey.currentState!.validate()) {
                 formKey.currentState!.save();

                 bool updateResult = await provider.update(
                   medzlis.id,
                   naziv,
                   telefon,
                   adresa,
                   mail
                 );

                 if (updateResult) {
                   ScaffoldMessenger.of(context).showSnackBar(
                     const SnackBar(content: Text('Medžlis uspješno ažuriran')),
                   );
                   fetchData();
                   Navigator.of(context).pop();
                 } else {
                   ScaffoldMessenger.of(context).showSnackBar(
                     const SnackBar(content: Text('Greška pri ažuriranju medžlisa')),
                   );
                 }
               }
             },
            ),
          ],
        );
      },
    );
  }

  void _showCreateForm(BuildContext context, MedzlisProvider provider) {
    final formKey = GlobalKey<FormState>();
    String naziv = '';
    String telefon = '';
    String adresa = '';
    String mail = '';
    int? muftijstvoId = muftijstvoIde;
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Dodaj medžlis'),
          content: Form(
            key: formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Naziv'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Unesite naziv medžlisa';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    naziv = value!;
                  },
                ),
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Adresa medžlisa'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Unesite adresu medžlisa';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    adresa = value!;
                  },
                ),
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Telefon'),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Unesite telefon';
                    } else if (!RegExp(r'^[0-9\s\-/]+$').hasMatch(value)) {
                      return 'Neispravan format!';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    telefon = value!;
                  },
                ),
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Mail'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Unesite mail';
                    } else if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
                      return 'Neispravan format maila!';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    mail = value!;
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
               if (formKey.currentState!.validate()) {
                 formKey.currentState!.save();

                 // First, insert the new Mekteb
                 int? mektebResult = await provider.insert(naziv, adresa, telefon, mail, muftijstvoId);

                 if (mektebResult != null) {
                   ScaffoldMessenger.of(context).showSnackBar(
                     const SnackBar(content: Text('medžlis uspješno dodan')),
                   );
                     int? akademskaGodinaId = await _akademskaProvider.getActiveId();
                     if (akademskaGodinaId != null) {
                       await _akademskaMektebProvider
                           .insertAkademskaMekteb(
                           akademskaGodinaId, mektebResult);
                     }
                   fetchData();
                   Navigator.of(context).pop();
                 } else {
                   ScaffoldMessenger.of(context).showSnackBar(
                     const SnackBar(content: Text('Greška pri dodavanju medžlisa')),
                   );
                 }
               }
              },
            ),
          ],
        );
      },
    );
  }

  Widget pageNumbers() {
    return Card(
      margin: EdgeInsets.zero,
      elevation: 2,
      child: SizedBox(
        width: (ukupnoMedzlisa > 100) ? 140 : 130,
        child: NumberPaginator(
          config:
              const NumberPaginatorUIConfig(mode: ContentDisplayMode.dropdown),
          numberPages: (ukupnoMedzlisa) ~/ numPages + 1,
          onPageChange: (int index) {
            setState(() {
              currentPage = index + 1;
              filteredList.clear(); // Clear existing data
            });
            fetchData();
          },
        ),
      ),
    );
  }

  bool promjeniSort() {
    if (dropdownValue == 'Manje - Veće') {
      return isSortAsc = true;
    } else {
      return isSortAsc = false;
    }
  }
  void sortByProsjek(String sortOrder) {
    setState(() {
      if (sortOrder == 'Manji - Veći') {
        filteredList.sort((a, b) {
          if (a.prosjecnaOcjena == null && b.prosjecnaOcjena == null) return 0;
          if (a.prosjecnaOcjena == null) return 1;
          if (b.prosjecnaOcjena == null) return -1;
          return a.prosjecnaOcjena!.compareTo(b.prosjecnaOcjena!);
        });
      } else if (sortOrder == 'Veći - Manji') {
        filteredList.sort((a, b) {
          if (a.prosjecnaOcjena == null && b.prosjecnaOcjena == null) return 0;
          if (a.prosjecnaOcjena == null) return 1;
          if (b.prosjecnaOcjena == null) return -1;
          return b.prosjecnaOcjena!.compareTo(a.prosjecnaOcjena!);
        });
      }
    });
  }

}
