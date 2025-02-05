import 'package:emekteb_admin/Screens/ak_godine_screen.dart';
import 'package:emekteb_admin/Screens/medzlisi_screen.dart';
import 'package:emekteb_admin/Screens/mektebii_screen.dart';
import 'package:emekteb_admin/Screens/postavke_screen.dart';
import 'package:emekteb_admin/Screens/statistika_screen.dart';
import 'package:emekteb_admin/Screens/takmicenja_screen.dart';
import 'package:emekteb_admin/Screens/ucenici_screen.dart';
import 'package:emekteb_admin/models/korisnik.dart';
import 'package:flutter/material.dart';
import 'package:emekteb_admin/Screens/mualimi_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../main.dart';

class MasterScreen extends StatefulWidget {
  final Widget? child;
  final String? title;
  final String? ime;

  const MasterScreen({this.child, this.title, this.ime, super.key});

  @override
  State<MasterScreen> createState() => _MasterScreenState();
}

class _MasterScreenState extends State<MasterScreen> {
  var samoIme = Korisnik.ime?.split(" ")[0] ?? "";

  @override
  Widget build(BuildContext context) {
    String userRole = getCurrentUserRole();
    bool isKomisija = userRole == "Komisija";
    bool isAdmin = userRole == "Admin";
    bool isSuperAdmin = userRole == "SuperAdmin";
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey.shade100,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(widget.title ?? ""),
            const Spacer(), // Add Spacer to push the following widgets to the right
            Text(
              "Esselamu alejkum, $samoIme",
              style: const TextStyle(
                fontSize: 16,
              ),
            ),
            const SizedBox(
              width: 15,
            ),
          ],
        ),
        bottom: const PreferredSize(
          preferredSize: Size.fromHeight(1.0),
          child: Divider(
            color: Colors.white,
            height: 1.0,
          ),
        ),
      ),
      drawer: Drawer(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(1),
              bottomRight: Radius.circular(1)),
        ),
        backgroundColor: Colors.cyan,
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              const SizedBox(
                height: 70,
                child: DrawerHeader(
                  child: Text(
                    'e-Mekteb',
                    style: TextStyle(color: Colors.white, fontSize: 26.0),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              if (!isKomisija && !isSuperAdmin)
                ListTile(
                  title: const Text('Mektebi', textAlign: TextAlign.center,  style: TextStyle(color: Colors.white, fontSize: 18.0),),
                  onTap: () => Navigator.of(context).pushReplacement(
                    //pushReplacement  ili   push
                    MaterialPageRoute(
                      builder: (context) => const Mektebi(),
                    ),
                  ),
                ),
              if (isSuperAdmin)
                ListTile(
                  title: const Text('Medžlisi', textAlign: TextAlign.center,  style: TextStyle(color: Colors.white, fontSize: 18.0),),
                  onTap: () => Navigator.of(context).pushReplacement(
                    //pushReplacement  ili   push
                    MaterialPageRoute(
                      builder: (context) => const Medzlisi(),
                    ),
                  ),
                ),
              if (!isKomisija)
                ListTile(
                  title: const Text('Muallimi', textAlign: TextAlign.center,  style: TextStyle(color: Colors.white, fontSize: 18.0),),
                  onTap: () => Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (context) => const Muallimi(),
                    ),
                  ),
                ),
              if (!isKomisija && !isSuperAdmin)
                ListTile(
                  title: const Text('Učenici', textAlign: TextAlign.center,  style: TextStyle(color: Colors.white, fontSize: 18.0),),
                  onTap: () => Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (context) => const Ucenici(),
                    ),
                  ),
                ),
              if (!isSuperAdmin)
              ListTile(
                title: const Text('Takmičenja', textAlign: TextAlign.center,  style: TextStyle(color: Colors.white, fontSize: 18.0),),
                onTap: () => Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => const Takmicenja(),
                  ),
                ),
              ),
              if (!isKomisija)
                ListTile(
                  title: const Text('Ak. godine', textAlign: TextAlign.center,  style: TextStyle(color: Colors.white, fontSize: 18.0),),
                  onTap: () => Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (context) => const AkGodine(),
                    ),
                  ),
                ),
              if (!isKomisija)
                ListTile(
                  title: const Text('Statistika', textAlign: TextAlign.center,  style: TextStyle(color: Colors.white, fontSize: 18.0),),
                  onTap: () => Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (context) => const Statistika(),
                    ),
                  ),
                ),
              const Spacer(), // Add Spacer to push the following widgets to the bottom
              ListTile(
                title: const Text('Postavke', textAlign: TextAlign.center,  style: TextStyle(color: Colors.white, fontSize: 18.0),),
                onTap: () => Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => const Postavke(),
                  ),
                ),
              ),
              ListTile(
                title: const Text('Odjavi se', textAlign: TextAlign.center,  style: TextStyle(color: Colors.white, fontSize: 18.0),),
                onTap: () => _logout(context),
              ),
            ],
          ),
        ),
      ),
      body: widget.child,
    );
  }

  Future<void> _logout(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    Korisnik.reset();
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => LoginPage(),
      ),
    );
  }


  String getCurrentUserRole() {
    if (Korisnik.uloge.contains("Komisija")) {
      return "Komisija";
    }
    else if (Korisnik.uloge.contains("Admin")){
      return "Admin";
    }
    else
      return "SuperAdmin";
  }
}
