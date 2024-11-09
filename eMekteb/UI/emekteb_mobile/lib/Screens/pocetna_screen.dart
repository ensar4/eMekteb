
import 'package:emekteb_mobile/Screens/dnevnik_screen.dart';
import 'package:emekteb_mobile/Screens/kamp_screen.dart';
import 'package:emekteb_mobile/Screens/lekcija_screen.dart';
import 'package:emekteb_mobile/Screens/profil_screen.dart';
import 'package:emekteb_mobile/Screens/ucenici_insert_screen.dart';
import 'package:emekteb_mobile/Screens/ucenici_screen.dart';
import 'package:emekteb_mobile/Widgets/master_screen.dart';
import 'package:emekteb_mobile/utils/util.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/korisnik.dart';
import '../models/searches/search_result.dart';
import '../models/slika.dart';
import '../providers/slika_provider.dart';
import '../providers/user_provider.dart';
import 'login_screen.dart';
import 'obavijesti_screen.dart';

class Pocetna extends StatefulWidget {
  const Pocetna({super.key});

  @override
  State<Pocetna> createState() => _PocetnaState();
}

class _PocetnaState extends State<Pocetna> {
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

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _userProvider = context.read<UserProvider>();
    _slikaProvider = context.read<SlikaProvider>();
    if (_userProvider.user == null) {
      _userProvider.getKorisnik(Korisnik.id).then((_) {
        fetchData(_userProvider.user?.id);
      });
    } else {
      fetchData(_userProvider.user?.id);
    }
  }

  Future<void> fetchData(int? id) async {
      SearchResult<dynamic> result = await _slikaProvider.getById2(id);
      if (result.result.isNotEmpty) {
        setState(() {
          slikaBytes = result.result[0].slikaBytes;
        });
      }
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
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Esselamu alejkum,',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4.0),
                  Text(
                    samoIme,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8.0),
                   Text(
                     Korisnik.uloge.toString().replaceAll('[', '').replaceAll(']', ''),
                     style: const TextStyle(
                      color: Colors.white,
                      fontSize: 14.0,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: 70,
              height: 70,
              decoration: BoxDecoration(
                color: Colors.white, // Background color
                shape: BoxShape.circle, // Makes the container circular
                image: DecorationImage(
                  image: slikaBytes.isNotEmpty
                      ? imageFromBase64String(slikaBytes) // Use decoded image if available
                      : const AssetImage("assets/images/profilnaB.png") as ImageProvider, // Fallback image from assets
                  fit: BoxFit.cover, // Fit image within the circle
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
      {
        'title': 'Obavijesti',
        'image': 'assets/images/obavijest.png',
        'icon': Icons.lightbulb,
        'color': Colors.yellow.shade600,
      },
      {
        'title': 'Učenici',
        'image': 'assets/images/ucenici.png',
        'icon': Icons.emoji_events,
        'color': Colors.orange,
      },
      {
        'title': 'Dnevnik',
        'image': 'assets/images/dnevnik.png',
        'icon': Icons.book,
        'color': Colors.purple.shade600,
      },
      {
        'title': 'Kamp',
        'image': 'assets/images/tenis.png',
        'icon': Icons.sports_basketball_sharp,
        'color': Colors.cyan.shade400,
      },
      {
        'image': 'assets/images/upis.png',
        'title': 'Upis u mekteb',
        'icon': Icons.app_registration,
        'color': Colors.green.shade600,
      },
      {
        'image': 'assets/images/lekcije.png',
        'title': 'Dodatne lekcije',
        'icon': Icons.menu_book,
        'color': Colors.blue,
      },
      {
        'image': 'assets/images/profil.png',
        'title': 'Moj profil',
        'icon': Icons.person,
        'color': Colors.green.shade600,
      },
      {
        'image': 'assets/images/logout.png',
        'title': 'Odjavi se',
        'icon': Icons.logout,
        'color': Colors.blue,
      },
    ];

    return Padding(
      padding: const EdgeInsets.fromLTRB(22, 0, 22, 22),
      child: GridView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
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
              // Handle navigation based on title
              switch (item['title']) {
                case 'Obavijesti':
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const ObavijestiScreen()),
                  );
                  break;
                case 'Učenici':
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const Ucenici()),
                  );
                  break;
                case 'Dnevnik':
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const Dnevnik()),
                  );
                  break;
                case 'Kamp':
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const Kamps()),
                  );
                  break;
                case 'Upis u mekteb':
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const UceniciInsert()),
                  );
                  break;
                case 'Dodatne lekcije':
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const Lekcija()),
                  );
                  case 'Moj profil':
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const ProfilScreen()),
                  );
                  case 'Odjavi se':
                     _logout(context);
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
                  // Display image or icon with fallback
                  item.containsKey('image')
                      ? Image.asset(
                    item['image'],
                    width: 80.0,
                    height: 80.0,
                    errorBuilder: (context, error, stackTrace) {
                      return Icon(
                        item['icon'],
                        size: 70.0,
                        color: item['color'],
                      );
                    },
                  )
                      : Icon(
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
  Future<void> _logout(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    Korisnik.reset();
    Provider.of<UserProvider>(context, listen: false).clearUser();
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => LoginPage(),
      ),
    );
  }
}
