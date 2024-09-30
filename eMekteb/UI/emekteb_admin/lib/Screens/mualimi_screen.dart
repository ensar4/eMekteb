import 'package:emekteb_admin/Widgets/master_screen.dart';
import 'package:emekteb_admin/models/mualim.dart';
import 'package:emekteb_admin/providers/mualim_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/searches/search_result.dart';

void main() {
  runApp(const Muallimi());
}


class Muallimi extends StatefulWidget {
  const Muallimi({super.key});

  @override
  State<Muallimi> createState() => _ProfilInfoState();
}

class _ProfilInfoState extends State<Muallimi> {
  late MualimProvider _mualimProvider;

  SearchResult<Mualim>? listaMualima;
  List<Mualim> filteredList = [];
  int currentPage = 1; // Track the current page
  int numPages = 12; // Adjust the page size according to your backend configuration
  bool isLoading = false;
  int ukupnoMualima = 1;
  bool isSortAsc = false;


  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _mualimProvider = context.read<MualimProvider>();
    fetchData();
  }

  Future<void> fetchData({String? filter}) async {
    if (!isLoading) {
      setState(() {
        isLoading = true;
        // Clear existing data when the filter changes
        listaMualima = null;
        filteredList.clear();
      });

      var data = await _mualimProvider.get(page: currentPage, pageSize: numPages, sort: isSortAsc);

      setState(() {
        if (listaMualima == null) {
          listaMualima = data;
          ukupnoMualima = data.count;
        } else {
          listaMualima!.result.addAll(data.result);
        }

        filteredList = listaMualima?.result ?? [];
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MasterScreen(
      title: "Muallimi",
      child: Column(
        children: [
          headerWidet(),
          Expanded(child: tabelaWidget())
        ],
      ),
    );
  }
  
  Widget headerWidet(){
    return const Padding(padding: EdgeInsets.all(30),
    child: Row(
      children: [
        Text("Svi muallimi",
        style: TextStyle(fontSize: 22),)
      ],
    ),
    );
  }

  Widget tabelaWidget(){
    return isLoading
        ? const Center(child: CircularProgressIndicator())
        : listaMualima == null
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
              DataColumn(label: Text('Telefon')),
              DataColumn(label: Text('Mail')),
              DataColumn(label: Text('Izbriši')),

            ],
            rows: filteredList.map<DataRow>((item) {
              return DataRow(
                cells: [
                  DataCell(Text(item.ime.toString())),
                  DataCell(Text(item.prezime.toString())),
                  DataCell(Text((item.telefon.toString())),),
                  DataCell(Text((item.mail.toString())),),
                  DataCell(
                    IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () async {
                        bool confirmed = await _showConfirmationDialog(context);
                        if (confirmed) {
                          try {
                            await _mualimProvider.deleteMualim(item.id);
                            setState(() {
                              fetchData();
                            });
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Uspješno izbrisano!')),
                            );
                          } catch (e) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Greška prilikom brisanja: $e')),
                            );
                          }
                        }
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

  Future<bool> _showConfirmationDialog(BuildContext context) async {
    return (await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Potvrda brisanja'),
          content: const Text('Jeste li sigurni da želite izbrisati ovog mualima?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: const Text('POTVRDI', style: TextStyle(color: Colors.red),),
            ),
          ],
        );
      },
    )) ?? false;
  }
}