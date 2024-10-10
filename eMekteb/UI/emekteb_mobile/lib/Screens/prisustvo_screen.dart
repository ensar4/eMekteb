// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:emekteb_mobile/Widgets/master_screen.dart';
import 'package:emekteb_mobile/models/korisnik.dart';
import 'package:emekteb_mobile/models/prisustvo.dart';
import 'package:emekteb_mobile/providers/prisustvo_provider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:collection/collection.dart';

import '../models/searches/search_result.dart';
import '../providers/user_provider.dart';

void main() {
  runApp(const PrisustvoScreen());
}

class PrisustvoScreen extends StatefulWidget {
  const PrisustvoScreen({super.key});

  @override
  State<PrisustvoScreen> createState() => _PrisustvoState();
}

class _PrisustvoState extends State<PrisustvoScreen> {
  late PrisustvoProvider _prisustvoProvider;
  late UserProvider _UserProvider;

  int currentPage = 1;
  int numPages = 12;
  bool isLoading = false;
  int ukupno = 1;
  Map<String, bool> isExpandedRazred = {};
  bool isExpanded = false;

  SearchResult<Prisustvo>? listaPrisustva;
  List<Prisustvo> filteredList = [];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _UserProvider = context.read<UserProvider>();
    _prisustvoProvider = context.read<PrisustvoProvider>();

    if (_UserProvider.user == null) {
      _UserProvider.getKorisnik(Korisnik.id).then((_) {
        fetchDataPrisustvo();
      });
    } else {
      fetchDataPrisustvo();
    }
  }

  Future<void> fetchDataPrisustvo({String? filter}) async {
    if (!isLoading) {
      setState(() {
        isLoading = true;
        // Clear existing data when the filter changes
        listaPrisustva = null;
        filteredList.clear();
      });

      var data =
          await _prisustvoProvider.getKorisnikById(_UserProvider.user!.id);
      setState(() {
        if (listaPrisustva == null) {
          listaPrisustva = data;
          ukupno = data.count;
        } else {
          listaPrisustva!.result.addAll(data.result);
        }
        filteredList = listaPrisustva?.result ?? [];
        print(filteredList.isNotEmpty ? filteredList[0].casId : 'No data');
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MasterScreen(
      title: "Prisustvo",
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
          prisustvoWidget(),
          percents(
            prisustvoPercentage: _UserProvider.user?.prisustvo, // Provide the actual value here
          ),
        ],
      ),
    );
  }


  Widget prisustvoWidget() {
    final screenWidth = MediaQuery.of(context).size.width;

    // Group the filteredList by nazivRazreda
    var groupedByRazred = groupBy(filteredList, (uspjeh) => uspjeh.nazivRazreda);

    return Padding(
      padding: const EdgeInsets.only(left: 30, right: 30, top: 30),
      child: Column(
        children: groupedByRazred.entries.map((entry) {
          String nazivRazreda = entry.key;
          List prisustvoForRazred = entry.value;

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
                  // Dropdown Header for each Razred
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
                          "$nazivRazreda - prisustvo",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        Icon(isExpandedRazred[nazivRazreda] == true
                            ? Icons.keyboard_arrow_up
                            : Icons.keyboard_arrow_down),
                      ],
                    ),
                  ),

                  // Conditional Expanded ListView for showing items for this Razred
                  if (isExpandedRazred[nazivRazreda] == true)
                    ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: prisustvoForRazred.length,
                      itemBuilder: (context, index) {
                        var uspjeh = prisustvoForRazred[index];

                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Display date and attendance status
                              Row(
                                children: [
                                  Text(
                                    DateFormat('d.M.yyyy')
                                        .format(uspjeh.datum ?? DateTime.now()),
                                    style: TextStyle(fontSize: 16),
                                  ),
                                  Spacer(),
                                  Text(
                                    (uspjeh.prisutan == true)
                                        ? 'Prisutan'
                                        : 'Odsutan',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                      color: (uspjeh.prisutan == true)
                                          ? Colors.green
                                          : Colors.red,
                                    ),
                                  ),
                                ],
                              ),
                              Divider(color: Colors.grey, thickness: 2),
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

  Widget percents({required prisustvoPercentage}) {
    num odsustvoPercentage =
        100 - prisustvoPercentage; // Calculating the absence percentage
    final screenWidth = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        width: screenWidth*0.85,
        padding: EdgeInsets.all(20),
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
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            // Green Checkmark
            Column(
              children: [
                CircleAvatar(
                  radius: 25,
                  backgroundColor: Colors.green.withOpacity(0.2),
                  child: Icon(Icons.check, color: Colors.green, size: 30),
                ),
                SizedBox(height: 8),
                Text(
                  '${prisustvoPercentage.toStringAsFixed(0)}%', // Showing the percentage
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ],
            ),

            // Red Cross
            Column(
              children: [
                CircleAvatar(
                  radius: 25,
                  backgroundColor: Colors.red.withOpacity(0.2),
                  child: Icon(Icons.close, color: Colors.red, size: 30),
                ),
                SizedBox(height: 8),
                Text(
                  '${odsustvoPercentage.toStringAsFixed(0)}%', // Showing the absence percentage
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ],
        ),
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
