import 'package:emekteb_admin/Widgets/master_screen.dart';
import 'package:emekteb_admin/models/akademska_godina.dart';
import 'package:emekteb_admin/providers/akademskagodina_provider.dart';
import 'package:emekteb_admin/providers/akademskamekteb_provider.dart';
import 'package:flutter/material.dart';
import 'package:number_paginator/number_paginator.dart';
import 'package:provider/provider.dart';
import '../models/mekteb.dart';
import '../models/razred.dart';
import '../models/searches/search_result.dart';
import '../providers/akademskarazred_provider.dart';
import '../providers/mekteb_provider.dart';
import '../providers/razred_provider.dart';

void main() {
  runApp(const AkGodine());
}

class AkGodine extends StatefulWidget {
  const AkGodine({super.key});

  @override
  State<AkGodine> createState() => _ProfilInfoState();
}

class _ProfilInfoState extends State<AkGodine> {
  late AkademskagodinaProvider _akademskaProvider;
  late AkademskaMektebProvider _akademskaMektebProvider;
  late AkademskaRazredProvider _akademskaRazredProvider;
  int currentPage = 1;
  int numPages = 12;
  bool isLoading = false;
  bool isLoading2 = false;
  bool isLoading3 = false;
  int ukupnoMekteba = 1;
  int ukupnoMekteba2 = 1;
  late MektebProvider _mektebProvider;
  SearchResult<Mekteb>? listaMekteba;
  List<Mekteb> filteredListM = [];

  SearchResult<AkademskaGodina>? listaAkademskih;
  List<AkademskaGodina> filteredList = [];
  String dropdownValue = 'Broj učenika';
  bool isSortAsc = false;

  late RazredProvider _razredProvider;
  SearchResult<Razred>? listaRazreda;
  List<Razred> filteredListRazredi = [];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _mektebProvider = context.read<MektebProvider>();
    _akademskaProvider = context.read<AkademskagodinaProvider>();
    _akademskaMektebProvider = context.read<AkademskaMektebProvider>();
    _razredProvider = context.read<RazredProvider>();
    _akademskaRazredProvider = context.read<AkademskaRazredProvider>();
    fetchDataMektebi();
    fetchDataRazredi();
    fetchData();
  }

  Future<void> fetchData({String? filter}) async {
    if (!isLoading) {
      setState(() {
        isLoading = true;
        // Clear existing data when the filter changes
        listaAkademskih = null;
        filteredList.clear();
      });

      var data = await _akademskaProvider.get(
          page: currentPage, pageSize: numPages, sort: isSortAsc);

      setState(() {
        if (listaAkademskih == null) {
          listaAkademskih = data;
          ukupnoMekteba = data.count;
        } else {
          listaAkademskih!.result.addAll(data.result);
        }
        filteredList = listaAkademskih?.result ?? [];
        //print(filteredList.isNotEmpty ? filteredList[0].naziv : 'No data');
        isLoading = false;
      });
    }
  }
  Future<void> fetchDataMektebi({String? filter}) async {
    if (!isLoading2) {
      setState(() {
        isLoading2 = true;
        // Clear existing data when the filter changes
        listaMekteba = null;
        filteredListM.clear();
      });

      var data = await _mektebProvider.get();

      setState(() {
        if (listaMekteba == null) {
          listaMekteba = data;
          ukupnoMekteba2 = data.count;
        } else {
          listaMekteba!.result.addAll(data.result);
        }

        filteredListM = listaMekteba?.result ?? [];
        isLoading2 = false;
      });
    }
  }

  Future<void> fetchDataRazredi({String? filter}) async {
    if (!isLoading3) {
      setState(() {
        isLoading3 = true;
        // Clear existing data when the filter changes
        listaRazreda = null;
        filteredListM.clear();
      });

      var data = await _razredProvider.get();

      setState(() {
        if (listaRazreda == null) {
          listaRazreda = data;
          ukupnoMekteba2 = data.count;
        } else {
          listaRazreda!.result.addAll(data.result);
        }

        filteredListRazredi = listaRazreda?.result ?? [];
        isLoading3 = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MasterScreen(
      title: "Akademske godine",
      child: Column(
        children: [
          headerButtons(),
          Expanded(child: gridView()),
          pageNumbers(),
        ],
      ),
    );
  }
  Widget gridView() {
    return Padding(
      padding: const EdgeInsets.all(30),
      child: GridView.builder(
        itemCount: filteredList.length, // Ensure the item count is set
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4, // Set the number of columns
          crossAxisSpacing: 22.0, // Set the spacing between columns
          mainAxisSpacing: 22.0, // Set the spacing between rows
          childAspectRatio: 2.5,
        ),
        itemBuilder: (BuildContext context, int index) {
          AkademskaGodina akGodina = filteredList[index];
          return Card(
            child: Container(
              width: 50,
              decoration: BoxDecoration(color: Colors.blueGrey[100]),
              padding: const EdgeInsets.all(8.0),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 15),
                          child: Text(
                            akGodina.naziv.toString(),
                            style: const TextStyle(
                                fontSize: 22, fontWeight: FontWeight.w500),
                          ),
                        ),
                        const Spacer(),
                        PopupMenuButton<int>(
                          icon: const Icon(Icons.more_vert),
                          itemBuilder: (BuildContext context) =>
                          <PopupMenuEntry<int>>[
                            const PopupMenuItem<int>(
                              value: 1,
                              child: Text("Izbriši"),
                            ),
                            // Add more options as needed
                          ],
                          onSelected: (int value) async {
                            if (value == 1) {
                              bool confirmDelete = await showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: const Text("Potvrda brisanja"),
                                    content: const Text("Jeste li sigurni da želite izbrisati ovu akademsku godinu?"),
                                    actions: [
                                      TextButton(
                                        child: const Text("Ne"),
                                        onPressed: () {
                                          Navigator.of(context).pop(false);
                                        },
                                      ),
                                      TextButton(
                                        child: const Text("Da"),
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
                                  bool result = await _akademskaProvider.delete(akGodina.id);
                                  if (result) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(content: Text('Akademska godina uspješno izbrisana')),
                                    );
                                    await fetchData();
                                  }
                                } catch (e) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text('Greška pri brisanju akademske godine: $e')),
                                  );
                                }
                              }
                            }
                          },
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    Flexible(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 15),
                        child: Text.rich(
                          TextSpan(
                            text: "Ukupno mekteba: ",
                            style: const TextStyle(fontSize: 16),
                            children: [
                              TextSpan(
                                text: akGodina.ukupnoMekteba.toString(),
                                style: const TextStyle(
                                  fontSize: 16,
                                  color: Colors.blue, // Change this to your desired color
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 15),
                      child: Text.rich(
                        TextSpan(
                          text: "Ukupno učenika: ",
                          style: const TextStyle(fontSize: 16),
                          children: [
                            TextSpan(
                              text: (akGodina.ukupnoUcenika ?? 0).toString(),
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



  Widget headerButtons() {
    return Padding(
      padding: const EdgeInsets.all(30.0),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            height: 36,
            decoration: BoxDecoration(
              color: Colors.blueGrey[50],
              border: Border.all(color: Colors.black),
              borderRadius: const BorderRadius.all(Radius.circular(4.0)),
            ),
            child: DropdownButton<String>(
              value: dropdownValue,
              icon: const Icon(Icons.arrow_drop_down),
              elevation: 16,
              style: const TextStyle(color: Colors.black),
              underline: Container(), // Remove underline on the button
              onChanged: (String? value) {
                setState(() {
                  dropdownValue = value!;
                  sortData();
                  //promjeniSort();
                  //fetchData();
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
          ),
          const SizedBox(width: 20),

          IconButton(
            iconSize: 30,
            icon: const Icon(Icons.swap_vert_rounded),
            onPressed: () {
              setState(() {
                isSortAsc = !isSortAsc; // Toggle sort order
                fetchData();
              });
            },
          ),
          const Spacer(),

          Text(
            "Ukupno: $ukupnoMekteba",
            style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w500), // Use the actual total count
          ),
          const SizedBox(width: 20),

          ElevatedButton(
            onPressed: () => _showCreateForm(context, _akademskaProvider, _akademskaMektebProvider, filteredListM),
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
                  "AKADEMSKA",
                  style: TextStyle(fontSize: 18),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
  void _showCreateForm(BuildContext context, AkademskagodinaProvider provider, AkademskaMektebProvider _akademskaMektebProvider, List<Mekteb> filteredListM) {
    final formKey = GlobalKey<FormState>();
    String naziv = '';
    DateTime datumPocetka = DateTime.now();
    DateTime datumZavrsetka = DateTime.now();
    final TextEditingController datumPocetkaController = TextEditingController();
    final TextEditingController datumZavrsetkaController = TextEditingController();

    // Initializing the text fields with the current date values
    datumPocetkaController.text = datumPocetka.toLocal().toString().split(' ')[0];
    datumZavrsetkaController.text = datumZavrsetka.toLocal().toString().split(' ')[0];

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Dodaj akademsku godinu'),
          content: Form(
            key: formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Naziv'),
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
                  controller: datumPocetkaController,
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
                      datumPocetka = picked;
                      datumPocetkaController.text = datumPocetka.toLocal().toString().split(' ')[0];
                    }
                  },
                ),
                TextFormField(
                  controller: datumZavrsetkaController,
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
                      datumZavrsetka = picked;
                      datumZavrsetkaController.text = datumZavrsetka.toLocal().toString().split(' ')[0];
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

                  // Create AkademskaGodina and get its ID
                  int? akademskaGodinaId = await provider.createAkademskaGodina(naziv, datumPocetka, datumZavrsetka);

                  if (akademskaGodinaId != null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Akademska godina uspješno dodana')),
                    );

                    // Loop through all mektebs in filteredListM and insert AkademskaMekteb records
                    for (Mekteb mekteb in filteredListM) {
                      await _akademskaMektebProvider.insertAkademskaMekteb(akademskaGodinaId, mekteb.id);
                    }

                    for (Razred razred in filteredListRazredi) {
                      await _akademskaRazredProvider.insertAkademskaRazred(akademskaGodinaId, razred.id);
                    }

                    fetchData();
                    Navigator.of(context).pop();
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Greška pri dodavanju akademske godine')),
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
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Card(
        margin: EdgeInsets.zero,
        elevation: 2,
        child: SizedBox(
          width: (ukupnoMekteba > 100) ? 140 : 130,
          child: NumberPaginator(
            config:
            const NumberPaginatorUIConfig(mode: ContentDisplayMode.dropdown),
            numberPages: (ukupnoMekteba) ~/ numPages + 1,
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

  void promjeniSort() {
    if (dropdownValue == 'Manje - Veće') {
      isSortAsc = true;
    } else {
      isSortAsc = false;
    }
    fetchData();
  }

  void sortData() {
    if (dropdownValue == 'Broj učenika') {
      filteredList.sort((a, b) {
        int aValue = a.ukupnoUcenika ?? 0;
        int bValue = b.ukupnoUcenika ?? 0;
        return isSortAsc ? aValue.compareTo(bValue) : bValue.compareTo(aValue);
      });
    } else if (dropdownValue == 'Manje - Veće') {
      filteredList.sort((a, b) {
        int aValue = a.ukupnoUcenika ?? 0;
        int bValue = b.ukupnoUcenika ?? 0;
        return aValue.compareTo(bValue);
      });
    } else if (dropdownValue == 'Veće - Manje') {
      filteredList.sort((a, b) {
        int aValue = a.ukupnoUcenika ?? 0;
        int bValue = b.ukupnoUcenika ?? 0;
        return bValue.compareTo(aValue);
      });
    }
  }

}
