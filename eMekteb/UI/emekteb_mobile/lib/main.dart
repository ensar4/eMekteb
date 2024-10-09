import 'package:emekteb_mobile/providers/admin_provider.dart';
import 'package:emekteb_mobile/providers/akademskagodina_provider.dart';
import 'package:emekteb_mobile/providers/auth_provider.dart';
import 'package:emekteb_mobile/providers/cas_provider.dart';
import 'package:emekteb_mobile/providers/kamp_provider.dart';
import 'package:emekteb_mobile/providers/kampkorisnik_provider.dart';
import 'package:emekteb_mobile/providers/kategorija_provider.dart';
import 'package:emekteb_mobile/providers/obavijest_provider.dart';
import 'package:emekteb_mobile/providers/razred_korisnik_provider.dart';
import 'package:emekteb_mobile/providers/razred_provider.dart';
import 'package:emekteb_mobile/providers/ocjene_provider.dart';
import 'package:emekteb_mobile/providers/prisustvo_provider.dart';
import 'package:emekteb_mobile/providers/slika_provider.dart';
import 'package:emekteb_mobile/providers/takmicar_provider.dart';
import 'package:emekteb_mobile/providers/user_provider.dart';
import 'package:emekteb_mobile/providers/medzlis_provider.dart';
import 'package:emekteb_mobile/providers/mekteb_provider.dart';
import 'package:emekteb_mobile/providers/mualim_provider.dart';
import 'package:emekteb_mobile/providers/password_provider.dart';
import 'package:emekteb_mobile/providers/dodatnalekcija_provider.dart';
import 'package:emekteb_mobile/providers/takmicenja_provider.dart';
import 'package:emekteb_mobile/providers/ucenici_provider.dart';
import 'package:emekteb_mobile/providers/zadaca_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:io';

import 'Screens/login_screen.dart';
void main() {
  HttpOverrides.global = MyHttpOverrides();
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (_)=> AuthProvider()),
    ChangeNotifierProvider(create: (_)=> MektebProvider()),
    ChangeNotifierProvider(create: (_)=> AkademskagodinaProvider()),
    ChangeNotifierProvider(create: (_)=> TakmicenjaProvider()),
    ChangeNotifierProvider(create: (_)=> TakmicarProvider()),
    ChangeNotifierProvider(create: (_)=> CasProvider()),
    ChangeNotifierProvider(create: (_)=> KategorijaProvider()),
    ChangeNotifierProvider(create: (_)=> DodatnaLekcijaProvider()),
    ChangeNotifierProvider(create: (_)=> UceniciProvider()),
    ChangeNotifierProvider(create: (_)=> MualimProvider()),
    ChangeNotifierProvider(create: (_)=> MedzlisProvider()),
    ChangeNotifierProvider(create: (_)=> PasswordProvider()),
    ChangeNotifierProvider(create: (_)=> UserProvider()),
    ChangeNotifierProvider(create: (_)=> AdminProvider()),
    ChangeNotifierProvider(create: (_)=> KampProvider()),
    ChangeNotifierProvider(create: (_)=> KampKorisnikProvider()),
    ChangeNotifierProvider(create: (_)=> RazredProvider()),
    ChangeNotifierProvider(create: (_)=> PrisustvoProvider()),
    ChangeNotifierProvider(create: (_)=> OcjeneProvider()),
    ChangeNotifierProvider(create: (_)=> ZadacaProvider()),
    ChangeNotifierProvider(create: (_)=> ObavijestProvider()),
    ChangeNotifierProvider(create: (_)=> SlikaProvider()),
    ChangeNotifierProvider(create: (_)=> RazredKorisnikProvider()),




  ],
  child: const MyApp(),));
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
           //brightness: Brightness.light,
           seedColor: Colors.white,
         ),
          useMaterial3: true,
        ),

        home: LoginPage(),
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




