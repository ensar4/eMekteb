import 'package:emekteb_mobile/Widgets/master_screen.dart';
import 'package:emekteb_mobile/providers/password_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/korisnik.dart';
import '../models/searches/change_password_request.dart';

void main() {
  runApp(const Postavke());
}

class Postavke extends StatefulWidget {
  const Postavke({super.key});

  @override
  State<Postavke> createState() => _ProfilInfoState();
}

class _ProfilInfoState extends State<Postavke> {
  late PasswordProvider _passwordProvider;

  final TextEditingController _oldPasswordController = TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  @override
  Future<void> didChangeDependencies() async {
    super.didChangeDependencies();
    _passwordProvider = context.read<PasswordProvider>();
  }


  @override
  Widget build(BuildContext context) {
    return MasterScreen(
      title: "Postavke",
      child: SingleChildScrollView(
        child: Column(
          children: [
            _boxPassword(),
          ],
        ),
      ),
    );
  }


  Widget _boxPassword() {
    return Visibility(
      //visible: _isVisible,
      child: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Container(
         // width: 450,
          padding: const EdgeInsets.all(30.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20), // Adjust the radius as needed
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5), // Shadow color
                spreadRadius: 5, // Spread radius
                blurRadius: 7, // Blur radius
                offset: const Offset(0, 3), // Shadow position
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                'Izmjena lozinke:',
                style: TextStyle(fontSize: 22),
              ),
              const SizedBox(height: 20),
              _buildTextField('Stara lozinka:', _oldPasswordController),
              const SizedBox(height: 10),
              _buildTextField('Nova lozinka:', _newPasswordController),
              const SizedBox(height: 10),
              _buildTextField('Potvrda lozinke:', _confirmPasswordController),
              const SizedBox(height: 20),
              Align(
                alignment: Alignment.center,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepOrange, // Set the button color to orange
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 36.0, vertical: 12.0),
                  ),
                  onPressed: () async {
                    if (_newPasswordController.text == _confirmPasswordController.text) {
                      try {
                        var request = ChangePasswordRequest(
                          userId: Korisnik.id, // Replace with the actual userId
                          oldPassword: _oldPasswordController.text,
                          newPassword: _newPasswordController.text,
                        );
                        await _passwordProvider.changePassword(request);
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Lozinka uspješno promijenjena')),
                        );
                        _oldPasswordController.clear();
                        _newPasswordController.clear();
                        _confirmPasswordController.clear();
                      } catch (e) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Nije moguće promjeniti lozinku: $e')),
                        );
                      }
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Netačna potvrda lozinke')),

                      );
                      _newPasswordController.clear();
                      _confirmPasswordController.clear();
                    }
                  },
                  child: const Text('SPASI', style: TextStyle(color: Colors.white),),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller) {
    return Row(
      children: [
        //Text(label, style: TextStyle(fontSize: 18)),
        //SizedBox(width: 10),
        Expanded(
          child: TextField(
            controller: controller,
            obscureText: true,
            decoration: InputDecoration(
              labelText: label,
              contentPadding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0), // Adjust padding here
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
          ),
        ),
      ],
    );
  }

  String getCurrentUserRole() {
    if (Korisnik.uloge.contains("Komisija")) {
      return "Komisija";
    } else
      return "Admin";
  }



}
