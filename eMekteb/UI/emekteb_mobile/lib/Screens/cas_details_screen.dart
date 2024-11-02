import 'package:emekteb_mobile/Widgets/master_screen.dart';
import 'package:emekteb_mobile/models/prisustvo.dart';
import 'package:emekteb_mobile/providers/ocjene_provider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../models/cas.dart';
import '../models/searches/search_result.dart';
import '../models/ucenik.dart';
import '../models/user.dart';
import '../providers/ucenici_provider.dart';
import '../providers/prisustvo_provider.dart';
import '../providers/user_provider.dart';
import '../providers/zadaca_provider.dart';

void main() {
  runApp(const CasDetalji(
    cas: null,
  ));
}

class CasDetalji extends StatefulWidget {
  final Cas? cas;
  const CasDetalji({super.key, this.cas});

  @override
  State<CasDetalji> createState() => _CasDetaljiState();
}

class _CasDetaljiState extends State<CasDetalji> {
  late UceniciProvider _uceniciProvider;
  late PrisustvoProvider _prisustvoProvider;
  late OcjeneProvider _ocjeneProvider;
  late UserProvider _userProvider;

  SearchResult<Ucenik>? listaUcenika;
  List<Ucenik> filteredList = [];
  List<User> filteredListUcenici = [];
  SearchResult<Prisustvo>? listaPrisustva;
  List<Prisustvo> filteredListPrisustva = [];
  List<Ucenik> selectedUcenici = [];
  bool isLoading = false;
  int ukupnoUcenika = 0;

  List<dynamic> filteredListKategorija = [];
  dynamic listaKategorija;
  bool isLoading2 = false;
  bool isLoading5 = false;
  bool isLoading3 = false;
  int ukupno2 = 1;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _uceniciProvider = context.read<UceniciProvider>();
    _prisustvoProvider = context.read<PrisustvoProvider>();
    _ocjeneProvider = context.read<OcjeneProvider>();
    _userProvider = context.read<UserProvider>();
    fetchDataOcjene();
    fetchDataPrisustva();
    fetchData();
    fetchDataPrisutniUcenici();
  }

//fetch da dobijemo sve ucenike da bi ih mogli oznaciti prisutnim
  Future<void> fetchData() async {
    setState(() {
      isLoading = true;
    });

    var data = await _uceniciProvider.getById2(_userProvider.user!.mektebId);

    setState(() {
      listaUcenika = data;
      filteredList = listaUcenika?.result
          .where((ucenik) => ucenik.nazivRazreda == widget.cas?.razred)
          .toList() ??
          [];
      ukupnoUcenika = filteredList.length;
      isLoading = false;
    });
  }

  Future<void> fetchDataOcjene() async {
    if (!isLoading2) {
      setState(() {
        isLoading5 = true;
        // Clear existing data when the filter changes
        listaKategorija = null;
        filteredListKategorija.clear();
      });

      var data = await _ocjeneProvider.get(page: 1, pageSize: 100);

      setState(() {
        if (listaKategorija == null) {
          listaKategorija = data;
          ukupno2 = data.count;
        } else {
          listaKategorija!.result.addAll(data.result);
        }
        filteredListKategorija = listaKategorija?.result ?? [];
        // print(filteredList.isNotEmpty ? filteredList[0].naziv : 'No data');
        isLoading5 = false;
      });
    }
  }

  //dobavljanje svih podataka o prisustvu odabranom casu
 Future<void> fetchDataPrisustva() async {
    if (!isLoading2) {
      setState(() {
        isLoading2 = true;
        // Clear existing data when the filter changes
        listaPrisustva = null;
        filteredListPrisustva.clear();
      });

      var data = await _prisustvoProvider.getById2(widget.cas?.id);

      setState(() {
        if (listaPrisustva == null) {
          listaPrisustva = data;
          ukupno2 = data.count;
        } else {
          listaPrisustva!.result.addAll(data.result);
        }
        filteredListPrisustva = listaPrisustva?.result ?? [];
        fetchDataPrisutniUcenici();
        isLoading2 = false;  // Corrected from isLoading to isLoading2
      });
    }
  }

  //prikaz prisutnih ucenika na casu (ne prikazuj odsutne)
  Future<void> fetchDataPrisutniUcenici() async {
    if (!isLoading3 && filteredListPrisustva.isNotEmpty) {
      setState(() {
        isLoading3 = true;
        filteredListUcenici.clear();
      });
      try {
        // Iterate over each entry in 'filteredListPrisustva' where 'prisutan == true'
        for (var prisustvo in filteredListPrisustva) {
          if (prisustvo.prisutan == true) {
            // Fetch details for each student by their ID
            var result = await _userProvider.getById(prisustvo.korisnikId);

            // Add the fetched students to the list if not already present
            if (result.result.isNotEmpty) {
              setState(() {
                filteredListUcenici.addAll(result.result);
              });
            }
          }
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Greška pri dohvaćanju podataka o učenicima.')),
        );
      } finally {
        setState(() {
          isLoading3 = false; // Update the loading state
        });
      }
    }
  }

  void _showMultiSelectDialog() async {
    final List<Ucenik> selected = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return MultiSelectDialog(
          ucenici: filteredList,
          selectedUcenici: selectedUcenici,
        );
      },
    );

    setState(() {
      selectedUcenici = selected;
      _confirmSelection(); // Call confirm selection after setting selectedUcenici

    });
    }

  Future<void> _confirmSelection() async {
    bool allSuccess = true; // Track overall success

    for (Ucenik ucenik in filteredList) {
      bool isSelected = selectedUcenici.contains(ucenik);

      bool alreadyExists = filteredListUcenici.any((existingUcenik) => existingUcenik.id == ucenik.id);

      if (alreadyExists) {
        continue;
      }

      try {
        await _prisustvoProvider.insert(
            isSelected,
            DateTime.now(),
            ucenik.id,
            widget.cas?.id,
            ucenik.idRazreda
        );
      } catch (error) {
        allSuccess = false;
      }
    }

    if (allSuccess) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Prisustvo uspješno zabilježeno.')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Greška pri dodavanju prisustva.')),
      );
    }

    await fetchDataPrisustva();
    await fetchDataPrisutniUcenici();
  }

  @override
  Widget build(BuildContext context) {
    return MasterScreen(
      title: "Ispitivanje",
      child: SingleChildScrollView(
        child: Column(
          children: [
            naziv(),
            lekcija(),
            Padding(
              padding: const EdgeInsets.only(bottom: 25.0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.purple.shade400, // Light blue color
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 36.0, vertical: 12.0),
                ),
                onPressed: _showMultiSelectDialog,
                child: const Text("Prisutni učenici",
                  style: TextStyle(fontSize: 18, color: Colors.white),),
              ),
            ),
            if (filteredListUcenici.isNotEmpty)
              Column(
                children: filteredListUcenici.map((ucenik) => ListTile(
                  title: Text('${ucenik.ime} ${ucenik.prezime}'),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit),
                        onPressed: () {
                          // Add your edit functionality here
                          _editUcenik(ucenik);
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.remove_circle_outline),
                        onPressed: () {
                          setState(() {
                            filteredListUcenici.remove(ucenik);
                          });
                        },
                      ),
                    ],
                  ),
                )).toList(),
              ),
          ],
        ),
      ),
    );
  }

  Widget naziv() {
    return Padding(
      padding: const EdgeInsets.only(top: 25.0, bottom: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 10.0),
            child: IconButton(
              icon: const Icon(Icons.filter_list),
              onPressed: _showFilterOptions,
            ),
          ),
          const SizedBox(width: 20),
          Center(
            child: Text(
              "${DateFormat('d.M.yyyy').format(widget.cas!.datum)} - ${widget.cas!.razred}",
              style: const TextStyle(fontSize: 26, fontWeight: FontWeight.w400),
            ),

          ),

        ],
      ),
    );
  }

  Widget lekcija(){
    return Padding(
      padding: const EdgeInsets.only(bottom: 24.0),
      child: Text(
        "(${widget.cas!.lekcija})",
        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
      ),
    );
  }
  void _editUcenik(User ucenik) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return EditUcenikDialog(
          ucenik: ucenik,
          filteredListKategorija: filteredListKategorija,
          cas: widget.cas,
        );
      },
    );
  }

  void _showFilterOptions() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return _buildFilterOptions();
      },
    );
  }

  Widget _buildFilterOptions() {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            title: const Text('Sort by Prisustvo'),
            onTap: () {
              sortDataByPrisustvo();
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }

  void sortDataByPrisustvo() {
    setState(() {
      selectedUcenici.sort((a, b) => b.prisustvo!.compareTo(a.prisustvo!));
    });
  }
}


class MultiSelectDialog extends StatefulWidget {
  final List<Ucenik> ucenici;
  final List<Ucenik> selectedUcenici;

  const MultiSelectDialog({Key? key, required this.ucenici, required this.selectedUcenici})
      : super(key: key);

  @override
  _MultiSelectDialogState createState() => _MultiSelectDialogState();
}

class _MultiSelectDialogState extends State<MultiSelectDialog> {
  late List<Ucenik> _tempSelectedUcenici;

  @override
  void initState() {
    super.initState();
    _tempSelectedUcenici = List.from(widget.selectedUcenici);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Odaberi prisutne'),
      content: SingleChildScrollView(
        child: ListBody(
          children: widget.ucenici
              .map((ucenik) => CheckboxListTile(
            title: Text('${ucenik.ime} ${ucenik.prezime}'),
            value: _tempSelectedUcenici.contains(ucenik),
            onChanged: (bool? value) {
              setState(() {
                if (value != null && value) {
                  _tempSelectedUcenici.add(ucenik);
                } else {
                  _tempSelectedUcenici.remove(ucenik);
                }
              });
            },
          ))
              .toList(),
        ),
      ),
      actions: [
        TextButton(
          child: const Text('Cancel'),
          onPressed: () {
            Navigator.of(context).pop(); // Return original selection
          },
        ),
        ElevatedButton(
          child: const Text('Potvrdi'),
          onPressed: () {
            Navigator.of(context).pop(_tempSelectedUcenici);

          },
        ),
      ],
    );
  }
}

class EditUcenikDialog extends StatefulWidget {
  final User ucenik;
  final List<dynamic> filteredListKategorija;
  final Cas? cas;

  const EditUcenikDialog({
    Key? key,
    required this.ucenik,
    required this.filteredListKategorija,
    required this.cas,
  }) : super(key: key);

  @override
  _EditUcenikDialogState createState() => _EditUcenikDialogState();
}

class _EditUcenikDialogState extends State<EditUcenikDialog> {
  String? selectedKategorija;
  final TextEditingController lekcijaKontroler = TextEditingController();
  final TextEditingController zadacaKontroler = TextEditingController();
  bool isLoading = false;

  // Initialize ZadacaProvider
  late ZadacaProvider _zadacaProvider;

  @override
  void initState() {
    super.initState();
    _zadacaProvider = ZadacaProvider(); // Initialize provider
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Padding(
        padding: const EdgeInsets.only(left: 45.0),
        child: Text('${widget.ucenik.ime} ${widget.ucenik.prezime}'),
      ),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Lekcija: ${widget.cas?.lekcija}', style: const TextStyle(fontSize: 16),),
            const SizedBox(height: 16),
            DropdownButtonFormField<String>(
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Ocjena',
              ),
              hint: const Text('Odaberite ocjenu'),
              value: selectedKategorija,
              onChanged: (newValue) {
                setState(() {
                  selectedKategorija = newValue;
                });
              },
              items: widget.filteredListKategorija
                  .map<DropdownMenuItem<String>>((kategorija) {
                return DropdownMenuItem<String>(
                  value: kategorija.id.toString(),
                  child: Text('${kategorija.ocjena}'),
                );
              }).toList(),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Odaberite ocjenu';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            TextField(
              controller: lekcijaKontroler,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Lekcija',
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: zadacaKontroler,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Zadaća',
              ),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Cancel'),
        ),
        isLoading
            ? const CircularProgressIndicator()
            : ElevatedButton(
          onPressed: () async {
            await _saveData();
          },
          child: const Text('Spasi'),
        ),
      ],
    );
  }

  Future<void> _saveData() async {
    setState(() {
      isLoading = true;
    });

    bool success = await _zadacaProvider.insert(
      DateTime.now(),
      lekcijaKontroler.text,
      widget.ucenik.id,
      int.tryParse(selectedKategorija ?? ''),
      widget.ucenik.idRazreda,
      zadacaKontroler.text
    );

    setState(() {
      isLoading = false;
    });

    if (success) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Zadaća i ocjena uspješno spašene!')),
      );
      Navigator.of(context).pop();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Greška pri spremanju!')),
      );
    }
  }
}

