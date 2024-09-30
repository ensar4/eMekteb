import 'dart:convert';
import 'package:emekteb_mobile/Screens/postavke_screen.dart';
import 'package:image_picker/image_picker.dart';
import 'package:emekteb_mobile/Widgets/master_screen.dart';
import 'package:emekteb_mobile/providers/user_provider.dart';
import 'package:emekteb_mobile/providers/password_provider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../models/korisnik.dart';
import '../models/searches/search_result.dart';
import '../models/slika.dart';
import '../providers/slika_provider.dart';
import '../utils/util.dart';

void main() {
  runApp(const ProfilScreen());
}

class ProfilScreen extends StatefulWidget {
  const ProfilScreen({super.key});

  @override
  State<ProfilScreen> createState() => _ProfilInfoState();
}

class _ProfilInfoState extends State<ProfilScreen> {
  late PasswordProvider _passwordProvider;
  late UserProvider _userProvider;
  late SlikaProvider _slikaProvider;
  String slikaBytes = '';
  SearchResult<Slika>? lista;
  List<Slika> filteredList = [];
  final ImagePicker _picker = ImagePicker();

  @override
  Future<void> didChangeDependencies() async {
    super.didChangeDependencies();
    _passwordProvider = context.read<PasswordProvider>();
    _userProvider = context.read<UserProvider>();
    _slikaProvider = context.read<SlikaProvider>();
    fetchData(_userProvider.user?.id);


  }

  Future<void> fetchData(int? id) async {
    try {
      SearchResult<dynamic> result = await _slikaProvider.getById2(id);
      if (result.result.isNotEmpty) {
        setState(() {
          slikaBytes = result.result[0].slikaBytes;
        });
      }
    } catch (e) {
      print("Error: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return MasterScreen(
      title: "Moj profil",
      child: SingleChildScrollView(
        child: Column(
          children: [
            imgPart(),
            profilInfo(),
            settingsButton()
          ],
        ),
      ),
    );
  }

  Widget imgPart() {
    String userRole = getCurrentUserRole();
    bool isRoditelj = userRole == "Roditelj";
    String? imePrezime = '${_userProvider.user?.ime} ${_userProvider.user?.prezime}';
    return _userProvider.user?.ime == null
        ? const CircularProgressIndicator()
        : Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.0),
            color: Color(0xFFE37224), // Background color
          ),
          width: double.infinity, // Full-width container
          height: 180, // Adjust the height as necessary
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if(!isRoditelj)
              Stack(
                children: [
                  Container(
                    width: 90,
                    height: 90,
                    decoration: BoxDecoration(
                      color: Colors.white, // Background color
                      shape: BoxShape.circle,  // Makes the container circular
                      image: slikaBytes.isNotEmpty
                          ? DecorationImage(
                        image: imageFromBase64String(slikaBytes),
                        fit: BoxFit.cover, // Fit image within the circle
                      )
                          : null,
                    ),
                  ),
                  Positioned(
                    right: 0,
                    bottom: 0,
                    child: GestureDetector(
                      onTap: () async {
                        await _selectAndUploadImage();
                      },
                      child: CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: 15,
                        child: Icon(
                          Icons.edit,
                          size: 15,
                          color: Colors.orange,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10), // Space between the avatar and text
              Text(
                imePrezime,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white, // Text color
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }


  Widget profilInfo() {
    String? imeRoditelja = _userProvider.user?.imeRoditelja;
    String? username = _userProvider.user?.username;
    String? telefon = _userProvider.user?.telefon;
    String datumRodjenja = (_userProvider.user != null && _userProvider.user!.datumRodjenja != null)
        ? DateFormat('d.M.yyyy').format(_userProvider.user!.datumRodjenja!)
        : 'N/A';
    return _userProvider.user?.ime == null
        ? const CircularProgressIndicator()
        : Center(
      child: Container(
        padding: EdgeInsets.all(40),
       // margin: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 10,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildUserInfoRow('Korisničko ime', '$username'),
            SizedBox(height: 8),
            _buildUserInfoRow('Ime roditelja', '$imeRoditelja'),
            SizedBox(height: 8),
            _buildUserInfoRow('Datum rođenja', datumRodjenja),
            SizedBox(height: 8),
            _buildUserInfoRow('Broj telefona', '$telefon'),
          ],
        ),
      ),
    );
  }

  Widget settingsButton(){
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: IconButton(
          icon: Icon(Icons.settings, color: Colors.black),
          onPressed: () async {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const Postavke(),
              ),
            );
          }
      ),
    );
  }
  Widget _buildUserInfoRow(String label, String value) {
    return _userProvider.user?.ime == null
        ? const CircularProgressIndicator()
        : RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: '$label: ',
            style: TextStyle(color: Colors.black, fontSize: 16),
          ),
          TextSpan(
            text: value,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _selectAndUploadImage() async {
    final XFile? pickedFile = await _picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      final bytes = await pickedFile.readAsBytes();
      String base64Image = base64Encode(bytes);

      final bool result = await _slikaProvider.insert(base64Image, _userProvider.user?.id);

      if (result) {
        setState(() {
          slikaBytes = base64Image;
        });
      } else {
        print("Failed to upload image");
      }
    } else {
      print("No image selected.");
    }
  }

  String getCurrentUserRole() {
    if (Korisnik.uloge.contains("Roditelj")) {
      return "Roditelj";
    } else
      return "Imam";
  }



}


