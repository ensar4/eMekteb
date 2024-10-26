import 'package:emekteb_admin/Widgets/master_screen.dart';
import 'package:emekteb_admin/models/mekteb.dart';
import 'package:emekteb_admin/providers/ucenici_provider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../models/searches/search_result.dart';
import '../models/ucenik.dart';
import '../providers/mekteb_provider.dart';
import 'mektebii_screen.dart';

import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
void main() {
  runApp(const Ucenici());
}


class Ucenici extends StatefulWidget {
  const Ucenici({super.key});

  @override
  State<Ucenici> createState() => _ProfilInfoState();
}

class _ProfilInfoState extends State<Ucenici> {
  late UceniciProvider _uceniciProvider;
  late MektebProvider _mektebProvider;

  String dropdownValue = 'Prosjek';
  String dropdownValue2 = 'Prisustvo';
  String dropdownValue3 = 'Nivo';

  SearchResult<Ucenik>? listaUcenika;
  SearchResult<Mekteb>? listaMekteba;
  int ukupnoMekteba = 1;
  List<Mekteb> filteredListMektebs = [];
  List<Ucenik> filteredList = [];
  TextEditingController searchController = TextEditingController();
  int currentPage = 1;
  int numPages = 12;
  bool isLoading = false;
  bool isSortAsc = false;
  int ukupnoUcenika = 1;


  @override
  Future<void> didChangeDependencies() async {
    super.didChangeDependencies();
    _uceniciProvider = context.read<UceniciProvider>();
    _mektebProvider = context.read<MektebProvider>();
    await fetchDataMektebs();
    await fetchData();
  }


  Future<void> fetchData({String? filter}) async {
    if (!isLoading) {
      setState(() {
        isLoading = true;
        // Clear existing data when the filter changes
        listaUcenika = null;
        filteredList.clear();
      });

      var data = await _uceniciProvider.get(filterController: searchController, page: currentPage, pageSize: numPages, sort: isSortAsc);

      setState(() {
        if (listaUcenika == null) {
          listaUcenika = data;
          ukupnoUcenika = data.count;
        } else {
          listaUcenika!.result.addAll(data.result);
        }

        filteredList = listaUcenika?.result ?? [];
        isLoading = false;
      });
    }
  }



  Future<void> fetchDataMektebs({String? filter}) async {
    if (!isLoading) {
      setState(() {
        isLoading = true;
        listaMekteba = null;
        filteredList.clear();
      });

      var data = await _mektebProvider.get(filterController: searchController, page: currentPage, pageSize: numPages, sort: isSortAsc);

      setState(() {
        if (listaMekteba == null) {
          listaMekteba = data;
          ukupnoMekteba = data.count;
        } else {
          listaMekteba!.result.addAll(data.result);
        }

        filteredListMektebs = listaMekteba?.result ?? [];
        isLoading = false;
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    return MasterScreen(
      title: "Učenici",
      child: Column(
        children: [
         headerButtons1(),
         buttons2(),
         Expanded(child: tabela()),
         // pageNumbers()
        ],
      ),
    );
  }


  Widget headerButtons1() {
    //breadCrumb i button print
    return Padding(
      //Button for add new and search
      padding: const EdgeInsets.all(30.0),
      child: Row(
        //mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          BackButton(
            onPressed: () {
              Navigator.of(context).pushReplacement(
                //pushReplacement  ili   push
                MaterialPageRoute(
                  builder: (context) => const Mektebi(),
                ),
              );
            },
          ),
          const SizedBox(
            width: 20,
          ),
          const Text(
            "Svi učenici",
            style: TextStyle(fontSize: 16),
          ),
          const Spacer(),

          ElevatedButton(
            onPressed: () {
              _createPdfReport(context, filteredList, ukupnoUcenika.toString());
            },
            style: ElevatedButton.styleFrom(
              shape: const RoundedRectangleBorder(),
              padding: const EdgeInsets.only(
                  left: 18.0, right: 18.0, top: 16.0, bottom: 16.0),
            ),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(Icons.download),
                SizedBox(
                  width: 10,
                ),
                Text(
                  "IZVJEŠTAJ",
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
          )
        ], //Buttons for sort filtering
      ),
    );
  }
  Widget buttons2(){
    return Padding(
      padding: const EdgeInsets.only(left: 30, right: 30, bottom: 30),
      child: Row(
        children: [
          btnORderByProsjek(),
          const SizedBox(
            width: 15,
          ),
          btnOrderByProsjek(),
          const SizedBox(
            width: 15,
          ),
          GetByNivo(),
          const SizedBox(
            width: 15,
          ),
          const SizedBox(
            width: 15,
          ),
          SearchByName(),
          const Spacer(),
          Ukupno(),

        ],
      )
      );
  }




  Widget btnOrderByProsjek() {
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
        items: ['Prisustvo', 'Manje - Veće', 'Veće - Manje']
            .map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
      ),
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
            sortDataByPRosjek(dropdownValue);
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
        items: ['Nivo', 'I nivo', 'II nivo', 'III nivo', 'Sufara', 'Tedžvid', 'Hatma']
            .map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
      ),
    );
  }
  Widget SearchByName() {
    return Container(
      width: 250, // Set a fixed width for the search box
      child: TextField(
        controller: searchController,
        onChanged: (value) {
          searchByName(value); // Perform search when text changes
        },
        decoration: const InputDecoration(
          hintText: "Pretraga",
          isDense: true, // Reduce vertical padding
          contentPadding: EdgeInsets.only(left: 20, right: 20), // Control padding
          border: OutlineInputBorder(), // Standard border for the TextField
          prefixIcon: Align(
            widthFactor: 1.0,
            heightFactor: 1.0,
            child: Icon(
              Icons.search, // Search icon
            ),
          ),
        ),
      ),
    );
  }


  Widget Ukupno(){
    return Text(
      "Ukupno učenika: $ukupnoUcenika",
      style: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w400), //-----UkupnoMekteba
    );
  }

  Widget tabela() {
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


  void sortDataByPRosjek(String sortBy) {
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


void _createPdfReport(BuildContext context, List<Ucenik> filteredList, String ukupno) async {
  final pdf = pw.Document();
  String now = DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now());
  pdf.addPage(
    pw.Page(
        build: (pw.Context context) => pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Text(
              "Svi ucenici",
              style: pw.TextStyle(fontSize: 22, fontWeight: pw.FontWeight.bold),
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