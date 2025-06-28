import 'package:emekteb_admin/Screens/takmicari_adminView.dart';
import 'package:emekteb_admin/Screens/takmicenja_screen.dart';
import 'package:emekteb_admin/Screens/takmicenje_mektebi_screen.dart';
import 'package:emekteb_admin/Widgets/master_screen.dart';
import 'package:emekteb_admin/models/takmicenje.dart';
import 'package:emekteb_admin/providers/kategorija_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/kategorija.dart';
import '../models/searches/search_result.dart';

void main() {
  runApp(const TakmicenjeDetalji(
    takmicenje: null,
  ));
}

class TakmicenjeDetalji extends StatefulWidget {
  final Takmicenje? takmicenje;
  const TakmicenjeDetalji({super.key, this.takmicenje});

  @override
  State<TakmicenjeDetalji> createState() => _MektebDetaljiState();
}



class _MektebDetaljiState extends State<TakmicenjeDetalji> {
  List<Kategorija> filteredList = [];
  bool isLoading = false;
  SearchResult<Kategorija>? listaKategorija;
  int ukupnoTakmicenja = 1;

  late KategorijaProvider _kategorijaProvider;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _kategorijaProvider = context.read<KategorijaProvider>();

    fetchData();
  }

  Future<void> fetchData({String? filter}) async {
    if (!isLoading) {
      setState(() {
        isLoading = true;
        // Clear existing data when the filter changes
        listaKategorija = null;
        filteredList.clear();
      });

      var data = await _kategorijaProvider.getById2(widget.takmicenje?.id);

      setState(() {
        if (listaKategorija == null) {
          listaKategorija = data;
          ukupnoTakmicenja = data.count;
        } else {
          listaKategorija!.result.addAll(data.result);
        }
        filteredList = listaKategorija?.result ?? [];
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
          Expanded(child: gridView()),
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
              Navigator.of(context).pushReplacement(
                //pushReplacement  ili   push
                MaterialPageRoute(
                  builder: (context) => const Takmicenja(),
                ),
              );
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
          if(ukupnoTakmicenja != 6)
            ElevatedButton(
              onPressed: () => _showCreateForm(context, _kategorijaProvider),
              style: ElevatedButton.styleFrom(
                shape: const RoundedRectangleBorder(),
                padding: const EdgeInsets.only(
                    left: 18.0, right: 18.0, top: 16.0, bottom: 16.0),
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(Icons.add),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    "KATEGORIJA",
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),
          SizedBox(
            width: 10,
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).push(
              //pushReplacement  ili   push
              MaterialPageRoute(
                builder: (context) => TakmicenjeMektebi(takmicenje: widget.takmicenje),
              ),
            ); },
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(Icons.format_list_numbered),
                SizedBox(
                  width: 10,
                ),
                Text(
                  "RANG MEKTEBA",
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
          )
        ], //Buttons for sort filtering
      ),
    );
  }

  Widget gridView() {
    return Padding(
      padding: const EdgeInsets.only(top: 80, left: 50, right: 50),
      child: GridView.builder(
        itemCount: filteredList.length, // Ensure the item count is set
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3, // Number of columns
          mainAxisSpacing: 15.0,
          crossAxisSpacing: 15.0,
          childAspectRatio: 3, // Width to height ratio
        ),
        itemBuilder: (BuildContext context, int index) {
          Kategorija kategorija = filteredList[index];
          return InkWell(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => TakmicariAdmin(kategorija: kategorija),
                ),
              );
            },
            child: Card(
              color: Colors.grey.shade300,
              //  color: Colors.blueGrey[100],
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.zero, // Remove rounded corners
              ),
              child: Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      kategorija.naziv.toString(),
                      style: const TextStyle(
                          fontSize: 38, fontWeight: FontWeight.w400),
                    ),
                    Container(
                      //margin: EdgeInsets.symmetric(horizontal: 40.0),
                      height: 100, // Adjust height as needed
                      width: 3, // Adjust width as needed
                      color: Colors.orange,
                    ),
                    Text(
                      "${kategorija.nivo.toString()} nivo",
                      style: const TextStyle(
                          fontSize: 38, fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  void _showCreateForm(BuildContext context, KategorijaProvider provider) {
    final formKey = GlobalKey<FormState>();
    String naziv = '';
    String nivo = '';

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Dodaj kategoriju'),
          content: Form(
            key: formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Naziv'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Unesite naziv kategorije';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    naziv = value!;
                  },
                ),
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Nivo'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Unesite nivo';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    nivo = value!;
                  },
                ),
              ],
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
                  bool result = await provider.insert(naziv, nivo, widget.takmicenje?.id);
                  if (result) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Kategorija uspješno dodana')),
                    );
                    fetchData();
                    Navigator.of(context).pop();
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Greška pri dodavanju kategorije')),
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
