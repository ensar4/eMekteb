import 'package:emekteb_mobile/Screens/dnevnik_screen.dart';
import 'package:emekteb_mobile/Widgets/master_screen.dart';
import 'package:emekteb_mobile/providers/akademskagodina_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/razred.dart';
import '../models/searches/search_result.dart';
import '../providers/cas_provider.dart';
import '../providers/user_provider.dart';

class CasInsert extends StatefulWidget {
  const CasInsert({super.key});

  @override
  State<CasInsert> createState() => _CasInsertState();
}

class _CasInsertState extends State<CasInsert> {
  final _formKey = GlobalKey<FormState>();
  late UserProvider _userProvider;
  late CasProvider _casProvider;
  late AkademskagodinaProvider _akademskagodinaProvider;
  String lekcija = '';
  String? nivo;
  DateTime datum = DateTime.now();
  final TextEditingController _datumController = TextEditingController();
  
  SearchResult<Razred>? listaUcenika;
  List<Razred> filteredList = [];
  bool isLoading = false;
  int ukupno = 0;
  TextEditingController searchController = TextEditingController();
  int currentPage = 1;
  int numPages = 12;
  bool isSortAsc = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _casProvider = context.read<CasProvider>();
    _userProvider = context.read<UserProvider>();
    _akademskagodinaProvider = context.read<AkademskagodinaProvider>();
    _datumController.text = datum.toLocal().toString().split(' ')[0];

  }

  @override
  Widget build(BuildContext context) {
    return MasterScreen(
      title: "Čas",
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            nazivSection(),
            divider(),
            formSection(),
          ],
        ),
      ),
    );
  }

  Widget nazivSection() {
    return const Padding(
      padding: EdgeInsets.only(top: 25.0, bottom: 20.0),
      child: Center(
        child: Text(
          "Novi čas",
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }

  Widget divider() {
    return const SizedBox(
      width: 280,
      child: Divider(
        color: Colors.purple, 
        thickness: 3,
      ),
    );
  }


  Future<void> _submitForm() async {
   if (_formKey.currentState!.validate()) {
     _formKey.currentState!.save();
     int? akademskaGodinaId = await _akademskagodinaProvider.getActiveId();

     bool success = await _casProvider.insert(
       lekcija,
       datum, 
       nivo!,
       _userProvider.user?.mektebId,
       akademskaGodinaId
     );

     if (success) {
       ScaffoldMessenger.of(context).showSnackBar(
         const SnackBar(content: Text('Čas uspješno dodan.')),

       );
       Navigator.of(context).push(
         MaterialPageRoute(
           builder: (context) => const Dnevnik(),
         ),
       );
     } else {
       // Show an error message
       ScaffoldMessenger.of(context).showSnackBar(
         const SnackBar(content: Text('Greška pri dodavanju časa!')),
       );
     }
   }
  }
  Widget formSection() {
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.only(top: 25.0),
        child: Column(
          children: [
            TextFormField(
              decoration: const InputDecoration(labelText: 'Lekcija'),
              textCapitalization: TextCapitalization.sentences,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Unesite lekciju';
                }
                return null;
              },
              onSaved: (value) {
                lekcija = value!;
              },
            ),
            TextFormField(
              controller: _datumController,
              decoration: const InputDecoration(labelText: 'Datum'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Unesite datum';
                }
                return null;
              },
              onTap: () async {
                FocusScope.of(context).requestFocus(FocusNode());
                DateTime? picked = await showDatePicker(
                  context: context,
                  initialDate: datum,
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2101),
                );
                if (picked != null && picked != datum) {
                  setState(() {
                    datum = picked;
                    _datumController.text = datum.toLocal().toString().split(' ')[0];
                  });
                }
              },
            ),
              DropdownButtonFormField<String>(
                  decoration: const InputDecoration(labelText: 'Nivo'),
                  value: nivo,
                  items: ['I nivo', 'II nivo', 'III nivo', 'Sufara', 'Tedžvid', 'Hatma'].map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (newValue) {
                    setState(() {
                      nivo = newValue;
                    });
                  },
                ),
            const SizedBox(height: 30,),
            SizedBox(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.purple.shade400,
                  padding: const EdgeInsets.symmetric(horizontal: 36.0, vertical: 12.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                ),
                onPressed: _submitForm,
                child: const Text(
                  'SPASI',
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
