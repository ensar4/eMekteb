import 'dart:convert';
import 'package:emekteb_mobile/providers/base_provider.dart';
import 'package:http/http.dart' as http;
import '../models/user.dart';

class UserProvider extends BaseProvider<User>{
  UserProvider() : super("Korisnik");
  User? _user;
  User? get user => _user;

@override
User fromJson(data) {
    // TODO: implement fromJson
    return User.fromJson(data);
  }

  Future<User?> getKorisnik(int? id) async {
    var korisnik = "Korisnik/getById";
    var url = "$baseOfUrl$korisnik/$id";
    var uri = Uri.parse(url);
    var headers = getHeaders();
    var response = await http.get(uri, headers: headers);

    if (isValidResponse(response)) {
      var data = jsonDecode(response.body);

      if (data is! Map<String, dynamic>) {
        throw Exception("Unexpected JSON format");
      }

      _user = User.fromJson(data);
      notifyListeners();

      return _user;

    } else {
      throw Exception("Error with response");
    }
  }

  void clearUser() {
    _user = null;
    _user?.id = null;
    notifyListeners();
  }

  Future<bool> insert(
      String ime,
      String prezime,
      String username,
      String telefon,
      String mail,
      String spol,
      String status,
      DateTime datumRodjenja,
      String imeRoditelja,
      int mektebId,
      String password,
      String passwordPotvrda
      ) async {
    final url = Uri.parse('$baseOfUrl''Korisnik');
    final headers = getHeaders();

    final response = await http.post(
      url,
      headers: headers,
      body: json.encode({
        'ime': ime,
        'prezime': prezime,
        'username': username,
        'telefon': telefon,
        'mail': mail,
        'spol': spol,
        'status': status,
        'datumRodjenja': datumRodjenja.toIso8601String(),
        'imeRoditelja': imeRoditelja,
        'mektebId': mektebId,
        'razredId': 2,
        'password': password,
        'passwordPotvrda': passwordPotvrda,
      }),
    );

    if (response.statusCode == 200) {
      final korisnikId = json.decode(response.body)['id']; // Assuming the API returns the created user's ID
      return await _addRoleToKorisnik(korisnikId, 5); // Assuming 3 is the role ID for "Mualim"
    } else {
      return false;
    }
  }

  Future<bool> insertAdmin(
      String ime,
      String prezime,
      String username,
      String telefon,
      String mail,
      String spol,
      String status,
      DateTime datumRodjenja,
      String imeRoditelja,
      int mektebId,
      String password,
      String passwordPotvrda
      ) async {
    final url = Uri.parse('$baseOfUrl''Korisnik');
    final headers = getHeaders();

    final response = await http.post(
      url,
      headers: headers,
      body: json.encode({
        'ime': ime,
        'prezime': prezime,
        'username': username,
        'telefon': telefon,
        'mail': mail,
        'spol': spol,
        'status': status,
        'datumRodjenja': datumRodjenja.toIso8601String(),
        'imeRoditelja': imeRoditelja,
        'mektebId': mektebId,
        'razredId': 2,
        'password': password,
        'passwordPotvrda': passwordPotvrda,
      }),
    );

    if (response.statusCode == 200) {
      final korisnikId = json.decode(response.body)['id'];
      return await _addRoleToKorisnik(korisnikId, 1);
    } else {
      return false;
    }
  }

  Future<bool> _addRoleToKorisnik(int korisnikId, int ulogaId) async {
    final url = Uri.parse('$baseOfUrl''KorisniciUloge');
    final headers = getHeaders();

    final response = await http.post(
      url,
      headers: headers,
      body: json.encode({
        'datumIzmjene': DateTime.now().toIso8601String(),
        'korisnikId': korisnikId,
        'ulogaId': ulogaId,
      }),
    );

    return response.statusCode == 200;
  }

  Future<bool> deleteKomisija(int? id) async {
    final url = Uri.parse('$baseOfUrl''Korisnik/$id');
    final headers = getHeaders();

    final response = await http.delete(
      url,
      headers: headers,
    );

    if (response.statusCode == 200) {
      return true;
    } else {
      throw Exception('Failed to delete item: ${response.statusCode}');
    }
  }
}