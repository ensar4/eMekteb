import 'package:emekteb_mobile/Screens/cas_insert_screen.dart';
import 'package:emekteb_mobile/Widgets/master_screen.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../models/cas.dart';
import '../models/korisnik.dart';
import '../models/searches/search_result.dart';
import '../providers/akademskagodina_provider.dart';
import '../providers/cas_provider.dart';
import '../providers/user_provider.dart';
import 'cas_details_screen.dart';

void main() {
  runApp(const Dnevnik());
}

class Dnevnik extends StatefulWidget {
  const Dnevnik({super.key});

  @override
  State<Dnevnik> createState() => _DnevnikState();
}

class _DnevnikState extends State<Dnevnik> {
  late CasProvider _casProvider;
  late UserProvider _userProvider;
  late AkademskagodinaProvider _akademskagodinaProvider;
  int currentPage = 1;
  int numPages = 12;
  bool isLoading = false;
  int ukupno = 1;

  SearchResult<Cas>? listaCasova;
  List<Cas> filteredList = [];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _casProvider = context.read<CasProvider>();
    _akademskagodinaProvider = context.read<AkademskagodinaProvider>();
    _userProvider = context.read<UserProvider>();

    fetchDataCasovi();
    if (_userProvider.user == null) {
      _userProvider.getKorisnik(Korisnik.id).then((_) {
        fetchDataCasovi();
      });
    } else {
      fetchDataCasovi();
    }
  }
  Future<void> fetchDataCasovi({String? filter}) async {
    if (!isLoading) {
      setState(() {
        isLoading = true;
        listaCasova = null;
        filteredList.clear();
      });

      int? akademskaGodinaId = await _akademskagodinaProvider.getActiveId();

      var data = await _casProvider.getById2(_userProvider.user!.mektebId);

      setState(() {
        if (listaCasova == null) {
          listaCasova = data;
          ukupno = data.count;
        } else {
          listaCasova!.result.addAll(data.result);
        }

        filteredList = listaCasova?.result
            .where((item) => item.akademskaGodinaId == akademskaGodinaId)
            .toList() ?? [];

        isLoading = false;
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    return MasterScreen(
      title: "Dnevnik",
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
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Column(
         children: [
           Padding(
            padding: const EdgeInsets.only(top: 25.0),
             child: _buildAddButton(),
           ),
           lista()
          ],
        ),
      ],
    );
  }

  Widget _buildAddButton() {
    final screenWidth = MediaQuery.of(context).size.width;
    return Container(
      width: screenWidth * 0.4,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.purple, // Light blue color
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 36.0, vertical: 12.0),
        ),
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const CasInsert(),
            ),
          );
        },
        child: const Row(
          children: [
            Icon(
              Icons.add,
              color: Colors.white,
            ),
            SizedBox(width: 10),
            Text(
              "Čas",
              style: TextStyle(fontSize: 18, color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }

  Widget lista() {
    final screenWidth = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.only(top: 25.0),
      child: Container(
        width: screenWidth * 0.9, // 80% of the screen width
        height: 550,
        decoration: BoxDecoration(
          //color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: isLoading
            ? const Center(child: CircularProgressIndicator())
            : ListView.builder(
          itemCount: filteredList.length,
          itemBuilder: (context, index) {
            var cas = filteredList[index];
            return Padding(
              padding: const EdgeInsets.all(10.0),
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
                              "${DateFormat('d.M.yyyy').format(cas.datum)} - ${cas.razred}",
                              style: const TextStyle(
                                  fontSize: 22, fontWeight: FontWeight.normal),
                            ),
                            const Spacer(),
                            IconButton(
                              icon: const Icon(Icons.open_in_new, color: Colors.black),
                              onPressed: () {
                                 Navigator.push(
                                   context,
                                   MaterialPageRoute(
                                     builder: (context) =>
                                         CasDetalji(cas: cas),
                                   ),
                                 );
                              },
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 3,
                        ),
                        const Divider(
                          color: Colors.purple,
                          thickness: 3,
                        ),
                        const SizedBox(height: 10),
                        Text(
                          "Lekcija: ${cas.lekcija}",
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.black54,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
             // ),
            );
          },
        ),
      ),
    );
  }//

}
