import 'package:emekteb_mobile/Widgets/master_screen.dart';
import 'package:emekteb_mobile/models/mekteb.dart';
import 'package:emekteb_mobile/providers/ucenici_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/searches/search_result.dart';
import '../models/ucenik.dart';
import '../providers/mekteb_provider.dart';
import '../providers/razred_provider.dart';
import '../providers/user_provider.dart';

class UceniciIINivo extends StatefulWidget {
  const UceniciIINivo({super.key});

  @override
  State<UceniciIINivo> createState() => _UceniciIINivoState();
}

class _UceniciIINivoState extends State<UceniciIINivo> {
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
    await fetchDataRazredi();
  }

  Future<void> fetchDataRazredi() async {
    if (!isLoading2) {
      setState(() {
        isLoading2 = true;
        // Clear existing data when the filter changes
        listaNivo = null;
        filteredListNivo.clear();
      });

      var data = await _nivoProvider.getById2(_userProvider.user?.mektebId);

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
      filteredList = listaUcenika?.result.where((ucenik) => ucenik.nazivRazreda == "II nivo").toList() ?? [];
      ukupnoUcenika = filteredList.length; // Update the count to reflect filtered data
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MasterScreen(
      title: "Učenici - II nivo",
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
            icon: Icon(Icons.filter_list),
            onPressed: _showFilterOptions,
          ),
          _buildSearchField(), // Add the search field here
          Spacer(),
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
          style: TextStyle(fontSize: 14), // Smaller font size
          decoration: InputDecoration(
            hintText: "...",
            isDense: true, // Reduces the height
            contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 16), // Custom padding
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10), // Rounded corners if desired
            ),
            prefixIcon: Icon(Icons.search, size: 20), // Smaller icon size
          ),
        ),
      ),
    );
  }


  Widget _buildTable() {
    return isLoading
        ? Center(child: CircularProgressIndicator())
        : listaUcenika == null
        ? Center(child: Text('No data available'))
        : SingleChildScrollView(
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: DataTable(
          columns: [
            DataColumn(label: Text('Ime i prezime')),
            DataColumn(label: Text('Prisustvo')),
            DataColumn(label: Text('Detalji')),
          ],
          rows: filteredList.map((ucenik) {
            return DataRow(
              cells: [
                DataCell(Text('${ucenik.ime} ${ucenik.prezime}')),
                DataCell(Text('${ucenik.prisustvo!.toStringAsFixed(0)}%')),
                DataCell(
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton(
                        icon: Icon(Icons.edit),
                        onPressed: () {
                          _editUcenik(context, ucenik);
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.more_vert),
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
            title: Text('Sort by Prisustvo'),
            onTap: () {
              sortDataByPrisustvo();
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: Text('Sort by Prosjek'),
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
              Text('Prisustvo: ${ucenik.prisustvo != null ? ucenik.prisustvo!.toStringAsFixed(0) + "%" : "N/A"}'),
              Text('Prosjek: ${ucenik.prosjek != null ? ucenik.prosjek!.toStringAsFixed(2) : "N/A"}'),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Close'),
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
    final _imeController = TextEditingController(text: ucenik.ime);
    final _prezimeController = TextEditingController(text: ucenik.prezime);
    final _usernameController = TextEditingController(text: ucenik.username);
    final _imeRoditeljaController = TextEditingController(text: ucenik.imeRoditelja);
    final _brojTelefonaController = TextEditingController(text: ucenik.telefon);
    final _mailController = TextEditingController(text: ucenik.mail);
    final _statusController = TextEditingController(text: ucenik.status);
    int? nivoId = ucenik.idRazreda;
    String? nivo = ucenik.nazivRazreda;
    final _datumRodjenjaController = TextEditingController(
      text: ucenik.datumRodjenja?.toLocal().toString().split(' ')[0] ?? "",
    );
    String? selectedSpol = ucenik.spol;
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Uredi učenika'),
          content: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                    controller: _imeController,
                    decoration: InputDecoration(labelText: 'Ime:'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Unesite ime';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _prezimeController,
                    decoration: InputDecoration(labelText: 'Prezime:'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Unesite prezime';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _usernameController,
                    decoration: InputDecoration(labelText: 'Korisničko ime:'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Unesite korisničko ime';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _imeRoditeljaController,
                    decoration: InputDecoration(labelText: 'Ime roditelja:'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Unesite ime roditelja';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _statusController,
                    decoration: InputDecoration(labelText: 'Status:'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Unesite status';
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
                  TextFormField(
                    controller: _datumRodjenjaController,
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
                        _datumRodjenjaController.text = picked.toLocal().toString().split(' ')[0];
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
                  DropdownButtonFormField<String>(
                    decoration: InputDecoration(
                      border: InputBorder.none,
                    ),
                    hint: Text(ucenik.nazivRazreda.toString()),
                    value: filteredListNivo.any((item) => item.id.toString() == nivo) ? nivo : null, // Set value if it exists in the list
                    onChanged: (newValue) {
                      setState(() {
                        nivo = newValue;
                        nivoId = filteredListNivo.firstWhere((item) => item.id.toString() == newValue).id;

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
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Spasi'),
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  // Perform the save operation
                  // Call your provider method here to save the updated ucenik
                  bool result = await _uceniciProvider.update(
                    ucenik.id,  // Assuming ucenik has an id property
                    _imeController.text,
                    _prezimeController.text,
                    _usernameController.text,
                    _brojTelefonaController.text,
                    _mailController.text,
                    selectedSpol!,
                    _statusController.text,
                    DateTime.parse(_datumRodjenjaController.text),
                    _imeRoditeljaController.text,
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