import 'package:emekteb_mobile/Screens/roditelj_kamp_screen.dart';
import 'package:emekteb_mobile/Screens/roditelj_prisustvo_screen.dart';
import 'package:emekteb_mobile/Screens/roditelj_uspjeh_screen.dart';
import 'package:emekteb_mobile/Widgets/master_screen.dart';
import 'package:emekteb_mobile/models/user.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/korisnik.dart';
import '../models/searches/search_result.dart';
import '../models/slika.dart';
import '../providers/slika_provider.dart';
import '../providers/user_provider.dart';
import 'obavijesti_screen.dart';

class RoditeljPocetna extends StatefulWidget {
  const RoditeljPocetna({super.key});

  @override
  State<RoditeljPocetna> createState() => _RoditeljPocetnaState();
}

class _RoditeljPocetnaState extends State<RoditeljPocetna> {
  late UserProvider _userProvider;
  late SlikaProvider _slikaProvider;
  var samoIme = Korisnik.ime?.split(" ")[0] ?? "";
  int currentPage = 1;
  int numPages = 12;
  bool isLoading = false;
  int ukupno = 1;
  String slikaBytes = '';

  SearchResult<Slika>? lista;
  List<Slika> filteredList = [];
  String? selectedUcenik; // Holds selected student

  SearchResult<User>? listaUcenika;
  List<User> filteredListUcenici = [];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _userProvider = context.read<UserProvider>();
    _slikaProvider = context.read<SlikaProvider>();
    if (_userProvider.user == null) {
      _userProvider.getKorisnik(Korisnik.id).then((_) {
        fetchDataUcenici(_userProvider.user?.id);

      });
    } else {
      fetchDataUcenici(_userProvider.user?.id);

    }

  }


  Future<void> fetchDataUcenici(int? id) async {
    setState(() {
      isLoading = true;
    });

    var data = await _userProvider.getById2(id);

    setState(() {
      listaUcenika = data;
      filteredListUcenici = listaUcenika?.result ?? [];
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MasterScreen(
      title: "e-Mekteb",
      child: SingleChildScrollView(
        child: Column(
          children: [
            greetingCard(),
            gridMenu()
          ],
        ),
      ),
    );
  }

  Widget greetingCard() {
    return Padding(
      padding: const EdgeInsets.all(22.0),
      child: Container(
        padding: const EdgeInsets.all(22.0),
        decoration: BoxDecoration(
          color: const Color(0xFF048A95),
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Esselamu alejkum, ',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  samoIme,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30.0),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<User>(
                  value: selectedUcenik != null ? filteredListUcenici.firstWhere((ucenik) => ucenik.ime == selectedUcenik) : null,
                  hint: Text(
                    'Odaberi dijete',
                    style: TextStyle(color: Colors.orange.shade800),
                  ),
                  icon: Icon(
                    Icons.arrow_drop_down,
                    color: Colors.orange.shade800,
                  ),
                  items: filteredListUcenici.map((ucenik) {
                    return DropdownMenuItem<User>(
                      value: ucenik,
                      child: Text(ucenik.ime), // Assuming 'ime' is the child's name field
                    );
                  }).toList(),
                  onChanged: (User? value) {
                    setState(() {
                      selectedUcenik = value?.ime;
                    });
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget gridMenu() {
    final List<Map<String, dynamic>> menuItems = [
      {'title': 'Obavijesti', 'icon': Icons.lightbulb, 'color': Colors.yellow.shade600},
      {'title': 'Uspjeh', 'icon': Icons.emoji_events, 'color': Colors.green.shade600},
      {'title': 'Kamp', 'icon': Icons.sports_basketball_sharp, 'color': Colors.orange},
      {'title': 'Prisustvo', 'icon': Icons.percent, 'color': Colors.cyan.shade400},
    ];

    return Padding(
      padding: const EdgeInsets.fromLTRB(22, 0, 22, 22),
      child: GridView.builder(
        physics: const NeverScrollableScrollPhysics(), // Disable grid scrolling
        shrinkWrap: true, // Fit grid to its content size
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 16.0,
          crossAxisSpacing: 16.0,
          childAspectRatio: 1.0,
        ),
        itemCount: menuItems.length,
        itemBuilder: (context, index) {
          final item = menuItems[index];
          return InkWell(
            onTap: () {
              // Check the item title and navigate to the respective screen
              switch (item['title']) {
                case 'Obavijesti':
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const ObavijestiScreen()),
                  );
                  break;
                case 'Uspjeh':
                  if (selectedUcenik != null) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => RoditeljUspjehScreen(
                          ucenik: filteredListUcenici.firstWhere(
                                (ucenik) => ucenik.ime == selectedUcenik,
                          ),
                        ),
                      ),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Molimo vas odaberite dijete.'),
                      ),
                    );
                  }
                  break;
                case 'Kamp':
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const KampRoditeljScreen()),
                  );
                  break;
                case 'Prisustvo':
                  if (selectedUcenik != null) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => RoditeljPrisustvoScreen(
                          ucenik: filteredListUcenici.firstWhere(
                                (ucenik) => ucenik.ime == selectedUcenik,
                          ),
                        ),
                      ),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Molimo vas odaberite dijete.'),
                      ),
                    );
                  }
                  break;
                default:
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('${item['title']} clicked')),
                  );
              }
            },
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    spreadRadius: 2,
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    item['icon'],
                    size: 70.0,
                    color: item['color'],
                  ),
                  const SizedBox(height: 12.0),
                  Text(
                    item['title'],
                    style: const TextStyle(
                      fontSize: 16.0,
                      color: Colors.black87,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

}
