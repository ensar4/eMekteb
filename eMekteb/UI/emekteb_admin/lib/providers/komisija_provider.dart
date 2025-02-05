import 'dart:convert';
import 'package:emekteb_admin/models/komisija.dart';
import 'package:emekteb_admin/providers/base_provider.dart';
import 'package:http/http.dart' as http;

class KomisijaProvider extends BaseProvider<Komisija>{
  KomisijaProvider() : super("Komisija");


@override
Komisija fromJson(data) {
    // TODO: implement fromJson
    return Komisija.fromJson(data);
  }

  Future<bool> insert(
      String ime,
      String prezime,
      String username,
      String telefon,
      String mail,
      String spol,
      DateTime datumRodjenja,
      String imeRoditelja,
      int mektebId,
      String password,
      String passwordPotvrda,
      int medzlisId
      ) async {
    final url = Uri.parse('$baseOfUrl''Korisnik');
    var headers = getHeaders();
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
        'status': "aktivan",
        'datumRodjenja': datumRodjenja.toIso8601String(),
        'imeRoditelja': imeRoditelja,
        'mektebId': mektebId,
        'razredId': 2,
        'password': password,
        'passwordPotvrda': passwordPotvrda,
        'medzlisId': medzlisId,
      }),
    );

    if (response.statusCode == 200) {
      final korisnikId = json.decode(response.body)['id'];
      return await _addRoleToKorisnik(korisnikId, 5);
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
      DateTime datumRodjenja,
      String imeRoditelja,
      int mektebId,
      String password,
      String passwordPotvrda,
      int medzlisId
      ) async {
    final url = Uri.parse('$baseOfUrl''Korisnik');
    var headers = getHeaders();
    print("medzlisId:");
    print(medzlisId);
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
        'status': "aktivan",
        'datumRodjenja': datumRodjenja.toIso8601String(),
        'imeRoditelja': imeRoditelja,
        'mektebId': mektebId,
        'razredId': 2,
        'password': password,
        'passwordPotvrda': passwordPotvrda,
        'medzlisId' : medzlisId
      }),
    );
     print(response.body);
    if (response.statusCode == 200) {
      final korisnikId = json.decode(response.body)['id'];
      return await _addRoleToKorisnik(korisnikId, 1);
    } else {
      return false;
    }
  }

  Future<bool> _addRoleToKorisnik(int korisnikId, int ulogaId) async {
    final url = Uri.parse('$baseOfUrl''KorisniciUloge');
    var headers = getHeaders();
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
    var headers = getHeaders();
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


  Future<void> sendMail(dynamic object) async {
    var url = "${baseOfUrl}Mail";
    var uri = Uri.parse(url);
    var headers = getHeaders();
    var obj = jsonEncode(object);
    var req = await http.post(uri, headers: headers, body: obj);
    if (!isValidResponse(req)) {
      throw Exception("Greška.");
    }
  }
}