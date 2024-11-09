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
              DataColumn(label: Text('Uredi')),
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
                      icon: Icon(Icons.edit, color: Colors.cyan.shade700,),
                      onPressed: () async {
                        _showUpdateForm(context, _mualimProvider, item.id, item);
                      },
                    ),
                  ),
                  DataCell(
                    IconButton(
                      icon: Icon(Icons.delete, color: Colors.cyan.shade700,),
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

  void _showUpdateForm(BuildContext context, MualimProvider provider, int? userId, Mualim userData) {
    final formKey = GlobalKey<FormState>();
    String? ime = userData.ime;
    String? prezime = userData.prezime;
    String? username = userData.username;
    String? telefon = userData.telefon;
    String? mail = userData.mail;
    String? spol = userData.spol;
    String? status = userData.status;
    DateTime? datumRodjenja = userData.datumRodjenja;
    String? imeRoditelja = userData.imeRoditelja;
    int? mektebId = userData.mektebId;

    final TextEditingController datumRodjenjaController = TextEditingController();
    datumRodjenjaController.text = datumRodjenja!.toLocal().toString().split(' ')[0];

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Uredi mualima'),
          content: SizedBox(
            width: MediaQuery.of(context).size.width * 0.2,
            child: SingleChildScrollView(
              child: Form(
                key: formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextFormField(
                      initialValue: ime,
                      decoration: const InputDecoration(labelText: 'Ime'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Unesite ime mualima';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        ime = value!;
                      },
                    ),
                    TextFormField(
                      initialValue: prezime,
                      decoration: const InputDecoration(labelText: 'Prezime'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Unesite prezime mualima';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        prezime = value!;
                      },
                    ),
                    TextFormField(
                      initialValue: username,
                      decoration: const InputDecoration(labelText: 'Korisničko ime'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Unesite korisničko ime za mualima';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        username = value!;
                      },
                    ),
                    TextFormField(
                      initialValue: telefon,
                      decoration: const InputDecoration(labelText: 'Telefon'),
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Unesite telefon';
                        } else if (!RegExp(r'^[0-9\s\-/]+$').hasMatch(value)) {
                          return 'Neispravan format!';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        telefon = value!;
                      },
                    ),
                    TextFormField(
                      initialValue: mail,
                      decoration: const InputDecoration(labelText: 'Mail'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Unesite mail mualima';
                        } else if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
                          return 'Neispravan format maila!';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        mail = value!;
                      },
                    ),
                    DropdownButtonFormField<String>(
                      decoration: const InputDecoration(labelText: 'Spol'),
                      value: spol,
                      items: ['M', 'Ž'].map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      onChanged: (newValue) {
                        spol = newValue!;
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Unesite spol';
                        }
                        return null;
                      },
                    ),
                    DropdownButtonFormField<String>(
                      decoration: const InputDecoration(labelText: 'Status'),
                      value: status,
                      items: ['Aktivan', 'Neaktivan'].map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      onChanged: (newValue) {
                        status = newValue!;
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Unesite status mualima';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: datumRodjenjaController,
                      decoration: const InputDecoration(labelText: 'Datum rođenja'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Unesite datum rođenja mualima';
                        }
                        return null;
                      },
                      onTap: () async {
                        FocusScope.of(context).requestFocus(FocusNode());
                        DateTime? picked = await showDatePicker(
                          context: context,
                          initialDate: datumRodjenja,
                          firstDate: DateTime(1900),
                          lastDate: DateTime(2101),
                        );
                        if (picked != null && picked != datumRodjenja) {
                          datumRodjenja = picked;
                          datumRodjenjaController.text = datumRodjenja!.toLocal().toString().split(' ')[0];
                        }
                      },
                    ),
                    TextFormField(
                      initialValue: imeRoditelja,
                      decoration: const InputDecoration(labelText: 'Ime roditelja'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Unesite ime jednog roditelja';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        imeRoditelja = value!;
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
          actions: [
            TextButton(
              child: const Text('Odustani'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            ElevatedButton(
              child: const Text('Spremi'),
              onPressed: () async {
                if (formKey.currentState!.validate()) {
                  formKey.currentState!.save();
                  bool result = await provider.update(
                    userId,
                    ime!,
                    prezime!,
                    username!,
                    telefon!,
                    mail!,
                    spol!,
                    status!,
                    datumRodjenja!,
                    imeRoditelja!,
                    mektebId,
                  );
                  if (result) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Mualim uspješno ažuriran')),
                    );
                    fetchData();
                    Navigator.of(context).pop();
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Greška pri ažuriranju mualima')),
                    );
                  }
                }
              },
            ),
          ],
        );
      },
    );
  }

}