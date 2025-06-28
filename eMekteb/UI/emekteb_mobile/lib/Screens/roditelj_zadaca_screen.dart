// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:emekteb_mobile/Widgets/master_screen.dart';
import 'package:emekteb_mobile/models/korisnik.dart';
import 'package:emekteb_mobile/providers/zadaca_provider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../models/searches/search_result.dart';
import '../models/user.dart';
import '../models/zadaca.dart';
import '../providers/user_provider.dart';

void main() {
  runApp(RoditeljZadacaScreen(
    ucenik: null,
  ));
}


class RoditeljZadacaScreen extends StatefulWidget {
  final User? ucenik;
  const RoditeljZadacaScreen({super.key, this.ucenik});

  @override
  State<RoditeljZadacaScreen> createState() => _ZadacaState();
}

class _ZadacaState extends State<RoditeljZadacaScreen> {
  late ZadacaProvider _zadacaProvider;
  late UserProvider _UserProvider;

  int currentPage = 1;
  int numPages = 12;
  bool isLoading = false;
  int ukupno = 1;

  SearchResult<Zadaca>? listaZadaca;
  List<Zadaca> filteredList = [];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _zadacaProvider = context.read<ZadacaProvider>();
    _UserProvider = context.read<UserProvider>();
    if (_UserProvider.user == null) {
      _UserProvider.getKorisnik(Korisnik.id).then((_) {
        fetchData();
      });
    } else {
      fetchData();
    }
  }


  Future<void> fetchData({String? filter}) async {
    if (!isLoading) {
      setState(() {
        isLoading = true;
        // Clear existing data when the filter changes
        listaZadaca = null;
        filteredList.clear();
      });

      var data =
          await _zadacaProvider.getById2(widget.ucenik?.id);

      setState(() {
        if (listaZadaca == null) {
          listaZadaca = data;
          ukupno = data.count;
        } else {
          listaZadaca!.result.addAll(data.result);
        }
        filteredList = listaZadaca?.result ?? [];
        // print(filteredList.isNotEmpty ? filteredList[0].naziv : 'No data');
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MasterScreen(
      title: "Zadaća",
      child: main(),
    );
  }

  Widget main() {
    String userRole = getCurrentUserRole();
    bool isKomisija = userRole == "Komisija";
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SingleChildScrollView(
          child: Column(
            children: [
              lista(),
            ],
          ),
        ),
      ],
    );
  }


  Widget lista() {
    String userRole = getCurrentUserRole();
    bool isKomisija = userRole == "Komisija";
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeigh = MediaQuery.of(context).size.height;

    return Padding(
      padding: const EdgeInsets.only(top: 20.0),
      child: Column(children: [
        Container(
          width: screenWidth * 0.9,
          height: screenHeigh * 0.7,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
          ),
          child: isLoading
              ? Center(child: CircularProgressIndicator())
              : ListView.builder(
                  itemCount: filteredList.length,
                  itemBuilder: (context, index) {
                    var zadaca = filteredList[index];
                    return Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        color: Colors.white,
                        elevation: 3,
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    zadaca.zaZadacu ?? "",
                                    style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.normal,
                                    ),
                                    softWrap: true, // Allow text to wrap
                                    overflow: TextOverflow.visible, // Ensure the overflow is handled correctly
                                  ),
                                ],
                              ), Text(
                                zadaca.nazivRazreda,
                                style: const TextStyle(
                                  fontSize: 14.0,
                                ),
                              ),
                              Divider(
                                color: Colors.purple,
                                thickness: 2,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text( "Zadato: ${DateFormat('d.M.yyyy').format(zadaca.datumDodjele)}", style: TextStyle(color: Colors.black),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
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
