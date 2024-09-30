// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:emekteb_mobile/Screens/kamp_details_screen.dart';
import 'package:emekteb_mobile/Screens/kamp_insert_screen.dart';
import 'package:emekteb_mobile/Screens/lekcija_details_screen.dart';
import 'package:emekteb_mobile/Screens/lekcija_insert_screen.dart';
import 'package:emekteb_mobile/Widgets/master_screen.dart';
import 'package:emekteb_mobile/models/dodatna_lekcija.dart';
import 'package:emekteb_mobile/models/korisnik.dart';
import 'package:emekteb_mobile/models/ocjene.dart';
import 'package:emekteb_mobile/providers/dodatnalekcija_provider.dart';
import 'package:emekteb_mobile/providers/kamp_provider.dart';
import 'package:emekteb_mobile/providers/ocjene_provider.dart';
import 'package:emekteb_mobile/providers/zadaca_provider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:number_paginator/number_paginator.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/searches/search_result.dart';
import '../models/kamp.dart';
import '../models/user.dart';
import '../models/zadaca.dart';
import '../providers/user_provider.dart';

void main() {
  runApp(RoditeljUspjehScreen(
    ucenik: null,
  ));
}
class RoditeljUspjehScreen extends StatefulWidget {
  final User? ucenik;
  const RoditeljUspjehScreen({super.key, this.ucenik});

  @override
  State<RoditeljUspjehScreen> createState() => _RoditeljUspjehState();
}

class _RoditeljUspjehState extends State<RoditeljUspjehScreen> {
  late ZadacaProvider _zadacaProvider;
  late OcjeneProvider _ocjeneProvider;
  late UserProvider _UserProvider;

  int currentPage = 1;
  int numPages = 12;
  bool isLoading = false;
  bool isLoading2 = false;
  int ukupno = 1;
  bool isExpanded = false;

  SearchResult<Zadaca>? listaZadaca;
  List<Zadaca> filteredList = [];
  SearchResult<Ocjene>? listaOcjena;
  List<Ocjene> filteredListOcjena = [];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _UserProvider = context.read<UserProvider>();
    _ocjeneProvider = context.read<OcjeneProvider>();
    _zadacaProvider = context.read<ZadacaProvider>();
        fetchDataZadace();
        fetchDataOcjene();


  }

  Future<void> fetchDataZadace({String? filter}) async {
    if (!isLoading2) {
      setState(() {
        isLoading2 = true;
        // Clear existing data when the filter changes
        listaZadaca = null;
        filteredList.clear();
      });

      var data = await _zadacaProvider.getById2(widget.ucenik?.id);
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
      title: "Uspjeh - ${widget.ucenik?.ime}",
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
          uspjehBox(),
          ocjeneWidget(),
        ],
      ),
    );
  }

  Widget ocjeneWidget() {
    final screenWidth = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.only(left: 30, right: 30),
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
            // Dropdown Header
            GestureDetector(
              onTap: () {
                setState(() {
                  isExpanded = !isExpanded;
                });
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "${widget.ucenik!.nazivRazreda.toString()} - ocjene",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Icon(isExpanded
                      ? Icons.keyboard_arrow_up
                      : Icons.keyboard_arrow_down),
                ],
              ),
            ),
            // Conditional Expanded ListView for showing items
            if (isExpanded)
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: filteredList.length,
                itemBuilder: (context, index) {
                  var zadaca = filteredList[index];

                  // Find the corresponding grade from listaOcjena using ocjeneId
                  var ocjena = listaOcjena?.result
                      .firstWhere((item) => item.id == zadaca.ocjeneId);

                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Lekcija name
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
                                  //color: Colors.green
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
  }

  Widget uspjehBox() {
    final screenWidth = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.only(top: 25.0, bottom: 25.0),
      child: Column(children: [
        Container(
          width: screenWidth * 0.85,
          height: 180,
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
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        "Uspjeh za ${widget.ucenik?.nazivRazreda}",
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                        softWrap: true, // Allow text to wrap
                        overflow: TextOverflow
                            .visible, // Ensure the overflow is handled correctly
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Text(
                        "Prosječna ocjena:",
                        style: const TextStyle(
                          fontSize: 18.0,
                        ),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        "${widget.ucenik?.prosjek}",
                        style: const TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        "Prisustvo:",
                        style: const TextStyle(
                          fontSize: 18.0,
                        ),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        "${widget.ucenik?.prisustvo?.toStringAsFixed(0)}%",
                        style: const TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Divider(
                    color: Colors.green,
                    thickness: 3,
                  ),
                ],
              ),
            ),
          ),
        ),
      ]),
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
