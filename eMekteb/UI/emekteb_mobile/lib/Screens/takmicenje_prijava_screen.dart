import 'package:emekteb_mobile/Widgets/master_screen.dart';
import 'package:emekteb_mobile/models/takmicenje.dart';
import 'package:emekteb_mobile/providers/kategorija_provider.dart';
import 'package:emekteb_mobile/providers/takmicar_provider.dart';
import 'package:emekteb_mobile/providers/takmicenja_provider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../models/searches/search_result.dart';

class TakmicenjePrijava extends StatefulWidget {
  const TakmicenjePrijava({super.key});

  @override
  State<TakmicenjePrijava> createState() => _TakmicenjePrijavaState();
}

class _TakmicenjePrijavaState extends State<TakmicenjePrijava> {
  final _formKey = GlobalKey<FormState>();
  late TakmicenjaProvider _takmicenjaProvider;
  late KategorijaProvider _kategorijaProvider;
  late TakmicarProvider _takmicarProvider;
  String ime = '';
  String prezime = '';
  String tekst = '';
  String? kategorija;
  DateTime datumRodjenja = DateTime.now();
  final TextEditingController _datumRodjenjaController = TextEditingController();

  TextEditingController _imeController = TextEditingController();
  TextEditingController _prezimeController = TextEditingController();
  int currentPage = 1;
  int numPages = 12;
  bool isLoading = false;
  int ukupno = 1;

  bool isLoading2 = false;
  int ukupno2 = 1;
  List<dynamic> filteredListKategorija = [];
  dynamic listaKategorija;

  SearchResult<Takmicenje>? listaTakmicenja;
  List<Takmicenje> filteredListTakmicenje = [];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _takmicenjaProvider = context.read<TakmicenjaProvider>();
    _kategorijaProvider = context.read<KategorijaProvider>();
    _takmicarProvider = context.read<TakmicarProvider>();
    _datumRodjenjaController.text = datumRodjenja.toLocal().toString().split(' ')[0];
    fetchDataTakmicenje();

  }

  Future<void> fetchDataTakmicenje({String? filter}) async {
    if (!isLoading) {
      setState(() {
        isLoading = true;
        // Clear existing data when the filter changes
        listaTakmicenja = null;
        filteredListTakmicenje.clear();
      });

      var data = await _takmicenjaProvider.getLastTakmicenje();

      setState(() {
        if (listaTakmicenja == null) {
          listaTakmicenja = data;
          ukupno = data.count;
        } else {
          listaTakmicenja!.result.addAll(data.result);
        }
        isLoading = false;
      });

      fetchDataKategorije();
    }
  }

  Future<void> fetchDataKategorije() async {
    if (!isLoading2) {
      setState(() {
        isLoading2 = true;
        // Clear existing data when the filter changes
        listaKategorija = null;
        filteredListKategorija.clear();
      });

      var data = await _kategorijaProvider.getById2(listaTakmicenja?.result.first.id);

      setState(() {
        if (listaKategorija == null) {
          listaKategorija = data;
          ukupno2 = data.count;
        } else {
          listaKategorija!.result.addAll(data.result);
        }
        filteredListKategorija = listaKategorija?.result ?? [];
        // print(filteredList.isNotEmpty ? filteredList[0].naziv : 'No data');
        isLoading2 = false;  // Corrected from isLoading to isLoading2
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    return MasterScreen(
      title: "Prijava na takmičenje",
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            nazivSection(),
            divider(),
            infoSection(),
            divider2(),
            formSection(),
            //saveButton(),
          ],
        ),
      ),
    );
  }

  Widget nazivSection() {
    return isLoading
        ? const CircularProgressIndicator()
        : Padding(
      padding: const EdgeInsets.only(top: 12.0, bottom: 20.0),
      child: Center(
        child: Text(
          "Takmičenje ${listaTakmicenja?.result.first.godina}.",
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w400),
        ),
      ),
    );
  }

  Widget divider() {
    final screenWidth = MediaQuery.of(context).size.width;
    return SizedBox(
      width: screenWidth * 0.9,
      child: Divider(
        color: Colors.orange.shade300, // You can change the color to your preference
        thickness: 3, // Adjust the thickness as needed
      ),
    );
  }
  Widget divider2() {
    final screenWidth = MediaQuery.of(context).size.width;
    return SizedBox(
      width: screenWidth * 0.4,
      child: Divider(
        color: Colors.orange.shade300, // You can change the color to your preference
        thickness: 3, // Adjust the thickness as needed
      ),
    );
  }

  Widget infoSection() {
    final screenWidth = MediaQuery.of(context).size.width;
    final dateFormat = DateFormat('dd.MM.yyyy');

    String formattedDate;
    if (listaTakmicenja?.result.first.datumOdrzavanja != null) {
      formattedDate = dateFormat.format(listaTakmicenja!.result.first.datumOdrzavanja);
    } else {
      formattedDate = 'N/A';
    }
    return isLoading
        ? const CircularProgressIndicator()
        : Padding(
      padding: const EdgeInsets.only(top: 20.0, bottom: 25.0),
      child: Column(
        children: [
          Container(
            width: screenWidth * 0.7,
            child: Column(
              children: [
                Text(
                  "${listaTakmicenja?.result.first.info}",
                  style: const TextStyle(fontSize: 18),
                  textAlign: TextAlign.center,
                ),
                Text(
                  "Datum: $formattedDate",
                  style: const TextStyle(fontSize: 18),
                  textAlign: TextAlign.justify,
                ),
                Text(
                  "Vrijeme: ${listaTakmicenja?.result.first.vrijemePocetka}",
                  style: const TextStyle(fontSize: 18),
                  textAlign: TextAlign.justify,
                ),
                Text(
                  "Lokacija: ${listaTakmicenja?.result.first.lokacija}",
                  style: const TextStyle(fontSize: 18),
                  textAlign: TextAlign.justify,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget formSection() {
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.only(top: 25.0),
        child: Column(
          children: [
            const Text(
              "Prijava takmičara",
              style: TextStyle(fontSize: 22),
            ),
            TextFormField(
              controller: _imeController,
              decoration: const InputDecoration(labelText: 'Ime učenika:'),
              textCapitalization: TextCapitalization.sentences,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Unesite ime učenika';
                }
                return null;
              },
              onSaved: (value) {
                ime = value!;
              },
            ),
            TextFormField(
              controller: _prezimeController,
              decoration: const InputDecoration(labelText: 'Prezime učenika:'),
              textCapitalization: TextCapitalization.sentences,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Unesite prezime učenika';
                }
                return null;
              },
              onSaved: (value) {
                prezime = value!;
              },
            ),
            TextFormField(
              controller: _datumRodjenjaController,
              decoration: const InputDecoration(labelText: 'Datum rođenja'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Unesite datum rođenja';
                }
                return null;
              },
              onTap: () async {
                FocusScope.of(context).requestFocus(FocusNode());
                DateTime? picked = await showDatePicker(
                  context: context,
                  initialDate: datumRodjenja,
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2101),
                );
                if (picked != null && picked != datumRodjenja) {
                  setState(() {
                    datumRodjenja = picked;
                    _datumRodjenjaController.text = datumRodjenja.toLocal().toString().split(' ')[0];
                  });
                }
              },
            ),
            Padding(
              padding: const EdgeInsets.only(top: 15.0, bottom: 15.0),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                decoration: BoxDecoration(
                  color: Colors.orange[200],
                  borderRadius: BorderRadius.circular(5.0),
                ),
                child: DropdownButtonFormField<String>(
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                  ),
                  hint: const Text("Kategorija"),
                  value: kategorija,
                  onChanged: (newValue) {
                    setState(() {
                      kategorija = newValue;
                    });
                  },
                  items: filteredListKategorija.map<DropdownMenuItem<String>>((kategorija) {
                    return DropdownMenuItem<String>(
                      value: kategorija.id.toString(),
                      child: Text('${kategorija.naziv} - ${kategorija.nivo}'),
                    );
                  }).toList(),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Odaberite kategoriju';
                    }
                    return null;
                  },
                ),
              ),
            ),
            SizedBox(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepOrangeAccent,
                  padding: const EdgeInsets.symmetric(horizontal: 36.0, vertical: 12.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                ),
                onPressed: _submitForm,
                child: const Text(
                  'PRIJAVI',
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }


  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      bool success = await _takmicarProvider.insert(
        ime,
        datumRodjenja,
        prezime,
        int.tryParse(kategorija!),
      );

      if (success) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Učenik uspješno dodan na takmičenje.')),
        );
        _imeController.clear();
        _prezimeController.clear();
        _datumRodjenjaController.clear();
         setState(() {
           kategorija = null;
         });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Greška pri dodavanju učenika na takmičenje!')),
        );
      }
    }
  }
}
