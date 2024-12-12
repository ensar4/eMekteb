
import 'package:emekteb_mobile/Screens/dnevnik_screen.dart';
import 'package:emekteb_mobile/Screens/kamp_screen.dart';
import 'package:emekteb_mobile/Screens/lekcija_screen.dart';
import 'package:emekteb_mobile/Screens/postavke_screen.dart';
import 'package:emekteb_mobile/Screens/prisustvo_screen.dart';
import 'package:emekteb_mobile/Screens/profil_screen.dart';
import 'package:emekteb_mobile/Screens/ucenici_insert_screen.dart';
import 'package:emekteb_mobile/Screens/ucenici_screen.dart';
import 'package:emekteb_mobile/Screens/uspjeh_screen.dart';
import 'package:emekteb_mobile/Screens/zadaca_screen.dart';
import 'package:emekteb_mobile/Widgets/master_screen.dart';
import 'package:emekteb_mobile/models/user.dart';
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

class UcenikPocetna extends StatefulWidget {
  const UcenikPocetna({super.key});

  @override
  State<UcenikPocetna> createState() => _UcenikPocetnaState();
}
class _UcenikPocetnaState extends State<UcenikPocetna> {
  late UserProvider _userProvider;
  late SlikaProvider _slikaProvider;
  var samoIme = "";
  bool isLoading = true; // Add a loading state
  String slikaBytes = '';

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _userProvider = context.read<UserProvider>();
    _slikaProvider = context.read<SlikaProvider>();

    if (_userProvider.user == null) {
      _userProvider.getKorisnik(Korisnik.id).then((_) {
        fetchData(_userProvider.user?.id).then((_) {
          setState(() {
            samoIme = _userProvider.user?.ime?.split(" ")[0] ?? "";
            isLoading = false; // Data is ready
          });
        });
      });
    } else {
      fetchData(_userProvider.user?.id).then((_) {
        setState(() {
          samoIme = _userProvider.user?.ime?.split(" ")[0] ?? "";
          isLoading = false; // Data is ready
        });
      });
    }
  }

  Future<void> fetchData(int? id) async {
    if (id == null) return;
    SearchResult<dynamic> result = await _slikaProvider.getById2(id);
    if (result.result.isNotEmpty) {
      setState(() {
        slikaBytes = result.result[0].slikaBytes;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      // Show a loading indicator while data is being fetched
      return Center(
        child: CircularProgressIndicator(),
      );
    }

    return MasterScreen(
      title: "e-Mekteb",
      child: SingleChildScrollView(
        child: Column(
          children: [
            greetingCard(),
            gridMenu(),
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
                    _userProvider.user?.nazivRazreda.toString() ?? "N/A",
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 14.0,
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            LinearProgressIndicator(
                              value: (_userProvider.user?.prisustvo ?? 0) / 100,
                              backgroundColor: Colors.white.withOpacity(0.3),
                              color: Colors.orange,
                              minHeight: 4.0,
                            ),
                            const SizedBox(height: 4.0),
                            Text(
                              '${_userProvider.user?.prisustvo?.toStringAsFixed(0) ?? '0'}%',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 12.0,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              width: 70,
              height: 70,
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: slikaBytes.isNotEmpty
                      ? imageFromBase64String(slikaBytes)
                      : const AssetImage("assets/images/profilnaB.png") as ImageProvider,
                  fit: BoxFit.cover,
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
      {'title': 'Obavijesti', 'image': 'assets/images/obavijest.png', 'icon': Icons.lightbulb, 'color': Colors.yellow.shade600},
      {'title': 'Uspjeh', 'image': 'assets/images/uspjeh.png', 'icon': Icons.emoji_events, 'color': Colors.green.shade600},
      {'title': 'Zadaća', 'image': 'assets/images/dnevnik.png', 'icon': Icons.book, 'color': Colors.purple.shade600},
      {'title': 'Prisustvo', 'image': 'assets/images/prisustvo.png','icon': Icons.percent, 'color': Colors.cyan.shade400},
      {'title': 'Moj profil', 'image': 'assets/images/profil.png', 'icon': Icons.person, 'color': Colors.orange},
      {'title': 'Lekcije', 'image': 'assets/images/lekcije.png', 'icon': Icons.menu_book, 'color': Colors.blue},
      {'title': 'Postavke', 'image': 'assets/images/settings.png', 'icon': Icons.settings, 'color': Colors.blue},
      {'title': 'Odjavi se', 'image': 'assets/images/logout.png', 'icon': Icons.logout, 'color': Colors.blue},
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
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const UspjehScreen()),
                  );
                  break;
                case 'Zadaća':
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const ZadacaScreen()),
                  );
                  break;
                case 'Prisustvo':
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const PrisustvoScreen()),
                  );
                  break;
                case 'Moj profil':
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const ProfilScreen()),
                  );
                  break;
                case 'Lekcije':
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const Lekcija()),
                  );
                  break;
                case 'Postavke':
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const Postavke()),
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
