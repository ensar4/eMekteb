import 'package:emekteb_mobile/Screens/obavijesti_screen.dart';
import 'package:emekteb_mobile/Screens/pocetna_screen.dart';
import 'package:emekteb_mobile/Screens/ucenik_pocetna_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/korisnik.dart';
import '../providers/auth_provider.dart';
import '../providers/password_provider.dart';
import '../providers/user_provider.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});
  late AuthProvider _authProvider;
  late UserProvider _userProvider;
  late PasswordProvider _passwordProvider;

  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    _authProvider = context.read<AuthProvider>();
    _userProvider = context.read<UserProvider>();
    _passwordProvider = context.read<PasswordProvider>();

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
                  const SizedBox(height: 15,),
                  SizedBox(
                    width: 300,
                    child: ElevatedButton(
                      onPressed: () async {
                        if (_usernameController.text.isEmpty) {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) => AlertDialog(
                              title: const Text("Greška"),
                              shape: Border.symmetric(),
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
                                shape: Border.symmetric(),
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
                              shape: Border.symmetric(),
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
                  Focus(
                    skipTraversal: true,
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () async {
                          final TextEditingController emailController = TextEditingController();
                          bool isLoading = false;

                          await showDialog(
                            context: context,
                            barrierDismissible: !isLoading,
                            builder: (context) {
                              return StatefulBuilder(
                                builder: (context, setState) {
                                  return AlertDialog(
                                    title: Text('Reset lozinke'),
                                    shape: Border.symmetric(),
                                    content: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        TextField(
                                          controller: emailController,
                                          keyboardType: TextInputType.emailAddress,
                                          decoration: InputDecoration(
                                            labelText: 'Unesite vašu email adresu!',
                                          ),
                                          enabled: !isLoading,
                                        ),
                                        if (isLoading)
                                          Padding(
                                            padding: const EdgeInsets.only(top: 16.0),
                                            child: CircularProgressIndicator(),
                                          ),
                                      ],
                                    ),
                                    actions: [
                                      TextButton(
                                        onPressed: isLoading
                                            ? null
                                            : () => Navigator.of(context).pop(),
                                        child: Text(
                                          'Otkaži',
                                          style: TextStyle(color: Colors.red, fontSize: 16),
                                        ),
                                      ),
                                      TextButton(
                                        onPressed: isLoading
                                            ? null
                                            : () async {
                                          final email = emailController.text.trim();

                                          if (email.isEmpty) {
                                            Navigator.of(context).pop();
                                            ScaffoldMessenger.of(context).showSnackBar(
                                              SnackBar(content: Text('Email adresa je obavezna.')),
                                            );
                                            return;
                                          }

                                          setState(() => isLoading = true);

                                          try {
                                            await Provider.of<PasswordProvider>(
                                              context,
                                              listen: false,
                                            ).resetPassword(email);

                                            Navigator.of(context).pop();
                                            ScaffoldMessenger.of(context).showSnackBar(
                                              SnackBar(
                                                content: Text('Nova lozinka je poslana na vaš email.'),
                                              ),
                                            );
                                          } catch (e) {
                                            Navigator.of(context).pop();
                                            ScaffoldMessenger.of(context).showSnackBar(
                                              SnackBar(content: Text(e.toString())),
                                            );
                                          } finally {
                                            setState(() => isLoading = false);
                                          }
                                        },
                                        child: Text(
                                          'Pošalji',
                                          style: TextStyle(fontSize: 16),
                                        ),
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                          );
                        },
                        child: Text(
                          "Zaboravljena lozinka?",
                          style: TextStyle(
                            color: Colors.blue.shade800, // Make it look like a link
                            fontSize: 12,
                          ),
                        ),
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
