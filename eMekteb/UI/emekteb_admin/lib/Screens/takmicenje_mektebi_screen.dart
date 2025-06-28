import 'package:emekteb_admin/Widgets/master_screen.dart';
import 'package:emekteb_admin/models/kategorija.dart';
import 'package:emekteb_admin/models/korisnik.dart';
import 'package:emekteb_admin/models/mekteb_bodovi_dto.dart';
import 'package:emekteb_admin/models/takmicar.dart';
import 'package:emekteb_admin/models/takmicenje.dart';
import 'package:emekteb_admin/providers/takmicar_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../models/mekteb.dart';
import '../models/searches/search_result.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:collection/collection.dart'; // Add this at the top for searching list
import '../providers/mekteb_provider.dart';
import '../providers/takmicenja_provider.dart';

void main() {
  runApp(const TakmicenjeMektebi(
    takmicenje: null,
  ));
}

class TakmicenjeMektebi extends StatefulWidget {
  final Takmicenje? takmicenje;
  const TakmicenjeMektebi({super.key, this.takmicenje});

  @override
  State<TakmicenjeMektebi> createState() => _TakmicenjeMektebiState();
}

class _TakmicenjeMektebiState extends State<TakmicenjeMektebi> {
  List<MektebBodoviDto> filteredList = [];
  bool isLoading = false;

  SearchResult<MektebBodoviDto>? listaMekteba;
  int ukupnoTakmicara = 1;

  late TakmicenjaProvider _takmicenjaProvider;

  var medzlisId = Korisnik.medzlisId;

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
        listaMekteba = null;
        filteredList.clear();
      });

      var data = await _takmicenjaProvider.getBodoviPoMektebu(widget.takmicenje?.id);

      setState(() {
        if (listaMekteba == null) {
          listaMekteba = data;
          ukupnoTakmicara = data.count;
        } else {
          listaMekteba!.result.addAll(data.result);
        }
        filteredList = listaMekteba?.result ?? [];
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
    return Padding(
      //Button for add new and search
      padding: const EdgeInsets.all(30.0),
      child: Row(
        //mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          BackButton(
            onPressed: () {
              Navigator.of(context)
                  .pop(); // Pops the current page and goes back to the previous one
            },
          ),
          const SizedBox(
            width: 20,
          ),
          Text(
            "Takmičenje ${widget.takmicenje?.godina}",
            style: const TextStyle(
                fontSize: 22, wordSpacing: 2, fontWeight: FontWeight.w500),
          ),
          const Spacer(),
            ElevatedButton(
              onPressed: () {
                _createPdfReport(
                    context, filteredList, widget.takmicenje?.godina as String,
                    widget.takmicenje?.lokacija as String);
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
    return isLoading
        ? const Center(child: CircularProgressIndicator())
        : listaMekteba == null
        ? const Center(child: Text('No data available'))
        : SingleChildScrollView(
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Container(
          width: MediaQuery
              .of(context)
              .size
              .width,
          child: DataTable(
            dataTextStyle: const TextStyle(fontSize: 16),
            columns: [
              const DataColumn(label: Text('Ime')),
                const DataColumn(label: Text('Ukupno Bodova')),
            ],
            rows: filteredList.map<DataRow>((item) {
              return DataRow(
                cells: [
                  DataCell(Text(item.nazivMekteba.toString())),
                  DataCell(Text(item.ukupnoBodova?.toString() ?? 'N/A')),
                ],
              );
            }).toList(),
          ),
        ),
      ),
    );
  }


  void _createPdfReport(BuildContext context, List<MektebBodoviDto> filteredList,
      String naziv, String nivo) async {
    final pdf = pw.Document();
    final fontData = await rootBundle.load(
        'assets/fonts/OpenSans-VariableFont_wdth,wght.ttf');
    final ttf = pw.Font.ttf(fontData);

    String now = DateFormat('dd.MM.yyyy HH:mm').format(DateTime.now());

    pdf.addPage(
      pw.Page(
        build: (pw.Context context) =>
            pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.center,
              children: [
                pw.Text("Islamska zajednica u Bosni i Hercegovini",
                    style: pw.TextStyle(fontSize: 12, font: ttf)),
                pw.Text("Medžlis Islamske zajednice Mostar",
                    style: pw.TextStyle(fontSize: 12, font: ttf)),
                pw.SizedBox(height: 20),
                pw.Text(
                  "Takmičenje $naziv - lokacija: $nivo",
                  style: pw.TextStyle(
                      fontSize: 22, fontWeight: pw.FontWeight.bold, font: ttf),
                ),
                pw.SizedBox(height: 20),
                pw.TableHelper.fromTextArray(
                  cellStyle: pw.TextStyle(font: ttf),
                  headerDecoration: pw.BoxDecoration(color: PdfColors.grey300),
                  data: <List<String>>[
                    <String>[
                      'R.br.', // Redni broj
                      'Mekteb',
                      'Ukupno bodova',
                    ],
                    ...filteredList
                        .asMap()
                        .entries
                        .map(
                          (entry) {
                        var mekteb = listaMekteba?.result.firstWhere(
                                (m) => m.mektebId == entry.value.mektebId
                        );

                        return [
                          (entry.key + 1).toString(), // Redni broj
                          mekteb?.nazivMekteba ?? 'N/A', // Dodaj naziv Mekteba
                          (entry.value.ukupnoBodova?.toString() ?? 'N/A'),
                        ];
                      },
                    )
                        .toList(),
                  ],
                ),
                pw.SizedBox(height: 20),
                pw.Text(
                  now,
                  style: pw.TextStyle(fontSize: 14, font: ttf),
                ),
              ],
            ),
      ),
    );

    await Printing.layoutPdf(
      onLayout: (PdfPageFormat format) async => pdf.save(),
    );
    fetchData();
  }

  String getCurrentUserRole() {
    if (Korisnik.uloge.contains("Komisija")) {
      return "Komisija";
    } else
      return "Admin";
  }
}
