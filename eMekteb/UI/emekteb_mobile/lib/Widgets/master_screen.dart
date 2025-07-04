import 'package:emekteb_mobile/Screens/lekcija_screen.dart';
import 'package:emekteb_mobile/Screens/obavijesti_screen.dart';
import 'package:emekteb_mobile/Screens/pocetna_screen.dart';
import 'package:emekteb_mobile/Screens/postavke_screen.dart';
import 'package:emekteb_mobile/Screens/prisustvo_screen.dart';
import 'package:emekteb_mobile/Screens/roditelj_kamp_screen.dart';
import 'package:emekteb_mobile/Screens/roditelj_pocetna_screen.dart';
import 'package:emekteb_mobile/Screens/select_ucenici_screen.dart';
import 'package:emekteb_mobile/Screens/kamp_screen.dart';
import 'package:emekteb_mobile/Screens/ucenici_insert_screen.dart';
import 'package:emekteb_mobile/Screens/ucenici_screen.dart';
import 'package:emekteb_mobile/Screens/ucenik_pocetna_screen.dart';
import 'package:emekteb_mobile/Screens/uspjeh_screen.dart';
import 'package:emekteb_mobile/Screens/zadaca_screen.dart';
import 'package:emekteb_mobile/models/korisnik.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Screens/dnevnik_screen.dart';
import '../Screens/login_screen.dart';
import '../Screens/profil_screen.dart';
import '../Screens/takmicenje_prijava_screen.dart';
import '../providers/user_provider.dart';

class MasterScreen extends StatefulWidget {
  Widget? child;
  String? title;
  String? ime;
  //String? fullName = Korisnik.ime?.split(" ")[0] ?? "";

  MasterScreen({this.child, this.title, this.ime, super.key});

  @override
  State<MasterScreen> createState() => _MasterScreenState();
}

//title: Text(widget.title ?? ""),
class _MasterScreenState extends State<MasterScreen> {
  int _selectedIndex = 0; // Keeps track of the currently selected tab

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  // Define the list of screens
  final List<Widget> _screens = [
    const Kamps(),
    const Dnevnik(),
    const Ucenici(),
    const Postavke(),
  ];

  @override
  Widget build(BuildContext context) {
    String userRole = getCurrentUserRole();
    bool isRoditelj = userRole == "Roditelj";
    bool isUcenik = userRole == "Ucenik";

    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: Color(0xFF048A95),
        title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Spacer(),
              Text(widget.title ?? "", style: TextStyle(color: Colors.white),),
              Spacer(),
              IconButton(
                icon: Icon(
                  Icons.notifications,
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          ObavijestiScreen(),
                    ),
                  );
                },
              ),
            ]
        ),
        bottom: const PreferredSize(
          preferredSize: Size.fromHeight(1.0),
          child: Divider(
            color: Colors.white,
            height: 1.0,
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        showSelectedLabels: false,
        showUnselectedLabels: false,
        backgroundColor: Colors.grey.shade400,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white,
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
            //print(index);
          });
          switch (index) {
            case 0:
              if (isRoditelj) {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => const RoditeljPocetna()),
                );
              } else if (isUcenik) {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => const UcenikPocetna()),
                );
              } else {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => const Pocetna()),
                );
              }
              break;
            case 1:
              if (isRoditelj) {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => const KampRoditeljScreen()),
                );
              } else if (isUcenik) {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => const ZadacaScreen()),
                );
              } else {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => const Dnevnik()),
                );
              }
              break;
            case 2:
              if (isRoditelj) {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => const Postavke()),
                );
              } else if (!isUcenik) {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => const SelectUcenici()),
                );
              } else {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => const PrisustvoScreen()),
                );
              }
              break;
            case 3:
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => const ProfilScreen()),
              );
              break;
          }
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_rounded),
            label: '',
          ),
          if (isRoditelj)
            BottomNavigationBarItem(
              icon: Icon(Icons.sports_basketball_sharp),
              label: '',
            ),
          if (!isRoditelj)
            BottomNavigationBarItem(
              icon: Icon(Icons.book),
              label: '',
            ),
          if (!isUcenik && !isRoditelj)
            BottomNavigationBarItem(
              icon: Icon(Icons.people),
              label: '',
            ),
          if (isRoditelj)
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label: '',
            ),
          if (isUcenik)
            BottomNavigationBarItem(
              icon: Icon(Icons.percent),
              label: '',
            ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: '',
          ),
        ],
      ),
      // Updated body to handle both child and tab navigation
      body: widget.child ??
          IndexedStack(
            index:
            _selectedIndex,
            // Show the screen corresponding to the selected index
            children: _screens,
          ),
      drawer: Drawer(
        backgroundColor: Colors.white,
        child: Padding(
          padding: EdgeInsets.all(31.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              const SizedBox(
                height: 90,
                child: DrawerHeader(
                  child: Text(
                    'e-Mekteb',
                    style: TextStyle(color: Colors.black, fontSize: 20.0),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              if (!isUcenik && !isRoditelj)
                ListTile(
                  title: const Text('Dnevnik', textAlign: TextAlign.center),
                  onTap: () =>
                      Navigator.of(context).pushReplacement(
                        //pushReplacement  ili   push
                        MaterialPageRoute(
                          builder: (context) => const Dnevnik(),
                        ),
                      ),
                ),
              if (!isRoditelj)
                ListTile(
                  title: const Text('Lekcije', textAlign: TextAlign.center),
                  onTap: () =>
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (context) => const Lekcija(),
                        ),
                      ),
                ),
              if (isUcenik)
              ListTile(
                title: const Text('Zadaća', textAlign: TextAlign.center),
                onTap: () =>
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (context) => const ZadacaScreen(),
                      ),
                    ),
              ),
              if (isUcenik)
              ListTile(
                title: const Text('Uspjeh', textAlign: TextAlign.center),
                onTap: () =>
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (context) => const UspjehScreen(),
                      ),
                    ),
              ),
              if (isUcenik)
              ListTile(
                title: const Text('Prisustvo', textAlign: TextAlign.center),
                onTap: () =>
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (context) => const PrisustvoScreen(),
                      ),
                    ),
              ),
              if (!isUcenik && !isRoditelj)
              ListTile(
                title: const Text('Učenici', textAlign: TextAlign.center),
                onTap: () =>
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (context) => const SelectUcenici(),
                      ),
                    ),
              ),
              if (!isUcenik && !isRoditelj)
                ListTile(
                  title: const Text('Upis', textAlign: TextAlign.center),
                  onTap: () =>
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (context) => const UceniciInsert(),
                        ),
                      ),
                ),
                if (!isUcenik && !isRoditelj)
                  ListTile(
                    title: const Text('Kamp', textAlign: TextAlign.center),
                    onTap: () =>
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            builder: (context) => const Kamps(),
                          ),
                        ),
                  ),
              if (isRoditelj)
                ListTile(
                  title: const Text('Kamp', textAlign: TextAlign.center),
                  onTap: () =>
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (context) => const KampRoditeljScreen(),
                        ),
                      ),
                ),
                ListTile(
                  title: const Text('Obavijesti', textAlign: TextAlign.center),
                  onTap: () =>
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (context) => const ObavijestiScreen(),
                        ),
                      ),
                ),
              if (!isUcenik && !isRoditelj)
                ListTile(
                  title: const Text('Takmičenje', textAlign: TextAlign.center),
                  onTap: () =>
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (context) => const TakmicenjePrijava(),
                        ),
                      ),
                ),
              const Spacer(),
              ListTile(
                title: const Text('Moj profil', textAlign: TextAlign.center),
                onTap: () =>
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (context) => const ProfilScreen(),
                      ),
                    ),
              ),
              ListTile(
                title: const Text('Postavke', textAlign: TextAlign.center),
                onTap: () =>
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (context) => const Postavke(),
                      ),
                    ),
              ),
              ListTile(
                title: const Text('Odjavi se', textAlign: TextAlign.center),
                onTap: () => _logout(context),
              ),
            ],
          ),
        ),
      ),
      // body: widget.child,
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

  String getCurrentUserRole() {
    if (Korisnik.uloge.contains("Imam")) {
      print(Korisnik.uloge.toString());
      return "Imam";
    } else if (Korisnik.uloge.contains("Ucenik")) {
      return "Ucenik";
    } else {
      return "Roditelj";
    }
  }

}
