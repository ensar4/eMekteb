import 'dart:convert';
import 'package:emekteb_admin/models/korisnik.dart';
import 'package:emekteb_admin/models/mualim.dart';
import 'package:emekteb_admin/providers/base_provider.dart';
import 'package:http/http.dart' as http;

class MualimProvider extends BaseProvider<Mualim>{
  MualimProvider() : super("Mualimi");
 // var medzlisIde = Korisnik.medzlisId;

@override
Mualim fromJson(data) {
    // TODO: implement fromJson
    return Mualim.fromJson(data);
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
    //print("medzlisIde:");    print(medzlisIde);

    if (response.statusCode == 200) {
      final korisnikId = json.decode(response.body)['id'];
      return await _addRoleToKorisnik(korisnikId, 3);
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

  Future<bool> deleteMualim(int? id) async {
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


  Future<bool> update(
      int? id,
      String ime,
      String prezime,
      String username,
      String telefon,
      String mail,
      String spol,
      DateTime datumRodjenja,
      String imeRoditelja,
      int? mektebId,
      ) async {
    final url = Uri.parse('$baseOfUrl''Korisnik/$id');
    final headers = getHeaders();

    final response = await http.put(
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
      }),
    );
    if (response.statusCode == 200) {
      return true;
    } else if (response.statusCode == 405){
      throw Exception('Failed: ${response.statusCode}');
    }
    return false;
  }

}