// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:emekteb_mobile/Widgets/master_screen.dart';
import 'package:emekteb_mobile/models/korisnik.dart';
import 'package:emekteb_mobile/models/ocjene.dart';
import 'package:emekteb_mobile/providers/ocjene_provider.dart';
import 'package:emekteb_mobile/providers/ucenici_provider.dart';
import 'package:emekteb_mobile/providers/zadaca_provider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:collection/collection.dart';
import '../models/searches/search_result.dart';
import '../models/ucenik.dart';
import '../models/zadaca.dart';
import '../providers/user_provider.dart';

void main() {
  runApp(const UspjehScreen());
}

class UspjehScreen extends StatefulWidget {
  const UspjehScreen({super.key});

  @override
  State<UspjehScreen> createState() => _UspjehState();
}

class _UspjehState extends State<UspjehScreen> {
  late ZadacaProvider _zadacaProvider;
  late OcjeneProvider _ocjeneProvider;
  late UserProvider _UserProvider;
  late UceniciProvider _uceniciProvider;

  int currentPage = 1;
  int numPages = 12;
  bool isLoading = false;
  bool isLoading2 = false;
  bool isLoading3 = false;
  int ukupno = 1;
  bool isExpanded = false;
  Map<String, bool> isExpandedRazred = {};


  SearchResult<Zadaca>? listaZadaca;
  List<Zadaca> filteredList = [];
  SearchResult<Ocjene>? listaOcjena;
  List<Ocjene> filteredListOcjena = [];
  late SearchResult<Ucenik>? listaUceniciHistory;
  List<Ucenik> filteredlistaUceniciHistory = [];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _UserProvider = context.read<UserProvider>();
    _ocjeneProvider = context.read<OcjeneProvider>();
    _zadacaProvider = context.read<ZadacaProvider>();
    _uceniciProvider = context.read<UceniciProvider>();

    if (_UserProvider.user == null) {
      _UserProvider.getKorisnik(Korisnik.id).then((_) {
        fetchDataZadace();
        fetchDataOcjene();
        fetchDataHistory();
      });
    } else {
      fetchDataZadace();
      fetchDataOcjene();
      fetchDataHistory();

    }
  }

  Future<void> fetchDataZadace({String? filter}) async {
    if (!isLoading2) {
      setState(() {
        isLoading2 = true;
        // Clear existing data when the filter changes
        listaZadaca = null;
        filteredList.clear();
      });

      var data = await _zadacaProvider.getById2(_UserProvider.user!.id);
      setState(() {
        if (listaZadaca == null) {
          listaZadaca = data;
          ukupno = data.count;
        } else {
          listaZadaca!.result.addAll(data.result);
        }
        filteredList = listaZadaca?.result ?? [];
        // print(filteredList.isNotEmpty ? filteredList[0].naziv : 'No data');
        isLoading2 = false;
      });
    }
  }

  Future<void> fetchDataHistory({String? filter}) async {
    if (!isLoading3) {
      setState(() {
        isLoading3 = true;
        // Clear existing data when the filter changes
        listaUceniciHistory = null;
        filteredlistaUceniciHistory.clear();
      });

      var data = await _uceniciProvider.getUcenikHistory(_UserProvider.user!.id);
      setState(() {
        if (listaUceniciHistory == null) {
          listaUceniciHistory = data;
          ukupno = data.count;
        } else {
          listaUceniciHistory!.result.addAll(data.result);
        }
        filteredlistaUceniciHistory = listaUceniciHistory?.result ?? [];
         print(filteredlistaUceniciHistory.isNotEmpty ? filteredlistaUceniciHistory[0].nazivRazreda : 'No data');
        isLoading3 = false;
      });
    }
  }

  Future<void> fetchDataOcjene() async {
    if (!isLoading) {
      setState(() {
        isLoading = true;
        // Clear existing data when the filter changes
        listaOcjena = null;
        filteredListOcjena.clear();
      });

      var data = await _ocjeneProvider.get(page: 1, pageSize: 100);

      setState(() {
        if (listaOcjena == null) {
          listaOcjena = data;
          ukupno = data.count;
        } else {
          listaOcjena!.result.addAll(data.result);
        }
        filteredListOcjena = listaOcjena?.result ?? [];
        // print(filteredList.isNotEmpty ? filteredList[0].naziv : 'No data');
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MasterScreen(
      title: "Uspjeh",
      child: SingleChildScrollView(
        child: Column(
          children: [
            main(),
          ],
        ),
      ),
    );
  }

  Widget main() {
    String userRole = getCurrentUserRole();
    bool isKomisija = userRole == "Komisija";
    return SingleChildScrollView(
      child: Column(
        children: [
          historyCards(),
          ocjeneWidget(),
        ],
      ),
    );
  }
  Widget historyCards() {
    return Padding(
      padding: const EdgeInsets.only(left: 30, right: 30, top: 30),
      child: Column(
        children: filteredlistaUceniciHistory.map((historyItem) {
          return Container(
            margin: EdgeInsets.only(bottom: 15), // Add spacing between cards
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 8,
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title (e.g., "Uspjeh za III nivo")
                Text(
                  'Uspjeh za ${historyItem.nazivRazreda}', // e.g., III nivo
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10), // Add spacing between the title and details

                // Average grade (Prosječna ocjena)
                RichText(
                  text: TextSpan(
                    text: 'Prosječna ocjena: ',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                    ),
                    children: [
                      TextSpan(
                        text: '${historyItem.prosjek?.toStringAsFixed(1)}',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(
                  height: 5,
                ),
                RichText(
                  text: TextSpan(
                    text: 'Prisustvo: ',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                    ),
                    children: [
                      TextSpan(
                        text: '${historyItem.prisustvo?.toStringAsFixed(1)}%',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 20), // Add some spacing before the divider

                // Green divider
                Divider(
                  color: Colors.green,
                  thickness: 2,
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget ocjeneWidget() {
    final screenWidth = MediaQuery.of(context).size.width;
    var groupedByRazred = groupBy(filteredList, (zadaca) => zadaca.nazivRazreda);

    return Padding(
      padding: const EdgeInsets.only(left: 30, right: 30, top: 30),
      child: Column(
        children: groupedByRazred.entries.map((entry) {
          String nazivRazreda = entry.key;
          List zadaceForRazred = entry.value;

          return Padding(
            padding: const EdgeInsets.only(bottom: 20.0), // Space between Razreds
            child: Container(
              padding: EdgeInsets.all(22),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 10,
                  ),
                ],
              ),
              child: Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        isExpandedRazred[nazivRazreda] =
                        !(isExpandedRazred[nazivRazreda] ?? false);
                      });
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "$nazivRazreda - ocjene",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        Icon(isExpandedRazred[nazivRazreda] == true
                            ? Icons.keyboard_arrow_up
                            : Icons.keyboard_arrow_down),
                      ],
                    ),
                  ),

                  if (isExpandedRazred[nazivRazreda] == true)
                    ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: zadaceForRazred.length,
                      itemBuilder: (context, index) {
                        var zadaca = zadaceForRazred[index];

                        var ocjena = listaOcjena?.result
                            .firstWhere((item) => item.id == zadaca.ocjeneId);

                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                zadaca.lekcija,
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w500),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "${DateFormat('d.M.yyyy').format(zadaca.datumDodjele)}",
                                    style: TextStyle(fontSize: 14),
                                  ),
                                  Text(
                                    ocjena?.ocjena ??
                                        'N/A', // Display the grade if found, else N/A
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                              Divider(color: Colors.green, thickness: 2),
                            ],
                          ),
                        );
                      },
                    ),
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }


  String getCurrentUserRole() {
    if (Korisnik.uloge.contains("Komisija")) {
      print(Korisnik.uloge.toString());
      return "Komisija";
    } else
      return "Admin";
  }
}
