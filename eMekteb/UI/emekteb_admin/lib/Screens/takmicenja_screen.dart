// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:emekteb_admin/Screens/takmicenje_details_screen.dart';
import 'package:emekteb_admin/Widgets/master_screen.dart';
import 'package:emekteb_admin/providers/takmicenja_provider.dart';
import 'package:flutter/material.dart';
import 'package:number_paginator/number_paginator.dart';
import 'package:provider/provider.dart';

import '../models/searches/search_result.dart';
import '../models/takmicenje.dart';

void main() {
  runApp(const Takmicenja());
}

class Takmicenja extends StatefulWidget {
  const Takmicenja({super.key});

  @override
  State<Takmicenja> createState() => _ProfilInfoState();
}

class _ProfilInfoState extends State<Takmicenja> {
  late TakmicenjaProvider _takmicenjaProvider;
  int currentPage = 1;
  int numPages = 12;
  bool isLoading = false;
  int ukupnoTakmicenja = 1;

  SearchResult<Takmicenje>? listaTakmicenja;
  List<Takmicenje> filteredList = [];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _takmicenjaProvider = context.read<TakmicenjaProvider>();
    fetchData();
  }

  Future<void> fetchData({String? filter}) async {
    if (!isLoading) {
      setState(() {
        isLoading = true;
        // Clear existing data when the filter changes
        listaTakmicenja = null;
        filteredList.clear();
      });

      var data =
          await _takmicenjaProvider.get(page: currentPage, pageSize: numPages, sort: false);

      setState(() {
        if (listaTakmicenja == null) {
          listaTakmicenja = data;
          ukupnoTakmicenja = data.count;
        } else {
          listaTakmicenja!.result.addAll(data.result);
        }
        filteredList = listaTakmicenja?.result ?? [];
        //print(filteredList.isNotEmpty ? filteredList[0].naziv : 'No data');
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MasterScreen(
      title: "Takmičenja",
      child: Column(
        children: [
          headerButtons(),
          filteredList.isNotEmpty
          ? Expanded(child: gridView())
              : Center(child: CircularProgressIndicator()),
          pageNumbers()
        ],
      ),
    );
  }

  Widget headerButtons() {
    return Padding(
      padding: EdgeInsets.all(30.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          ElevatedButton(
            onPressed: () => _showCreateForm(context, _takmicenjaProvider),
            style: ElevatedButton.styleFrom(
              shape: const RoundedRectangleBorder(),
              padding: const EdgeInsets.only(
                  left: 20.0, right: 24.0, top: 16.0, bottom: 16.0),
            ),
            child: const Row(
              children: [
                Icon(Icons.add),
                SizedBox(width: 10),
                Text(
                  "TAKMIČENJE",
                  style: TextStyle(fontSize: 18),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget gridView() {
    return Padding(
      padding: EdgeInsets.all(30),
      child: GridView.builder(
        itemCount: filteredList.length, // Ensure the item count is set
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4, // Set the number of columns
          crossAxisSpacing: 22.0, // Set the spacing between columns
          mainAxisSpacing: 22.0, // Set the spacing between rows
          childAspectRatio: 2.5,
        ),
        itemBuilder: (BuildContext context, int index) {
          Takmicenje takmicenje = filteredList[index];
          return InkWell(
            onTap: () {
              Navigator.of(context).pushReplacement(
                // pushReplacement or push
                MaterialPageRoute(
                  builder: (context) => TakmicenjeDetalji(takmicenje: takmicenje),
                ),
              );
            },
            child: Card(
              child: Container(
                decoration: BoxDecoration(color: Colors.blueGrey[100]),
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 15),
                          child: Text(
                            "Takmičenje - ${takmicenje.godina.toString()}",
                            style: const TextStyle(
                                fontSize: 22, fontWeight: FontWeight.w500),
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
                                    content: const Text(
                                        "Jeste li sigurni da želite izbrisati ovo takmičenje?"),
                                    actions: [
                                      TextButton(
                                        child: const Text("Ne", style: TextStyle(fontSize: 18),),
                                        onPressed: () {
                                          Navigator.of(context).pop(false);
                                        },
                                      ),
                                      TextButton(
                                        child: const Text("Da", style: TextStyle(color: Colors.red, fontSize: 18),),
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
                                  bool result = await _takmicenjaProvider
                                      .delete(takmicenje.id);
                                  if (result) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                          content: Text('Takmičenje uspješno izbrisano')),
                                    );
                                    await fetchData();
                                  }
                                } catch (e) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                        content: Text(
                                            'Greška pri brisanju takmičenja: $e')),
                                  );
                                }
                              }
                            }
                            else if (value == 2) {
                              _showEditForm(context, _takmicenjaProvider, takmicenje);
                            }
                          },
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Padding(
                      padding: const EdgeInsets.only(left: 15),
                      child: Text.rich(
                        TextSpan(
                          text: "Ukupno takmičara: ",
                          style: const TextStyle(fontSize: 16),
                          children: [
                            TextSpan(
                              text: takmicenje.ukupnoUcenika.toString(),
                              style: const TextStyle(
                                fontSize: 16,
                                color: Colors.blue, // Change this to your desired color
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 15, top: 8.0),
                      child: Text.rich(
                        TextSpan(
                          text: "Mjesto takmičenja: ",
                          style: const TextStyle(fontSize: 16),
                          children: [
                            TextSpan(
                              text: (takmicenje.lokacija ?? 'Nepoznato').toString(),
                              style: const TextStyle(color: Colors.blue),
                            ),
                          ],
                        ),
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
  void _showEditForm(BuildContext context, TakmicenjaProvider provider, Takmicenje existingTakmicenje) {
    final formKey = GlobalKey<FormState>();
    String? godina = existingTakmicenje.godina;
    String? lokacija = existingTakmicenje.lokacija;
    String? vrijemePocetka = existingTakmicenje.vrijemePocetka;
    String? info = existingTakmicenje.info;
    DateTime? datumOdrzavanja = existingTakmicenje.datumOdrzavanja;

    final TextEditingController datumOdrzavanjaController = TextEditingController();
    datumOdrzavanjaController.text = datumOdrzavanja!.toLocal().toString().split(' ')[0];

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Izmijeni takmičenje'),
          content: Form(
            key: formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  initialValue: godina,
                  decoration: const InputDecoration(labelText: 'Godina'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Unesite godinu takmičenja';
                    } else if (!RegExp(r'^\d{4}$').hasMatch(value)) {
                      return 'Neispravan format, unesite 4 cifre!';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    godina = value!;
                  },
                ),
                TextFormField(
                  initialValue: lokacija,
                  decoration: const InputDecoration(labelText: 'Lokacija održavanja'),
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
                  initialValue: vrijemePocetka,
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
                  initialValue: info,
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
                      datumOdrzavanja = picked;
                      datumOdrzavanjaController.text = datumOdrzavanja!.toLocal().toString().split(' ')[0];
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
              child: const Text('Ažuriraj'),
              onPressed: () async {
                if (formKey.currentState!.validate()) {
                  formKey.currentState!.save();

                  bool result = await provider.update(
                    existingTakmicenje.id,
                    godina,
                    datumOdrzavanja,
                    lokacija,
                    vrijemePocetka,
                    info,
                  );

                  if (result) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Takmičenje uspješno ažurirano')),
                    );
                    fetchData();
                    Navigator.of(context).pop();
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Greška pri izvršenju')),
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

  void _showCreateForm(BuildContext context, TakmicenjaProvider provider) {
    final formKey = GlobalKey<FormState>();
    String naziv = '';
    String lokacija = '';
    String vrijemePocetka = '';
    String info = '';
    DateTime datumOdrzavanja = DateTime.now();

    final TextEditingController datumOdrzavanjaController = TextEditingController();

    // Initializing the text fields with the current date values
    datumOdrzavanjaController.text = datumOdrzavanja.toLocal().toString().split(' ')[0];

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Dodaj takmičenje'),
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
                    }else if (!RegExp(r'^\d{4}$').hasMatch(value)) {
                      return 'Neispravan format, unesite 4 cifre!';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    naziv = value!;
                  },
                ),
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Lokacija održavanja'),
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
                        datumOdrzavanjaController.text = datumOdrzavanja.toLocal().toString().split(' ')[0];
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
                if (formKey.currentState!.validate()) {
                  formKey.currentState!.save();
                  bool result = await provider.createTakmicenje(naziv, datumOdrzavanja, lokacija, vrijemePocetka, info);
                  if (result) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Takmičenje uspješno dodano')),
                    );
                    fetchData();
                    Navigator.of(context).pop();
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Greška pri dodavanju takmičenja')),
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
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Card(
        margin: EdgeInsets.zero,
        elevation: 2,
        child: SizedBox(
          width: (ukupnoTakmicenja > 100) ? 140 : 130,
          child: NumberPaginator(
            config:
            const NumberPaginatorUIConfig(mode: ContentDisplayMode.dropdown),
            numberPages: (ukupnoTakmicenja) ~/ numPages + 1,
            onPageChange: (int index) {
              setState(() {
                currentPage = index + 1;
                filteredList.clear(); // Clear existing data
              });
              fetchData();
            },
          ),
        ),
      ),
    );
  }
}
