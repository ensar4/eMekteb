import 'package:emekteb_mobile/Widgets/master_screen.dart';
import 'package:emekteb_mobile/providers/kamp_provider.dart';
import 'package:emekteb_mobile/providers/kampkorisnik_provider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../models/kamp.dart';
import '../models/searches/search_result.dart';
import '../models/user.dart';
import '../providers/user_provider.dart';

class KampRoditeljScreen extends StatefulWidget {
  const KampRoditeljScreen({super.key});

  @override
  State<KampRoditeljScreen> createState() => _KampRoditeljScreenState();
}

class _KampRoditeljScreenState extends State<KampRoditeljScreen> {
  final _formKey = GlobalKey<FormState>();
  late UserProvider _userProvider;
  late KampProvider _kampProvider;
  late KampKorisnikProvider _kampKorisnikProvider;

  String ime = '';
  String prezime = '';
  String tekst = '';
  String? kategorija;
  DateTime datumRodjenja = DateTime.now();
  final TextEditingController _datumRodjenjaController = TextEditingController();

  int currentPage = 1;
  int numPages = 12;
  bool isLoading = false;
  int ukupno = 1;

  bool isLoading2 = false;
  int ukupno2 = 1;

  SearchResult<Kamp>? listaKamp;
  List<Kamp> filteredListKamp = [];
  SearchResult<User>? listaUcenika;
  List<User> filteredListUcenici = [];
  String? selectedUcenik; // Holds selected student

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _userProvider = context.read<UserProvider>();
    _kampProvider = context.read<KampProvider>();
    _kampKorisnikProvider = context.read<KampKorisnikProvider>();

    _datumRodjenjaController.text = datumRodjenja.toLocal().toString().split(' ')[0];
    fetchDataKamp();
  fetchDataUcenici();
  }

  Future<void> fetchDataKamp({String? filter}) async {
    if (!isLoading) {
      setState(() {
        isLoading = true;
        // Clear existing data when the filter changes
        listaKamp = null;
        filteredListKamp.clear();
      });

      var data = await _kampProvider.getLastTakmicenje();

      setState(() {
        if (listaKamp == null) {
          listaKamp = data;
          ukupno = data.count;
        } else {
          listaKamp!.result.addAll(data.result);
        }
        isLoading = false;
      });
    }
  }

  Future<void> fetchDataUcenici() async {
    setState(() {
      isLoading2 = true;
    });

    var data = await _userProvider.getById2(_userProvider.user!.id);

    setState(() {
      listaUcenika = data;
      filteredListUcenici = listaUcenika?.result ?? [];
      isLoading2 = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MasterScreen(
      title: "Prijava na kamp",
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
      padding: const EdgeInsets.only(top: 10.0, bottom: 20.0),
      child: Center(
        child: Text(
          listaKamp!.result.first.naziv,
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
    final dateFormat = DateFormat('dd/MM/yyyy');

    // Check if the date is null before formatting
    String formattedDatePocetak;
    if (listaKamp?.result.first.datumPocetka != null) {
      formattedDatePocetak = dateFormat.format(listaKamp!.result.first.datumPocetka);
    } else {
      formattedDatePocetak = 'N/A'; // or any default value you prefer
    }
    String formattedDateZavrsetak;
    if (listaKamp?.result.first.datumPocetka != null) {
      formattedDateZavrsetak = dateFormat.format(listaKamp!.result.first.datumZavrsetka);
    } else {
      formattedDateZavrsetak = 'N/A'; // or any default value you prefer
    }
    return isLoading
        ? const CircularProgressIndicator()
        : Padding(
      padding: const EdgeInsets.only(top: 15.0, bottom: 20.0),
      child: Column(
        children: [
          Container(
            width: screenWidth * 0.7,
            child: Column(
              children: [
                Text(
                  "${listaKamp?.result.first.opis}",
                  style: const TextStyle(fontSize: 18),
                  textAlign: TextAlign.center,
                ),
                Text(
                  "Datum početka: $formattedDatePocetak",
                  style: const TextStyle(fontSize: 18),
                  textAlign: TextAlign.justify,
                ),
                Text(
                  "Datum završetka: $formattedDateZavrsetak",
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
              "Prijava",
              style: TextStyle(fontSize: 22),
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
                child: DropdownButtonFormField<User>(
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                  ),
                  hint: const Text("Odaberi dijete"),
                  value: selectedUcenik != null ? filteredListUcenici.firstWhere((ucenik) => ucenik.ime == selectedUcenik) : null,

                  onChanged: (newValue) {
                    setState(() {
                      selectedUcenik = newValue?.ime;
                    });
                  },
                  items: filteredListUcenici.map<DropdownMenuItem<User>>((ucenik) {
                    return DropdownMenuItem<User>(
                      value: ucenik,
                      child: Text('${ucenik.ime} ${ucenik.prezime}'),
                    );
                  }).toList(),
                  validator: (value) {
                    if (value == null) {
                      return 'Odaberite dijete';
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
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    // Save the form state
                    _formKey.currentState!.save();

                    // Fetch the selected student and the first camp (since you're working with the first camp from the list)
                    User? selectedStudent = filteredListUcenici.firstWhere((ucenik) => ucenik.ime == selectedUcenik);
                    Kamp? selectedKamp = listaKamp?.result.first;

                    if (selectedKamp != null) {
                      bool success = await _kampKorisnikProvider.insert(
                        DateTime.now(),
                        selectedKamp.id,
                        selectedStudent.id,
                      );

                      if (success) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('${selectedStudent.ime} uspješno prijavljen na kamp.')),
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Greška pri prijavi na kamp.')),
                        );
                      }
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Odaberite dijete.')),
                      );
                    }
                  }
                },

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



}
