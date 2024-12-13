import 'package:emekteb_admin/Widgets/master_screen.dart';
import 'package:emekteb_admin/models/akademska_godina.dart';
import 'package:emekteb_admin/providers/akademskagodina_provider.dart';
import 'package:emekteb_admin/providers/medzlis_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'dart:ui' as ui;

import '../Widgets/akademska_godina_chart.dart';
import '../models/medzlis.dart';
import '../models/mekteb.dart';
import '../models/searches/search_result.dart';
import '../providers/mekteb_provider.dart';

import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
void main() {
  runApp(const Statistika());
}

class Statistika extends StatefulWidget {
  const Statistika({super.key});

  @override
  State<Statistika> createState() => _ProfilInfoState();
}

class _ProfilInfoState extends State<Statistika> {
  late MektebProvider _mektebProvider;
  String dropdownValue1 = '1';
  SearchResult<Mekteb>? listaMekteba;
  int ukupnoMekteba = 1;
  List<Mekteb> filteredListMektebs = [];
  int currentPage = 1; // Track the current page
  int numPages = 12; // Adjust the page size according to your backend configuration
  bool isLoading = false;
  bool isSortAsc = false;


  late AkademskagodinaProvider _akademskaGodinaProvider;
  String dropdownValue2 = '1';
  SearchResult<AkademskaGodina>? listaGodina;
  int ukupnoGodina = 1;
  List<AkademskaGodina> filteredListGodine = [];

  late MedzlisProvider _medzlisProvider;
  SearchResult<Medzlis>? medzlis;
  List<Medzlis> filteredMedzlis = [];
  Mekteb? selectedMekteb;
  AkademskaGodina? selectedGodina;

  final GlobalKey chartKey = GlobalKey();

  @override
  Future<void> didChangeDependencies() async {
    super.didChangeDependencies();
    _mektebProvider = context.read<MektebProvider>();
    _akademskaGodinaProvider = context.read<AkademskagodinaProvider>();
    _medzlisProvider = context.read<MedzlisProvider>();
    await fetchDataMedzlis();
    await fetchDataMektebs();
    await fetchDataGodine();
  }

  Future<void> fetchDataMektebs({String? filter}) async {
    if (!isLoading) {
      setState(() {
        isLoading = true;
        // Clear existing data when the filter changes
        listaMekteba = null;
        filteredListMektebs.clear();
      });

      var data = await _mektebProvider.get(page: currentPage, pageSize: numPages, sort: isSortAsc);

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
  Future<void> fetchDataGodine({String? filter}) async {
    if (!isLoading) {
      setState(() {
        isLoading = true;
        // Clear existing data when the filter changes
        listaGodina = null;
        filteredListGodine.clear();
      });

      var data = await _akademskaGodinaProvider.get(page: currentPage, pageSize: numPages, sort: isSortAsc);

      setState(() {
        if (listaGodina == null) {
          listaGodina = data;
          ukupnoGodina = data.count;
        } else {
          listaGodina!.result.addAll(data.result);
        }

        filteredListGodine = listaGodina?.result ?? [];
        isLoading = false;
      });
    }
  }

  Future<void> fetchDataMedzlis({String? filter}) async {
    if (!isLoading) {
      setState(() {
        isLoading = true;
        // Clear existing data when the filter changes
        medzlis = null;
        filteredMedzlis.clear();
      });

      var data = await _medzlisProvider.get(page: currentPage, pageSize: numPages, sort: isSortAsc);

      setState(() {
        if (medzlis == null) {
          medzlis = data;
          ukupnoGodina = data.count;
        } else {
          medzlis!.result.addAll(data.result);
        }

        filteredMedzlis = medzlis?.result ?? [];
        isLoading = false;
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    return MasterScreen(
      title: "Statistika",
      child: SingleChildScrollView(
        child: Column(
          children: [
            _header(),
            divider(),
            filteredListGodine.isNotEmpty
                ? RepaintBoundary(
              key: chartKey,
              child: AkademskaGodinaChart(data: filteredListGodine),
            )
                : const Center(child: CircularProgressIndicator()),
            _bottom(),
          ],
        ),
      ),
    );
  }

  Widget divider() {
    double screenWidth = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: SizedBox(
        width: screenWidth * 0.95,
        child: Divider(
          color: Colors.cyan.shade400, // You can change the color to your preference
          thickness: 3, // Adjust the thickness as needed
        ),
      ),
    );
  }
  Widget _infoCard({required String title, required String value}) {
    return Container(
      width: 250,
      height: 200,
      color: Colors.grey.shade300,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(value, style: const TextStyle(fontSize: 46)),
          Text(title, style: const TextStyle(fontSize: 24)),
        ],
      ),
    );
  }
  Widget _header() {
    return Padding(
      padding: const EdgeInsets.all(30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _infoCard(
            title: "Učenika",
            value:
                 selectedMekteb != null
                ? selectedMekteb!.ukupnoUcenika.toString()
                : selectedGodina != null
                ? selectedGodina!.ukupnoUcenika.toString()
                : filteredMedzlis.isNotEmpty
                ? filteredMedzlis[0].ukupnoUcenika.toString()
                : 'Loading...',
          ),
          _infoCard(
            title: "Prisustvo %",
            value:
                 selectedMekteb != null
                ? selectedMekteb!.prosjecnoPrisustvo?.toStringAsFixed(0) ?? '0.00'
                : selectedGodina != null
                ? selectedGodina!.prosjecnoPrisustvo?.toStringAsFixed(0) ?? '0.00'
                : filteredMedzlis.isNotEmpty
                ? filteredMedzlis[0].prosjecnoPrisustvo?.toStringAsFixed(0) ?? '0.00'
                : 'Loading...',
          ),
          _infoCard(
            title: "Prosječna ocjena",
            value:
                selectedMekteb != null
                ? selectedMekteb!.prosjecnaOcjena?.toStringAsFixed(1) ?? '0.00'
                : selectedGodina != null
                ? selectedGodina!.prosjecnaOcjena?.toStringAsFixed(1) ?? '0.00'
                : filteredMedzlis.isNotEmpty
                ? filteredMedzlis[0].prosjecnaOcjena?.toStringAsFixed(1) ?? '0.00'
                : 'Loading...',
          ),
          _infoCard(
            title: "Mekteba",
            value:
                selectedMekteb != null
                ? selectedMekteb?.naziv?.split(" ")[1] ?? ""
                : selectedGodina != null
                ? selectedGodina!.ukupnoMekteba.toString()
                : filteredMedzlis.isNotEmpty
                ? filteredMedzlis[0].ukupnoMekteba.toString()
                : 'Loading...',
          ),
          Container(
            width: 250,
            height: 200,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                buttonMektebs(),
                buttonGodinas(),
              ],
            ),
          )
        ],
      ),
    );
  }
  void onPressedFunction(BuildContext context) async {
    // Generate the data needed for the PDF report
    String ucenikaValue = selectedMekteb != null
        ? selectedMekteb!.ukupnoUcenika.toString()
        : selectedGodina != null
        ? selectedGodina!.ukupnoUcenika.toString()
        : filteredMedzlis.isNotEmpty
        ? filteredMedzlis[0].ukupnoUcenika.toString()
        : 'Loading...';

    String prisustvoValue = selectedMekteb != null
        ? selectedMekteb!.prosjecnoPrisustvo?.toStringAsFixed(1) ?? '0.00'
        : selectedGodina != null
        ? selectedGodina!.prosjecnoPrisustvo?.toStringAsFixed(1) ?? '0.00'
        : filteredMedzlis.isNotEmpty
        ? filteredMedzlis[0].prosjecnoPrisustvo?.toStringAsFixed(1) ?? '0.00'
        : 'Loading...';

    String prosjecnaOcjenaValue = selectedMekteb != null
        ? selectedMekteb!.prosjecnaOcjena?.toStringAsFixed(1) ?? '0.00'
        : selectedGodina != null
        ? selectedGodina!.prosjecnaOcjena?.toStringAsFixed(1) ?? '0.00'
        : filteredMedzlis.isNotEmpty
        ? filteredMedzlis[0].prosjecnaOcjena?.toStringAsFixed(1) ?? '0.00'
        : 'Loading...';

    String mektebaValue = selectedMekteb != null
        ? selectedMekteb?.naziv?.split(" ")[1] ?? ""
        : selectedGodina != null
        ? selectedGodina!.ukupnoMekteba.toString()
        : filteredMedzlis.isNotEmpty
        ? filteredMedzlis[0].ukupnoMekteba.toString()
        : 'Loading...';

    // Call _createPdfReport with gathered data
     _createPdfReport(context, filteredListGodine, ucenikaValue, prisustvoValue, prosjecnaOcjenaValue, mektebaValue);
  }
  Widget _bottom(){
    return Padding(
      //Button for add new and search
      padding: const EdgeInsets.only(left: 30.0, right: 30.0),
      child: Row(
        //mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            "Analiza učenika po akademskim godinama",
            style: TextStyle(fontSize: 18),
          ),
          const Spacer(),
          ElevatedButton(
            onPressed: () {
              onPressedFunction(context);
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
  Widget buttonMektebs() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      height: 36,
      decoration: BoxDecoration(
        color: Colors.blueGrey[50],
        border: Border.all(color: Colors.black),
        borderRadius: const BorderRadius.all(Radius.circular(4.0)),
      ),
      child: DropdownButton<String>(
        hint: const Text("Mekteb"),
        //value: dropdownValue1,
        icon: const Icon(Icons.arrow_drop_down),
        elevation: 16,
        style: const TextStyle(color: Colors.black),
        underline: Container(),
        onChanged: (String? value) {
          setState(() {
            dropdownValue1 = value!;
            selectedMekteb = filteredListMektebs.firstWhere((mekteb) => mekteb.id.toString() == value);
          });
        },
        items:
          filteredListMektebs.map((item) {
            return DropdownMenuItem<String>(

              value: item.id.toString(), // Store Mekteb ID as value
              child: Text(item.naziv.toString()), // Display Mekteb name
            );
          }).toList(),

      ),
    );
  }
  Widget buttonGodinas() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      height: 36,
      decoration: BoxDecoration(
        color: Colors.blueGrey[50],
        border: Border.all(color: Colors.black),
        borderRadius: const BorderRadius.all(Radius.circular(4.0)),
      ),
      child: DropdownButton<String>(
        hint: const Text("Godina"),
        //value: dropdownValue2,
        icon: const Icon(Icons.arrow_drop_down),
        elevation: 16,
        style: const TextStyle(color: Colors.black),
        underline: Container(),
        onChanged: (String? value) {
          setState(() {
            selectedMekteb=null;
            dropdownValue2 = value!;
            selectedGodina = filteredListGodine.firstWhere((godina) => godina.id.toString() == value);
          });
        },
        items: filteredListGodine.map((item) {
          return DropdownMenuItem<String>(
            value: item.id.toString(), // Store Mekteb ID as value
            child: Text(item.naziv.toString()), // Display Mekteb name
          );
        }).toList(),
      ),
    );
  }





  void _createPdfReport(
      BuildContext context,
      List<AkademskaGodina> filteredList,
      String ucenikaValue,
      String prisustvoValue,
      String prosjecnaOcjenaValue,
      String mektebaValue,
      ) async {
    final pdf = pw.Document();
    final boundary = chartKey.currentContext?.findRenderObject() as RenderRepaintBoundary?;

    // Capture the chart image
    final chartImage = await boundary?.toImage(pixelRatio: 3.0);
    final byteData = await chartImage?.toByteData(format: ui.ImageByteFormat.png);
    final imageBytes = byteData?.buffer.asUint8List();

    // Current date and time
    String now = DateFormat('dd.MM.yyyy HH:mm').format(DateTime.now());
    pdf.addPage(
      pw.Page(
        build: (pw.Context context) => pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.center,
          children: [
            pw.Text("Islamska zajednica u Bosni i Hercegovini", style: pw.TextStyle(fontSize: 12)),
            pw.Text("Medzlis Islamske zajednice Mostar", style: pw.TextStyle(fontSize: 12)),
            pw.SizedBox(height: 20),
            pw.Text("Izvjestaj - Statistika", style: pw.TextStyle(fontSize: 22)),
            pw.SizedBox(height: 20),

            // Info text widgets
            _infoText("Ukupno ucenika: ", ucenikaValue, ""),
            _infoText("Prosjecno prisustvo: ", prisustvoValue , "%"),
            _infoText("Prosjecna ocjena: ", prosjecnaOcjenaValue, ""),
            _infoText("Ukupno mekteba: ", mektebaValue, ""),

            pw.SizedBox(height: 20),

            // Chart image with fixed width
            if (imageBytes != null)
              pw.Image(
                pw.MemoryImage(imageBytes),
                width: PdfPageFormat.a4.width - 45, // Adjusted width to fit the page
                height: 155, // Set a fixed height
               // fit: pw.BoxFit.cover,
              ),

            pw.SizedBox(height: 30),
            // Date and time at the bottom of the page
            pw.Text(
              DateFormat('dd.MM.yyyy HH:mm').format(DateTime.now()),
              style: const pw.TextStyle(fontSize: 14),
            ),
          ],
        ),
      ),
    );

    await Printing.layoutPdf(
      onLayout: (PdfPageFormat format) async => pdf.save(),
    );
    fetchDataGodine();
  }

// Helper function to create Text widgets for info cards
  pw.Widget _infoText(String title, String value, String znak) {
    return pw.Row(
      mainAxisAlignment: pw.MainAxisAlignment.start,
      children: [
        pw.Text(
          title,
          style: pw.TextStyle(fontWeight: pw.FontWeight.normal, fontSize: 18),
        ),
        pw.Text(value, style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 18)),
        pw.Text(znak, style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 18)),
      ],
    );
  }


}
