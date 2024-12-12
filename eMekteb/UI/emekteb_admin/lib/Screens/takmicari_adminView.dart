import 'package:emekteb_admin/Widgets/master_screen.dart';
import 'package:emekteb_admin/models/kategorija.dart';
import 'package:emekteb_admin/models/korisnik.dart';
import 'package:emekteb_admin/models/takmicar.dart';
import 'package:emekteb_admin/providers/takmicar_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../models/searches/search_result.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

void main() {
  runApp(const TakmicariAdmin(
    kategorija: null,
  ));
}

class TakmicariAdmin extends StatefulWidget {
  final Kategorija? kategorija;
  const TakmicariAdmin({super.key, this.kategorija});

  @override
  State<TakmicariAdmin> createState() => _TakmicariAdminState();
}

class _TakmicariAdminState extends State<TakmicariAdmin> {
  List<Takmicar> filteredList = [];
  bool isLoading = false;
  SearchResult<Takmicar>? listaTakmicara;
  int ukupnoTakmicara = 1;

  late TakmicarProvider _takmicarProvider;
  Set<int?> ratedItems = {}; // Assuming each item has a unique ID

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _takmicarProvider = context.read<TakmicarProvider>();

    fetchData();
  }


  Future<void> fetchData({String? filter}) async {
    if (!isLoading) {
      setState(() {
        isLoading = true;
        // Clear existing data when the filter changes
        listaTakmicara = null;
        filteredList.clear();
      });

      var data = await _takmicarProvider.getById2(widget.kategorija?.id);

      setState(() {
        if (listaTakmicara == null) {
          listaTakmicara = data;
          ukupnoTakmicara = data.count;
        } else {
          listaTakmicara!.result.addAll(data.result);
        }
        filteredList = listaTakmicara?.result ?? [];
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
          _rutaDugme(),
          Expanded(child: tabela()),
        ],
      ),
    );
  }

  Widget _rutaDugme() {
    //breadCrumb i button print
    String userRole = getCurrentUserRole();
    bool isAdmin = userRole == "Admin";
    return Padding(
      //Button for add new and search
      padding: const EdgeInsets.all(30.0),
      child: Row(
        //mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Rang lista / ${widget.kategorija?.naziv} - nivo ${widget.kategorija?.nivo}",
            style: const TextStyle(
                fontSize: 22, wordSpacing: 2, fontWeight: FontWeight.w500),
          ),
          const Spacer(),
          if (isAdmin)
            ElevatedButton(
              onPressed: () {
                _createPdfReport(context, filteredList, widget.kategorija?.naziv as String, widget.kategorija?.nivo as String);
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

  Widget tabela() {
    String userRole = getCurrentUserRole();
    bool isKomisija = userRole == "Komisija";

    return isLoading
        ? const Center(child: CircularProgressIndicator())
        : listaTakmicara == null
        ? const Center(child: Text('No data available'))
        : SingleChildScrollView(
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Container(
          width: MediaQuery.of(context).size.width,
          child: DataTable(
            dataTextStyle: const TextStyle(fontSize: 16),
            columns: [
              const DataColumn(label: Text('Ime')),
              const DataColumn(label: Text('Prezime')),
              const DataColumn(label: Text('Datum Rodjenja')),
              if (!isKomisija)
                const DataColumn(label: Text('Ukupno Bodova')),
              if (isKomisija)
                const DataColumn(label: Text('Ocjeni')),
            ],
            rows: filteredList.map<DataRow>((item) {
              return DataRow(
                cells: [
                  DataCell(Text(item.ime.toString())),
                  DataCell(Text(item.prezime.toString())),
                  DataCell(
                      Text((DateFormat.yMMMd().format(item.datumRodjenja)))),
                  if (!isKomisija)
                    DataCell(Text(item.ukupnoBodova?.toString() ?? 'N/A')),
                  if (isKomisija)
                    DataCell(
                      ratedItems.contains(item.id)
                          ? const Icon(Icons.check, color: Colors.green) // Already rated
                          : ElevatedButton(
                        child: const Icon(Icons.add),
                        onPressed: () {
                          showRatingDialog(item);
                        },
                      ),
                    ),
                ],
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
  void showRatingDialog(Takmicar item) {
    int? _selectedRating;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: Text('Ocjeni: ${item.ime} ${item.prezime}'),
              content: DropdownButton<int>(
                hint: const Text('Unesi ocjenu'),
                value: _selectedRating,
                items: List.generate(10, (index) => index + 1)
                    .map((rating) => DropdownMenuItem<int>(
                  value: rating,
                  child: Text(rating.toString()),
                ))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedRating = value;
                  });
                },
              ),
              actions: [
                TextButton(
                  child: const Text('Cancel'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                ElevatedButton(
                  child: const Text('Potvrdi'),
                  onPressed: () async {
                    if (_selectedRating != null) {
                      final provider = TakmicarProvider();
                      final success = await provider.addOcjena(item.id, _selectedRating!);
                      fetchData();
                      if (success) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Uspješno ocjenjeno!')),
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Neuspješno!')),
                        );
                      }
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Odaberite ocjenu!')),
                      );
                    }
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      },
    );
    setState(() {
      ratedItems.add(item.id); // Assuming item has a unique `id`
    });
  }

  String getCurrentUserRole() {
    if (Korisnik.uloge.contains("Komisija")) {
      return "Komisija";
    } else
      return "Admin";
  }


 void _createPdfReport(BuildContext context, List<Takmicar> filteredList, String naziv, String nivo) async {
   final pdf = pw.Document();
   final fontData = await rootBundle.load('assets/fonts/OpenSans-VariableFont_wdth,wght.ttf');
   final ttf = pw.Font.ttf(fontData);

   String now = DateFormat('dd.MM.yyyy HH:mm').format(DateTime.now());
   pdf.addPage(
     pw.Page(
       build: (pw.Context context) => pw.Column(
           crossAxisAlignment: pw.CrossAxisAlignment.center,
           children: [
             pw.Text("Islamska zajednica u Bosni i Hercegovini", style: pw.TextStyle(fontSize: 12, font: ttf)),
             pw.Text("Medžlis Islamske zajednice Mostar", style: pw.TextStyle(fontSize: 12, font: ttf)),
             pw.SizedBox(height: 20),
           pw.Text(
             "Rang lista / $naziv - nivo $nivo",
             style: pw.TextStyle(fontSize: 22, fontWeight: pw.FontWeight.bold, font: ttf),
           ),

           pw.SizedBox(height: 20),
       pw.TableHelper.fromTextArray(
         cellStyle: pw.TextStyle(font: ttf),
         data: <List<String>>[
           <String>[
             'Ime',
             'Prezime',
             'Datum Rodjenja',
             'Ukupno Bodova',
           ],
           ...filteredList.map(
                 (item) => [
               item.ime.toString(),
               item.prezime.toString(),
               DateFormat.yMMMd().format(item.datumRodjenja),
               (item.ukupnoBodova?.toString() ?? 'N/A'),

             ],
           ).toList(),
         ],
       ),
         pw.SizedBox(height: 20),
         pw.Text(
           now,
           style: pw.TextStyle(fontSize: 14, font: ttf),
         ),
     ],
       )
     ),
   );

   await Printing.layoutPdf(
     onLayout: (PdfPageFormat format) async => pdf.save(),
   );
   fetchData();
 }




}
