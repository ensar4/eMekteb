import 'package:emekteb_admin/Widgets/master_screen.dart';
import 'package:emekteb_admin/models/mualim.dart';
import 'package:emekteb_admin/providers/mualim_provider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../models/mekteb.dart';
import '../models/searches/search_result.dart';
import '../models/ucenik.dart';
import '../providers/ucenici_provider.dart';
import 'mektebii_screen.dart';

import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

void main() {
  runApp(const MektebDetalji(
    mekteb: null,
  ));
}

class MektebDetalji extends StatefulWidget {
  final Mekteb? mekteb;
  const MektebDetalji({super.key, this.mekteb});


  @override
  State<MektebDetalji> createState() => _MektebDetaljiState();
}

class _MektebDetaljiState extends State<MektebDetalji> {
  late MualimProvider _mualimProvider;
  SearchResult<Mualim>? listaMualima;
  List<Mualim> filteredListMualims = [];
  int ukupnoMualima = 1;

  late UceniciProvider _uceniciProvider;
  String dropdownValue = 'Prosjek';
  String dropdownValue2 = 'Prisustvo';
  String dropdownValue3 = 'Nivo';
  SearchResult<Ucenik>? listaUcenika;
  List<Ucenik> filteredList = [];
  TextEditingController searchController = TextEditingController();
  int currentPage = 1; // Track the current page
  int numPages = 12; // Adjust the page size according to your backend configuration
  bool isLoading = false;
  bool isLoading2 = false;
  int ukupnoUcenika = 1;
  bool isSortAsc = false;


  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _uceniciProvider = context.read<UceniciProvider>();
    _mualimProvider = context.read<MualimProvider>();
    fetchDataMualims();
    fetchDataUcenici();
  }




  Future<void> fetchDataMualims({String? filter}) async {
    if (!isLoading) {
      setState(() {
        isLoading = true;
        // Clear existing data when the filter changes
        listaMualima = null;
        filteredListMualims.clear();
      });

      var data = await _mualimProvider.getById2(widget.mekteb?.id);

      setState(() {
        if (listaMualima == null) {
          listaMualima = data;
          ukupnoMualima = data.count;
        } else {
          listaMualima!.result.addAll(data.result);
        }
        filteredListMualims = listaMualima?.result ?? [];
        //print(filteredList.isNotEmpty ? filteredList[0].naziv : 'No data');
        isLoading = false;
      });
    }
  }

  Future<void> fetchDataUcenici({String? filter}) async {
    if (!isLoading2) {
      setState(() {
        isLoading2 = true;
        // Clear existing data when the filter changes
        listaUcenika = null;
        filteredList.clear();
      });

      var data = await _uceniciProvider.getById2(widget.mekteb?.id);

      setState(() {
        if (listaUcenika == null) {
          listaUcenika = data;
          ukupnoUcenika = data.count;
        } else {
          listaUcenika!.result.addAll(data.result);
        }

        filteredList = listaUcenika?.result ?? [];
        isLoading2 = false;
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    return MasterScreen(
      title: "${widget.mekteb?.naziv}",
      child: SingleChildScrollView(
        child: Column(
          children: [
            _rutaDugme(),
            _mualimiBox(),
            _filteri(),
            Padding(
              padding: const EdgeInsets.only(left: 30.0, right: 30, bottom: 30),
              child: _tabela(),
            ),
          ],
        ),
      ),
    );
  }
  Widget _rutaDugme() {
    return Padding(
      padding: const EdgeInsets.all(30.0),
      child: Row(
        children: [
          BackButton(
            onPressed: () {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) => const Mektebi(),
                ),
              );
            },
          ),
          const SizedBox(width: 20),
          GestureDetector(
            child: const Text(
              "Mektebi",
              style: TextStyle(fontSize: 16),
            ),
            onTap: () {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) => const Mektebi(),
                ),
              );
            },
          ),
          const SizedBox(width: 10), // Adjusted spacing
          Text(
            "/ ${widget.mekteb?.naziv}",
            style: const TextStyle(fontSize: 16),
          ),
          const Spacer(), // Creates space between breadcrumb and buttons
          ElevatedButton(
            onPressed: () => _showCreateForm(context, _mualimProvider),
            style: ElevatedButton.styleFrom(
              shape: const RoundedRectangleBorder(),
              padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 18.0),
            ),
            child: const Row(
              children: [
                Icon(Icons.add),
                SizedBox(width: 10),
                Text(
                  "MUALLIM",
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
          ),
          const SizedBox(width: 20),
          ElevatedButton(
            onPressed: () {
              _createPdfReport(context, filteredList, widget.mekteb?.naziv as String, filteredListMualims);
            },
            style: ElevatedButton.styleFrom(
              shape: const RoundedRectangleBorder(),
              padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 18.0),
            ),
            child: const Row(
              children: [
                Icon(Icons.download),
                SizedBox(width: 10),
                Text(
                  "IZVJEŠTAJ",
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
  Widget _mualimiBox() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30.0),
      child: Container(
        color: Colors.blueGrey[100],
        height: 150,
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.all(20.0),
              child: Text(
                "Muallimi",
                style: TextStyle(fontSize: 22),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child: ListView.builder(
                  itemCount: filteredListMualims.length,
                  itemBuilder: (context, index) {
                    return Text(
                      "• ${filteredListMualims[index].ime} ${filteredListMualims[index].prezime}",
                      style: const TextStyle(fontSize: 20),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }


  Widget _filteri(){
    return Padding(
        padding: const EdgeInsets.all(30),
        child: Row(
          children: [
            btnORderByProsjek(),
            const SizedBox(
              width: 15,
            ),
            btnOrderByPrisustvo(),
            const SizedBox(
              width: 15,
            ),
            GetByNivo(),
            const SizedBox(
              width: 15,
            ),
            SearchByName(),
          ],
        )
    );
  }

  Widget btnORderByProsjek() {
    return Container(
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
        underline: Container(), //za brisanje underline na butotnu
        onChanged: (String? value) {
          // This is called when the user selects an item.
          setState(() {
            dropdownValue = value!;
            sortDataByProsjek(dropdownValue);
          });
        },
        items: ['Prosjek', 'Manje - Veće', 'Veće - Manje']
            .map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
      ),
    );
  }

  Widget btnOrderByPrisustvo() {
    return Container(
      //-------button2
      padding: const EdgeInsets.symmetric(horizontal: 12),
      height: 36,
      decoration: BoxDecoration(
        color: Colors.blueGrey[50],
        border: Border.all(color: Colors.black),
        borderRadius: const BorderRadius.all(Radius.circular(4.0)),
      ),
      child: DropdownButton<String>(
        value: dropdownValue2,
        icon: const Icon(Icons.arrow_drop_down),
        elevation: 16,
        style: const TextStyle(color: Colors.black),
        underline: Container(),
        onChanged: (String? value) {
          // This is called when the user selects an item.
          setState(() {
            dropdownValue2 = value!;
            sortDataByPrisustvo(dropdownValue2);
          });
        },
        items: ['Prisustvo', 'Veće - Manje','Manje - Veće']
            .map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
      ),
    );
  }

  Widget GetByNivo() {
    return Container(
      //-------button2
      padding: const EdgeInsets.symmetric(horizontal: 12),
      height: 36,
      decoration: BoxDecoration(
        color: Colors.blueGrey[50],
        border: Border.all(color: Colors.black),
        borderRadius: const BorderRadius.all(Radius.circular(4.0)),
      ),
      child: DropdownButton<String>(
        value: dropdownValue3,
        icon: const Icon(Icons.arrow_drop_down),
        elevation: 16,
        style: const TextStyle(color: Colors.black),
        underline: Container(),
        onChanged: (String? value) {
          setState(() {
            dropdownValue3 = value!;
            filterByNivo(dropdownValue3);
          });
        },
        items: ['Nivo', 'Prvi', 'Drugi', 'Treći', 'Sufara']
            .map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
      ),
    );
  }

  Widget SearchByName(){
    return Container(
      width: 250,
      child: TextField(
        controller: searchController,
        onChanged: (value) {
          searchByName(value);
        },
        decoration: const InputDecoration(
          hintText: "Pretraga",
          isDense: true, // Visina fielda
          contentPadding:
          EdgeInsets.only(left: 20, right: 20), // Visina fielda
          border: OutlineInputBorder(),
          prefixIcon: Align(
            widthFactor: 1.0,
            heightFactor: 1.0,
            child: Icon(
              Icons.search,
            ),
          ),
        ),
      ),
    );
  }

  Widget _tabela() {
    return isLoading
        ? const Center(child: CircularProgressIndicator())
        : listaUcenika == null
        ? const Center(child: Text('No data available'))
        : SingleChildScrollView(
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Container(
          width: MediaQuery.of(context).size.width,
          child: DataTable(
            dataTextStyle: const TextStyle(fontSize: 16),
            columns: const [
              DataColumn(
                label: Text('Ime'),
              ),
              DataColumn(label: Text('Prezime')),
              DataColumn(label: Text('Nivo')),
              DataColumn(label: Text('Prosjek')),
              DataColumn(label: Text('Prisustvo')),
            ],
            rows: filteredList.map<DataRow>((item) {
              return DataRow(
                cells: [
                  DataCell(Text(item.ime.toString())),
                  DataCell(Text(item.prezime.toString())),
                  DataCell(Text(item.nazivRazreda.toString())),
                  DataCell(Text(item.prosjek?.toStringAsFixed(1) ?? '0.00')),
                  DataCell(Text('${item.prisustvo?.toStringAsFixed(0) ?? '0.00'}%')),
                ],
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
  void sortDataByPrisustvo(String sortBy) {
    setState(() {
      if (sortBy == 'Prisustvo') {
        filteredList.sort((a, b) => a.prisustvo!.compareTo(b.prisustvo!));
      } else if (sortBy == 'Manje - Veće') {
        filteredList.sort((a, b) => a.prisustvo!.compareTo(b.prisustvo!));
      } else if (sortBy == 'Veće - Manje') {
        filteredList.sort((a, b) => b.prisustvo!.compareTo(a.prisustvo!));
      }
    });
  }

  void sortDataByProsjek(String sortBy) {
    setState(() {
      if (sortBy == 'Prosjek') {
        filteredList.sort((a, b) => a.prosjek!.compareTo(b.prosjek!));
      } else if (sortBy == 'Manje - Veće') {
        filteredList.sort((a, b) => a.prosjek!.compareTo(b.prosjek!));
      } else if (sortBy == 'Veće - Manje') {
        filteredList.sort((a, b) => b.prosjek!.compareTo(a.prosjek!));
      }
    });
  }

  void searchByName(String query) {
    setState(() {
      if (query.isEmpty) {
        filteredList = listaUcenika?.result ?? [];
      } else {
        filteredList = listaUcenika?.result
            .where((ucenik) => (ucenik.ime != null && ucenik.ime!.toLowerCase().contains(query.toLowerCase())) ||
            (ucenik.prezime != null && ucenik.prezime!.toLowerCase().contains(query.toLowerCase())))
            .toList() ??
            [];
      }
    });
  }


  void filterByNivo(String nivo) {
    setState(() {
      if (nivo == 'Nivo') {
        filteredList = listaUcenika?.result ?? [];
      } else {
        filteredList = listaUcenika?.result.where((item) => item.nazivRazreda == nivo).toList() ?? [];
      }
    });
  }

  void _showCreateForm(BuildContext context, MualimProvider provider) {
    final formKey = GlobalKey<FormState>();
    String ime = '';
    String prezime = '';
    String username = '';
    String telefon = '';
    String mail = '';
    String spol = 'M';
    String status = 'Aktivan';
    DateTime datumRodjenja = DateTime.now();
    String imeRoditelja = '';
    String password = '';
    String passwordPotvrda = '';
    int? mektebId = widget.mekteb?.id;

    final TextEditingController datumRodjenjaController = TextEditingController();

    // Initializing the text fields with the current date values
    datumRodjenjaController.text = datumRodjenja.toLocal().toString().split(' ')[0];

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Dodaj mualima'),
          content: SizedBox(
            width: MediaQuery.of(context).size.width * 0.2, // Set the width to 80% of the screen width
            child: SingleChildScrollView(
              child: Form(
                key: formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextFormField(
                      decoration: const InputDecoration(labelText: 'Ime'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Unesite ime mualima';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        ime = value!;
                      },
                    ),
                    TextFormField(
                      decoration: const InputDecoration(labelText: 'Prezime'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Unesite prezime mualima';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        prezime = value!;
                      },
                    ),
                    TextFormField(
                      decoration: const InputDecoration(labelText: 'Korisničko ime'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Unesite korisničko ime za mualima';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        username = value!;
                      },
                    ),
                    TextFormField(
                      decoration: const InputDecoration(labelText: 'Telefon'),
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Unesite telefon';
                        } else if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
                          return 'Neispravan format, unesite samo brojeve!';
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
                          return 'Unesite mail mualima';
                        } else if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
                          return 'Neispravan format maila!';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        mail = value!;
                      },
                    ),
                    DropdownButtonFormField<String>(
                      decoration: const InputDecoration(labelText: 'Spol'),
                      value: spol,
                      items: ['M', 'Ž'].map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      onChanged: (newValue) {
                        spol = newValue!;
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Unesite spol';
                        }
                        return null;
                      },
                    ),
                    DropdownButtonFormField<String>(
                      decoration: const InputDecoration(labelText: 'Status'),
                      value: status,
                      items: ['Aktivan', 'Neaktivan'].map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      onChanged: (newValue) {
                        status = newValue!;
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Unesite status mualima';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: datumRodjenjaController,
                      decoration: const InputDecoration(labelText: 'Datum rođenja'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Unesite datum rođenja mualima';
                        }
                        return null;
                      },
                      onTap: () async {
                        FocusScope.of(context).requestFocus(FocusNode());
                        DateTime? picked = await showDatePicker(
                          context: context,
                          initialDate: datumRodjenja,
                          firstDate: DateTime(1900),
                          lastDate: DateTime(2101),
                        );
                        if (picked != null && picked != datumRodjenja) {
                          setState(() {
                            datumRodjenja = picked;
                            datumRodjenjaController.text = datumRodjenja.toLocal().toString().split(' ')[0];
                          });
                        }
                      },
                    ),
                    TextFormField(
                      decoration: const InputDecoration(labelText: 'Ime roditelja'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Unesite ime jednog roditelja';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        imeRoditelja = value!;
                      },
                    ),
                    TextFormField(
                      decoration: const InputDecoration(labelText: 'Password'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Unesite password za mualima';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        password = value!;
                      },
                    ),
                    TextFormField(
                      decoration: const InputDecoration(labelText: 'Potvrda passworda'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Potvrdite password';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        passwordPotvrda = value!;
                      },
                    ),
                  ],
                ),
              ),
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
                  bool result = await provider.insert(
                    ime,
                    prezime,
                    username,
                    telefon,
                    mail,
                    spol,
                    status,
                    datumRodjenja,
                    imeRoditelja,
                    mektebId!,
                    password,
                    passwordPotvrda,
                  );
                  if (result) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Mualim uspješno dodan')),
                    );
                    fetchDataMualims();
                    Navigator.of(context).pop();
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Greška pri dodavanju mualima')),
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

  void _createPdfReport(BuildContext context, List<Ucenik> filteredList, String naziv, List<Mualim>fiteredListMualim) async {
    final pdf = pw.Document();
    String now = DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now());
    pdf.addPage(
      pw.Page(
          build: (pw.Context context) => pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Text(
                "$naziv ",
                style: pw.TextStyle(fontSize: 22, fontWeight: pw.FontWeight.bold),
              ),
              pw.SizedBox(height: 20),
               pw.Text(
                   "Mualim: ${fiteredListMualim[0].ime} ${fiteredListMualim[0].prezime}",
                   style: const pw.TextStyle(fontSize: 18),
             ),
              pw.SizedBox(height: 20),
              pw.TableHelper.fromTextArray(
                data: <List<String>>[
                  <String>[
                    'Ime',
                    'Ime roditelja',
                    'Prezime',
                    'Datum rodjenja',
                    'Nivo',
                    'Prosjek',
                    'Prisustvo',
                  ],
                  ...filteredList.map(
                        (item) => [
                      item.ime.toString(),
                      "(${item.imeRoditelja.toString()})",
                      item.prezime.toString(),
                      item.datumRodjenja != null ? DateFormat('dd.MM.yyyy').format(item.datumRodjenja!) : 'N/A',
                      item.nazivRazreda.toString(),
                      item.prosjek?.toStringAsFixed(1) ?? '0.00',
                      "${item.prisustvo?.toStringAsFixed(1) ?? '0.00'} %",
                    ],
                  ).toList(),
                ],
              ),
              pw.SizedBox(height: 20),
              pw.Text(
                now,
                style: const pw.TextStyle(fontSize: 14),),
            ],
          )
      ),
    );

    await Printing.layoutPdf(
      onLayout: (PdfPageFormat format) async => pdf.save(),
    );
  }

}
