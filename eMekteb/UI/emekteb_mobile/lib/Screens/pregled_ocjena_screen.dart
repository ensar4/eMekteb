import 'package:emekteb_mobile/Widgets/master_screen.dart';
import 'package:emekteb_mobile/providers/ucenici_provider.dart';
import 'package:emekteb_mobile/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/searches/search_result.dart';
import '../models/ucenik.dart';
import '../providers/razred_provider.dart';
import '../providers/slika_provider.dart';
import 'dart:typed_data';

import '../utils/util.dart'; // Import this if you haven't already

class Ocjene extends StatefulWidget {
  const Ocjene({super.key});

  @override
  State<Ocjene> createState() => _ProfilInfoState();
}

class _ProfilInfoState extends State<Ocjene> {
  late UceniciProvider _uceniciProvider;
  late UserProvider _userProvider;
  late RazredProvider _nivoProvider;
  late SlikaProvider _slikaProvider;

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
  String slikaBytes = '';
  String samoIme = "";
  DateTime datumOd = DateTime.now();
  DateTime datumDo = DateTime.now();
  String naziv = '';
  String minOcjena = '';
  String maxOcjena = '';
  final TextEditingController _datumOdController = TextEditingController();
  final TextEditingController _datumDoController = TextEditingController();
  @override
  Future<void> didChangeDependencies() async {
    super.didChangeDependencies();
    _uceniciProvider = context.read<UceniciProvider>();
    _userProvider = context.read<UserProvider>();
    _nivoProvider = context.read<RazredProvider>();
    _slikaProvider = context.read<SlikaProvider>();
    _datumOdController.text = datumOd.toLocal().toString().split(' ')[0];
    _datumDoController.text = datumDo.toLocal().toString().split(' ')[0];
   // await fetchData();
    //await fetchDataRazredi();
    samoIme = _userProvider.user?.ime.split(" ")[0] ?? "";
  }


  Future<void> fetchDataSlika(int? id) async {
    SearchResult<dynamic> result = await _slikaProvider.getById2(id);
    if (result.result.isNotEmpty) {
      setState(() {
        slikaBytes = result.result[0].slikaBytes;
      });
    }
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

    var data = await _uceniciProvider.getById3(_userProvider.user!.mektebId);

    setState(() {
      listaUcenika = data;
      filteredList = listaUcenika?.result ?? [];
      ukupnoUcenika = data.count;
      isLoading = false;
    });
  }


  Future<void> fetchDataIspit() async {
    if (datumOd == null || datumDo == null) {

      showError('Molimo unesite datume.');
      return;
    }

    setState(() {
      isLoading = true;
    });

    try {
      var data = await _uceniciProvider.getById3(
        _userProvider.user!.mektebId,
        datumOd: datumOd,
        datumDo: datumDo,
        minOcjena: minOcjena.isNotEmpty ? int.tryParse(minOcjena) : null,
        maxOcjena: maxOcjena.isNotEmpty ? int.tryParse(maxOcjena) : null,
      );

      setState(() {
        listaUcenika = data;
        filteredList = listaUcenika?.result ?? [];
        ukupnoUcenika = data.count;
        isLoading = false;
      });
    } catch (e) {
      showError('Došlo je do greške pri dohvaćanju podataka.');
      setState(() {
        isLoading = false;
      });
    }
  }

  void showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MasterScreen(
      title: "Pregled ocjena",
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
      padding: const EdgeInsets.fromLTRB(24, 0, 0, 0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Date Pickers
                _buildDatePickerField(
                  controller: _datumOdController,
                  label: 'Od:',
                  onTap: () async {
                    DateTime? picked = await showDatePicker(
                      context: context,
                      initialDate: datumOd ?? DateTime.now(),
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2101),
                    );
                    if (picked != null) {
                      setState(() {
                        datumOd = picked;
                        _datumOdController.text = datumOd!.toLocal().toString().split(' ')[0];
                      });
                    }
                  },
                ),
                const SizedBox(height: 8),
                _buildDatePickerField(
                  controller: _datumDoController,
                  label: 'Do:',
                  onTap: () async {
                    DateTime? picked = await showDatePicker(
                      context: context,
                      initialDate: datumDo ?? DateTime.now(),
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2101),
                    );
                    if (picked != null) {
                      setState(() {
                        datumDo = picked;
                        _datumDoController.text = datumDo!.toLocal().toString().split(' ')[0];
                      });
                    }
                  },
                ),
                Container(
                  height: 40, // Set the height of the dropdown
                  child: DropdownButtonFormField<String>(
                    value: minOcjena.isNotEmpty ? minOcjena : null,
                    onChanged: (String? newValue) {
                      setState(() {
                        minOcjena = newValue ?? '';
                      });
                    },
                    items: ['1', '2', '3', '4', '5']
                        .map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    decoration: InputDecoration(
                      labelText: 'Min Ocjena',
                      border: OutlineInputBorder(),
                      contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 12),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Min Ocjena je obavezna';
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(height: 8),
                Container(
                  height: 40, // Set the height of the dropdown
                  child: DropdownButtonFormField<String>(
                    value: maxOcjena.isNotEmpty ? maxOcjena : null,
                    onChanged: (String? newValue) {
                      setState(() {
                        maxOcjena = newValue ?? '';
                      });
                    },
                    items: ['1', '2', '3', '4', '5']
                        .map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    decoration: InputDecoration(
                      labelText: 'Max Ocjena',
                      border: OutlineInputBorder(),
                      contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 12),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Max Ocjena je obavezna';
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(height: 16),
                _buildSearchButton(),
              ],
            ),
          ),
          const SizedBox(width: 16),
        ],
      ),
    );
  }

  Widget _buildDatePickerField({required TextEditingController controller, required String label, required VoidCallback onTap}) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(labelText: label),
      onTap: onTap,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Unesite datum';
        }
        return null;
      },
    );
  }

  Widget _buildTextField(String label, Function(String?) onSaved) {
    return TextFormField(
      decoration: InputDecoration(labelText: label),
      textCapitalization: TextCapitalization.sentences,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Unesite ocjenu';
        }
        return null;
      },
      onSaved: (value) {
        onSaved(value);
      },
    );
  }

  Widget _buildSearchButton() {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Color(0xFF8D88D0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
      ),
      onPressed: () {
          fetchDataIspit();

      },
      child: const Text(
        'Trazi',
        style: TextStyle(fontSize: 18, color: Colors.white),
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
    final screenWidth = MediaQuery.of(context).size.width;
    return isLoading
        ? const Center(child: CircularProgressIndicator())
        : listaUcenika == null
        ? const Center(child: Text('No data available'))
        : SingleChildScrollView(
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: DataTable(
          columnSpacing: screenWidth*0.09,
          columns: const [
            DataColumn(label: Text('Polaznik')),
            DataColumn(label: Text('Ocjena')),
            DataColumn(label: Text('Imam')),
            DataColumn(label: Text('Prosjek')),
          ],
          rows: filteredList.map((ucenik) {
            return DataRow(
              cells: [
                DataCell(Text('${ucenik.ime} ${ucenik.prezime}')),
                DataCell(Text(ucenik.ocjena?.toStringAsFixed(1) ?? '0.00')),
                DataCell(Text(samoIme)),
                DataCell(Text(ucenik.prosjek?.toStringAsFixed(1) ?? '0.00')),
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
  void showUcenikDetails(BuildContext context, Ucenik ucenik) async {
    // Fetch the image data before showing the dialog
    await fetchDataSlika(ucenik.id);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            '${ucenik.ime} ${ucenik.prezime}',
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Show the circular image container at the top with a fallback image if slikaBytes is empty
              Center(
                child: Container(
                  width: 70,
                  height: 70,
                  decoration: BoxDecoration(
                    color: Colors.white, // Background color
                    shape: BoxShape.circle, // Makes the container circular
                    image: DecorationImage(
                      image: slikaBytes.isNotEmpty
                          ? imageFromBase64String(slikaBytes) // Decode base64 image if available
                          : AssetImage("assets/images/profilnaB.png") as ImageProvider, // Fallback image from assets
                      fit: BoxFit.cover, // Fit image within the circle
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10), // Add some spacing below the image
              _buildDetailRow('Telefon', ucenik.telefon ?? "N/A"),
              _buildDetailRow('Datum rođenja',
                  ucenik.datumRodjenja != null
                      ? ucenik.datumRodjenja!.toLocal().toString().split(' ')[0]
                      : "N/A"
              ),
              _buildDetailRow('Ime roditelja', ucenik.imeRoditelja ?? "N/A"),
              _buildDetailRow('Naziv razreda', ucenik.nazivRazreda ?? "N/A"),
              _buildDetailRow('Prisustvo',
                  ucenik.prisustvo != null
                      ? "${ucenik.prisustvo!.toStringAsFixed(0)}%"
                      : "N/A"
              ),
              _buildDetailRow('Prosjek',
                  ucenik.prosjek != null
                      ? ucenik.prosjek!.toStringAsFixed(2)
                      : "N/A"
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Zatvori'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    ).then((_) {
      // Reset the image after the dialog is closed
      setState(() {
        slikaBytes = ''; // Resetting slikaBytes to an empty value
      });
    });
  }



  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$label: ',
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          Expanded(
            child: Text(value, style: TextStyle(color: Colors.grey.shade600)),
          ),
        ],
      ),
    );
  }

  void _editUcenik(BuildContext context, Ucenik ucenik) {
    final imeController = TextEditingController(text: ucenik.ime);
    final prezimeController = TextEditingController(text: ucenik.prezime);
    final usernameController = TextEditingController(text: ucenik.username);
    final imeRoditeljaController = TextEditingController(text: ucenik.imeRoditelja);
    final brojTelefonaController = TextEditingController(text: ucenik.telefon);
    final mailController = TextEditingController(text: ucenik.mail);
   // final statusController = TextEditingController(text: ucenik.status);
    int? nivoId = ucenik.idRazreda;
    String? nivo = ucenik.nazivRazreda;
    final datumRodjenjaController = TextEditingController(
      text: ucenik.datumRodjenja?.toLocal().toString().split(' ')[0] ?? "",
    );
    String? selectedSpol = ucenik.spol;
    String? selectedStatus = ucenik.status;
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
                  //TextFormField(
                  //  controller: statusController,
                  //  decoration: const InputDecoration(labelText: 'Status:'),
                  //  validator: (value) {
                  //    if (value == null || value.isEmpty) {
                  //      return 'Unesite status';
                  //    }
                  //    return null;
                  //  },
                  //),
                  TextFormField(
                    controller: brojTelefonaController,
                    decoration: const InputDecoration(labelText: 'Broj telefona:'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Unesite broj telefona';
                      }
                      else if (!RegExp(r'^[0-9\s\-/]+$').hasMatch(value)) {
                        return 'Neispravan format!';
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
                      } else if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
                        return 'Neispravan format maila!';
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
              child: const Text('Odustani'),
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
                    selectedStatus!,
                    DateTime.parse(datumRodjenjaController.text),
                    imeRoditeljaController.text,
                    _userProvider.user?.mektebId,
                    nivoId!,
                  );

                  if (result) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Učenik uspješno ažuriran')),
                    );
                    fetchData();
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