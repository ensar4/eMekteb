import 'package:emekteb_mobile/Widgets/master_screen.dart';
import 'package:emekteb_mobile/providers/ucenici_provider.dart';
import 'package:emekteb_mobile/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/searches/search_result.dart';
import '../models/ucenik.dart';
import '../providers/razred_provider.dart';


class Ucenici extends StatefulWidget {
  const Ucenici({super.key});

  @override
  State<Ucenici> createState() => _ProfilInfoState();
}

class _ProfilInfoState extends State<Ucenici> {
  late UceniciProvider _uceniciProvider;
  late UserProvider _userProvider;
  late RazredProvider _nivoProvider;

  final _formKey = GlobalKey<FormState>();
  SearchResult<Ucenik>? listaUcenika;
  List<Ucenik> filteredList = [];
  bool isLoading = false;
  int ukupnoUcenika = 0;
  TextEditingController searchController = TextEditingController();
  bool isLoading2 = false;
  int ukupno2 = 1;
  List<dynamic> filteredListNivo = [];
  dynamic listaNivo;


  @override
  Future<void> didChangeDependencies() async {
    super.didChangeDependencies();
    _uceniciProvider = context.read<UceniciProvider>();
    _userProvider = context.read<UserProvider>();
    _nivoProvider = context.read<RazredProvider>();
    await fetchData();
    await fetchDataKategorije();
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

  Future<void> fetchData() async {
    setState(() {
      isLoading = true;
    });

    var data = await _uceniciProvider.getById2(_userProvider.user!.mektebId);

    setState(() {
      listaUcenika = data;
      filteredList = listaUcenika?.result ?? [];
      ukupnoUcenika = data.count;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MasterScreen(
      title: "Svi učenici",
      child: Column(
        children: [
          _buildAppBar(),
          Expanded(child: _buildTable()),
        ],
      ),
    );
  }

  Widget _buildAppBar() {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 16),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: _showFilterOptions,
          ),
          _buildSearchField(), // Add the search field here
          const Spacer(),
          Text(
            "Ukupno: $ukupnoUcenika",
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
          ),
        ],
      ),
    );
  }
  Widget _buildSearchField() {
    return Expanded(
      child: Container(
        height: 40,
        child: TextField(
          controller: searchController,
          onChanged: searchByName,
          style: const TextStyle(fontSize: 14), // Smaller font size
          decoration: InputDecoration(
            hintText: "...",
            isDense: true, // Reduces the height
            contentPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16), // Custom padding
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10), // Rounded corners if desired
            ),
            prefixIcon: const Icon(Icons.search, size: 20), // Smaller icon size
          ),
        ),
      ),
    );
  }


  Widget _buildTable() {
    return isLoading
        ? const Center(child: CircularProgressIndicator())
        : listaUcenika == null
        ? const Center(child: Text('No data available'))
        : SingleChildScrollView(
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: DataTable(
          columns: const [
            DataColumn(label: Text('Ime i prezime')),
            DataColumn(label: Text('Prisustvo')),
            DataColumn(label: Text('Detalji')),
          ],
          rows: filteredList.map((ucenik) {
            return DataRow(
              cells: [
                DataCell(Text('${ucenik.ime} ${ucenik.prezime}')),
                DataCell(Text('${ucenik.prisustvo!.toStringAsFixed(1)}%')),
                DataCell(
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit),
                        onPressed: () {
                          _editUcenik(context, ucenik);
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.more_vert),
                        onPressed: () {
                          showUcenikDetails(context, ucenik);
                        },
                      ),
                    ],
                  ),
                ),
              ],
            );
          }).toList(),
        ),
      ),
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
          ListTile(
            title: const Text('Sort by Prosjek'),
            onTap: () {
              sortDataByProsjek();
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }

  void sortDataByPrisustvo() {
    setState(() {
      filteredList.sort((a, b) => b.prisustvo!.compareTo(a.prisustvo!));
    });
  }

  void sortDataByProsjek() {
    setState(() {
      filteredList.sort((a, b) => b.prosjek!.compareTo(a.prosjek!));
    });
  }

  void filterByNivo(String nivo) {
    setState(() {
      filteredList = listaUcenika?.result.where((item) => item.nazivRazreda == nivo).toList() ?? [];
    });
  }

  void searchByName(String query) {
    setState(() {
      if (query.isEmpty) {
        filteredList = listaUcenika?.result ?? [];
      } else {
        filteredList = listaUcenika?.result
            .where((ucenik) =>
        (ucenik.ime != null && ucenik.ime!.toLowerCase().contains(query.toLowerCase())) ||
            (ucenik.prezime != null && ucenik.prezime!.toLowerCase().contains(query.toLowerCase())))
            .toList() ??
            [];
      }
    });
  }

  void showUcenikDetails(BuildContext context, Ucenik ucenik) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('${ucenik.ime} ${ucenik.prezime}'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Telefon: ${ucenik.telefon ?? "N/A"}'),
              Text('Datum rođenja: ${ucenik.datumRodjenja != null ? ucenik.datumRodjenja!.toLocal().toString().split(' ')[0] : "N/A"}'),
              Text('Ime roditelja: ${ucenik.imeRoditelja ?? "N/A"}'),
              Text('Naziv razreda: ${ucenik.nazivRazreda ?? "N/A"}'),
              Text('Prisustvo: ${ucenik.prisustvo != null ? "${ucenik.prisustvo!.toStringAsFixed(1)}%" : "N/A"}'),
              Text('Prosjek: ${ucenik.prosjek != null ? ucenik.prosjek!.toStringAsFixed(2) : "N/A"}'),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Close'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _editUcenik(BuildContext context, Ucenik ucenik) {
    final imeController = TextEditingController(text: ucenik.ime);
    final prezimeController = TextEditingController(text: ucenik.prezime);
    final usernameController = TextEditingController(text: ucenik.username);
    final imeRoditeljaController = TextEditingController(text: ucenik.imeRoditelja);
    final brojTelefonaController = TextEditingController(text: ucenik.telefon);
    final mailController = TextEditingController(text: ucenik.mail);
    final statusController = TextEditingController(text: ucenik.status);
    int? nivoId = 1;
    String? nivo = ucenik.nazivRazreda;
    final datumRodjenjaController = TextEditingController(
      text: ucenik.datumRodjenja?.toLocal().toString().split(' ')[0] ?? "",
    );
    String? selectedSpol = ucenik.spol;
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Uredi učenika'),
          content: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                    controller: imeController,
                    decoration: const InputDecoration(labelText: 'Ime:'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Unesite ime';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: prezimeController,
                    decoration: const InputDecoration(labelText: 'Prezime:'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Unesite prezime';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: usernameController,
                    decoration: const InputDecoration(labelText: 'Korisničko ime:'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Unesite korisničko ime';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: imeRoditeljaController,
                    decoration: const InputDecoration(labelText: 'Ime roditelja:'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Unesite ime roditelja';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: statusController,
                    decoration: const InputDecoration(labelText: 'Status:'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Unesite status';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: brojTelefonaController,
                    decoration: const InputDecoration(labelText: 'Broj telefona:'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Unesite broj telefona';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: mailController,
                    decoration: const InputDecoration(labelText: 'Mail:'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Unesite mail';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: datumRodjenjaController,
                    decoration: const InputDecoration(labelText: 'Datum rođenja:'),
                    onTap: () async {
                      FocusScope.of(context).requestFocus(FocusNode());
                      DateTime? picked = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(1900),
                        lastDate: DateTime(2100),
                      );
                      if (picked != null) {
                        datumRodjenjaController.text = picked.toLocal().toString().split(' ')[0];
                      }
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Unesite datum rođenja';
                      }
                      return null;
                    },
                  ),
                  DropdownButtonFormField<String>(
                    decoration: const InputDecoration(labelText: 'Spol'),
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
                  DropdownButtonFormField<String>(
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                    ),
                    hint: Text(ucenik.nazivRazreda.toString()),
                    value: filteredListNivo.any((item) => item.id.toString() == nivo) ? nivo : null, // Set value if it exists in the list
                    onChanged: (newValue) {
                      setState(() {
                        nivo = newValue;
                        nivoId = filteredListNivo.firstWhere((item) => item.id.toString() == newValue).id; // Update nivoId based on selected value
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
                  // Add more fields as needed...
                ],
              ),
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Spasi'),
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  // Perform the save operation
                  // Call your provider method here to save the updated ucenik
                  bool result = await _uceniciProvider.update(
                    ucenik.id,  // Assuming ucenik has an id property
                    imeController.text,
                    prezimeController.text,
                    usernameController.text,
                    brojTelefonaController.text,
                    mailController.text,
                    selectedSpol!,
                    statusController.text,
                    DateTime.parse(datumRodjenjaController.text),
                    imeRoditeljaController.text,
                    _userProvider.user?.mektebId,
                    nivoId!,
                  );

                  if (result) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Učenik uspješno ažuriran')),
                    );
                    Navigator.of(context).pop();
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Greška pri ažuriranju učenika')),
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

}