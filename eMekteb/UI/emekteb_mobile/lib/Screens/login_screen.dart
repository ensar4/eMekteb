import 'package:emekteb_mobile/Screens/obavijesti_screen.dart';
import 'package:emekteb_mobile/Screens/pocetna_screen.dart';
import 'package:emekteb_mobile/Screens/ucenik_pocetna_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/korisnik.dart';
import '../providers/auth_provider.dart';
import '../providers/user_provider.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});
  late AuthProvider _authProvider;
  late UserProvider _userProvider;

  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    _authProvider = context.read<AuthProvider>();
    _userProvider = context.read<UserProvider>();
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            constraints: const BoxConstraints(maxHeight: 700, maxWidth: 300),
            child: Padding(
              padding: const EdgeInsets.only(top: 40.0),
              child: Column(
                children: [
                  Image.asset("assets/images/login.png", width: 180, height: 180,),
                  const Text("e-Mekteb", style: TextStyle(fontSize: 40, color: Color(0xFF048A95)),),
                  const SizedBox(height: 30,),
                  TextField(
                    decoration: const InputDecoration(
                      labelText: "Korisničko ime",
                      border: OutlineInputBorder(
                      ),
                    ),
                    controller: _usernameController,
                  ),
                  const SizedBox(height: 15,),
                  TextField(
                    decoration: const InputDecoration(
                      labelText: "Lozinka",
                      border: OutlineInputBorder(
                      ),
                    ),
                    controller: _passwordController,
                    obscureText: true,
                  ),
                  const SizedBox(height: 30,),
                  SizedBox(
                    width: 150,
                    child: ElevatedButton(
                      onPressed: () async {
                        if (_usernameController.text.isEmpty) {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) => AlertDialog(
                              title: const Text("Greška"),
                              content: const Text("Korisničko ime ne može biti prazno."),
                              actions: [
                                TextButton(
                                  onPressed: () => Navigator.pop(context),
                                  child: const Text("OK"),
                                ),
                              ],
                            ),
                          );
                          return;
                        }

                        try {
                          var token = await _authProvider.login(
                            _usernameController.text,
                            _passwordController.text,
                          );
                          _authProvider.getUser(token!);
                          _userProvider.getKorisnik(Korisnik.id);
                          if (Korisnik.uloge.contains("Imam") || Korisnik.uloge.contains("Ucenik") || Korisnik.uloge.contains("Roditelj")) {
                            if (Korisnik.uloge.contains("Imam")) {
                              Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                  builder: (context) => const Pocetna(),
                                ),
                              );
                            } else if (Korisnik.uloge.contains("Ucenik")) {
                              Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                  builder: (context) => const UcenikPocetna(),
                                ),
                              );
                            } else if (Korisnik.uloge.contains("Roditelj")) {
                              Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                  builder: (context) => const ObavijestiScreen(),
                                ),
                              );
                            }
                          } else {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) => AlertDialog(
                                title: const Text("Greška"),
                                content: const Text("Prijava nije moguća."),
                                actions: [
                                  TextButton(
                                    onPressed: () => Navigator.pop(context),
                                    child: const Text("OK"),
                                  ),
                                ],
                              ),
                            );
                            _usernameController.clear();
                            _passwordController.clear();
                          }
                        } catch (e) {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) => AlertDialog(
                              title: const Text("Greška"),
                              content: Text(e.toString()), // Display the exception message only
                              actions: [
                                TextButton(
                                  onPressed: () => Navigator.pop(context),
                                  child: const Text("OK"),
                                ),
                              ],
                            ),
                          );
                          _passwordController.clear();
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(2.0), // Border radius
                        ),
                        padding: const EdgeInsets.only(
                          left: 24.0, right: 24.0, top: 12.0, bottom: 12.0,
                        ), // Padding
                      ),
                      child: const Text(
                        "PRIJAVA",
                        style: TextStyle(fontSize: 18),
                      ),
                    ),

                  ),
                ],
              ),
            ),
          
          ),
        ),
      ),

    );
  }

}
