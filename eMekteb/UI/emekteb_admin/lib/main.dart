import 'dart:io';
import 'package:emekteb_admin/Screens/mektebii_screen.dart';
import 'package:emekteb_admin/Screens/takmicenja_screen.dart';
import 'package:emekteb_admin/models/korisnik.dart';
import 'package:emekteb_admin/providers/admin_provider.dart';
import 'package:emekteb_admin/providers/akademskagodina_provider.dart';
import 'package:emekteb_admin/providers/akademskamekteb_provider.dart';
import 'package:emekteb_admin/providers/akademskarazred_provider.dart';
import 'package:emekteb_admin/providers/auth_provider.dart';
import 'package:emekteb_admin/providers/kategorija_provider.dart';
import 'package:emekteb_admin/providers/komisija_provider.dart';
import 'package:emekteb_admin/providers/medzlis_provider.dart';
import 'package:emekteb_admin/providers/mekteb_provider.dart';
import 'package:emekteb_admin/providers/mualim_provider.dart';
import 'package:emekteb_admin/providers/password_provider.dart';
import 'package:emekteb_admin/providers/razred_provider.dart';
import 'package:emekteb_admin/providers/takmicar_provider.dart';
import 'package:emekteb_admin/providers/takmicenja_provider.dart';
import 'package:emekteb_admin/providers/ucenici_provider.dart';
import 'package:flutter/material.dart';
import 'package:window_manager/window_manager.dart';
import 'package:provider/provider.dart';

//void main() {
//  runApp(MultiProvider(providers: [
//    ChangeNotifierProvider(create: (_)=> AuthProvider()),
//    ChangeNotifierProvider(create: (_)=> MektebProvider()),
//    ChangeNotifierProvider(create: (_)=> AkademskagodinaProvider()),
//    ChangeNotifierProvider(create: (_)=> TakmicenjaProvider()),
//    ChangeNotifierProvider(create: (_)=> KategorijaProvider()),
//    ChangeNotifierProvider(create: (_)=> TakmicarProvider()),
//    ChangeNotifierProvider(create: (_)=> UceniciProvider()),
//    ChangeNotifierProvider(create: (_)=> MualimProvider()),
//    ChangeNotifierProvider(create: (_)=> MedzlisProvider()),
//    ChangeNotifierProvider(create: (_)=> PasswordProvider()),
//    ChangeNotifierProvider(create: (_)=> KomisijaProvider()),
//    ChangeNotifierProvider(create: (_)=> AdminProvider()),
//    ChangeNotifierProvider(create: (_)=> AkademskaMektebProvider()),
//    ChangeNotifierProvider(create: (_)=> AkademskaRazredProvider()),
//    ChangeNotifierProvider(create: (_)=> RazredProvider()),
//
//
//
//
//
//
//
//
//
//  ],
//
//  child: const MyApp(),));
//}


void main() async {
  HttpOverrides.global = MyHttpOverrides();

  WidgetsFlutterBinding.ensureInitialized();


  await windowManager.ensureInitialized();


  windowManager.waitUntilReadyToShow().then((_) async {
    await windowManager.setMinimumSize(const Size(1600, 900));
    await windowManager.setMaximizable(true);

    windowManager.show();
  });

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => MektebProvider()),
        ChangeNotifierProvider(create: (_) => AkademskagodinaProvider()),
        ChangeNotifierProvider(create: (_) => TakmicenjaProvider()),
        ChangeNotifierProvider(create: (_) => KategorijaProvider()),
        ChangeNotifierProvider(create: (_) => TakmicarProvider()),
        ChangeNotifierProvider(create: (_) => UceniciProvider()),
        ChangeNotifierProvider(create: (_) => MualimProvider()),
        ChangeNotifierProvider(create: (_) => MedzlisProvider()),
        ChangeNotifierProvider(create: (_) => PasswordProvider()),
        ChangeNotifierProvider(create: (_) => KomisijaProvider()),
        ChangeNotifierProvider(create: (_) => AdminProvider()),
        ChangeNotifierProvider(create: (_) => AkademskaMektebProvider()),
        ChangeNotifierProvider(create: (_) => AkademskaRazredProvider()),
        ChangeNotifierProvider(create: (_) => RazredProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'RS2',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            brightness: Brightness.light,
            seedColor: Colors.cyan.shade700,
          ),
          useMaterial3: true,
        ),

        home: LoginPage(),
    );
  }
}

class LoginPage extends StatelessWidget {
   LoginPage({super.key});

   late AuthProvider _authProvider;
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    _authProvider = context.read<AuthProvider>();
    return Scaffold(
      body: Center(
        child: Container(
          constraints: const BoxConstraints(maxHeight: 900, maxWidth: 400),
           child: Padding(
             padding: const EdgeInsets.only(top: 30.0),
             child: Column(
              children: [
                Image.asset("assets/images/login.png", width: 200, height: 200,),
                const Text("e-Mekteb", style: TextStyle(fontSize: 40),),
                const SizedBox(height: 80,),
                TextField(
                  decoration: const InputDecoration(
                    labelText: "Korisničko ime",
                    border: OutlineInputBorder(
                       //borderRadius: BorderRadius.circular(8.0),
                   ),
                 ),
                  controller: _usernameController,
                ),
                const SizedBox(height: 15,),
                TextField(
                  decoration: const InputDecoration(
                    labelText: "Lozinka",
                    border: OutlineInputBorder(
                      //borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  controller: _passwordController,
                  obscureText: true, // set this property to true
                  ),
                const SizedBox(height: 30,),
                ElevatedButton(
                  onPressed: () async {
                    try {
                      var token = await _authProvider.login(
                        _usernameController.text,
                        _passwordController.text,
                      );

                       _authProvider.getUser(token);
                      if( Korisnik.uloge.contains("Komisija")){
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            builder: (context) => const Takmicenja(),
                          ),
                        );
                      }
                      else if (Korisnik.uloge.contains("Admin")){
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            builder: (context) => const Mektebi(),
                          ),
                        );
                      } else {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) => AlertDialog(
                              title: const Text("Greška"),
                              content: const Text("Prijava nije moguća."),
                              actions: [
                                TextButton(
                                    onPressed: () => Navigator.pop(context),
                                    child: const Text("OK"))
                              ],
                            ));
                            _usernameController.clear();
                            _passwordController.clear();
                      }
                    } catch (e) {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) => AlertDialog(
                            title: const Text("Greška"),
                            content: Text("$e"),
                            actions: [
                              TextButton(
                                  onPressed: () => Navigator.pop(context),
                                  child: const Text("OK"))
                            ],
                          ));
                      _usernameController.clear();
                      _passwordController.clear();
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    shape: const RoundedRectangleBorder(
                     // borderRadius: BorderRadius.circular(8.0), // Border radius
                    ),
                    padding: const EdgeInsets.only(left: 32.0, right: 32.0, top: 16.0, bottom: 16.0),
                    // Padding
                  ),
                  child: const Text("PRIJAVA", style: TextStyle(fontSize: 16), ),

                ),
              ],
             ),
           ),

        ),
      ),

    );
  }

}

class MyHttpOverrides extends HttpOverrides{
  @override
  HttpClient createHttpClient(SecurityContext? context){
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port)=> true;
  }
}



