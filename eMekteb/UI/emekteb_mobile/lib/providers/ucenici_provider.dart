import 'dart:convert';
import 'package:emekteb_mobile/models/ucenik.dart';
import 'package:emekteb_mobile/providers/base_provider.dart';
import 'package:emekteb_mobile/providers/razred_korisnik_provider.dart';
import 'package:http/http.dart' as http;

import '../models/searches/search_result.dart';

class UceniciProvider extends BaseProvider<Ucenik>{
  UceniciProvider() : super("Ucenici");


@override
Ucenik fromJson(data) {
    // TODO: implement fromJson
    return Ucenik.fromJson(data);
  }

  Future<SearchResult<Ucenik>> getUcenikHistory(int? id) async {
    var url = "$baseOfUrl""UcenikHistory/$id";

    var uri = Uri.parse(url);
    var headers = getHeaders();

    var response = await http.get(uri, headers: headers);

    if (isValidResponse(response)) {
      var data = jsonDecode(response.body);

      if (data is! Map<String, dynamic> || !data.containsKey('result')) {
        throw Exception("Unexpected JSON format");
      }

      var result = SearchResult<Ucenik>();

      var resultList = data['result'];

      if (resultList is List) {
        for (var itemData in resultList) {
          var item = fromJson(itemData);
          result.result.add(item);
        }
      }

      result.count = data['count'] ?? result.result.length;

      return result;
    } else {
      throw Exception("Error with response");
    }
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
      String password,
      String passwordPotvrda,
      int? mektebId,
      int razredId
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
        'razredId': razredId,
        'password': password,
        'passwordPotvrda': passwordPotvrda,
      }),
    );

    if (response.statusCode == 200) {
      final korisnikId = json.decode(response.body)['id'];
      return await _addRoleToKorisnik(korisnikId, 2);
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

  Future<bool> insertOboje(
      String ime,
      String prezime,
      String username,
      String telefon,
      String mail,
      String spol,
      String status,
      DateTime datumRodjenja,
      String imeRoditelja,
      String password,
      String passwordPotvrda,
      int? mektebId,
      int razredId
      ) async {
    final url = Uri.parse('$baseOfUrl''Korisnik''/create-student-with-parent');
    final roditeIjUsername = '${imeRoditelja.toLowerCase()}.${prezime.toLowerCase()}';
    final headers = getHeaders();

    final response = await http.post(
      url,
      headers: headers,
      body: json.encode({
        'ucenikIme': ime,
        'ucenikPrezime': prezime,
        'ucenikUsername': username,
        'ucenikTelefon': telefon,
        'ucenikMail': mail,
        'ucenikSpol': spol,
        'ucenikStatus': status,
        'ucenikDatumRodjenja': datumRodjenja.toIso8601String(),
        'ucenikImeRoditelja': imeRoditelja,
        'ucenikMektebId': mektebId,
        'ucenikPassword': password,
        'ucenikPasswordPotvrda': passwordPotvrda,
        'roditeljIme': imeRoditelja,
        'roditeljPrezime': prezime,
        'roditeljUsername': roditeIjUsername,
        'roditeljTelefon': telefon,
        'roditeljMail': mail,
        'roditeljSpol': spol,
        'roditeljStatus': status,
        'roditeljDatumRodjenja': datumRodjenja.toIso8601String(),
        'roditeljImeRoditelja': 'ime',
        'roditeljMektebId': mektebId,
        'roditeljPassword': 'test',
        'roditeljPasswordPotvrda': 'test'
      }),
    );

    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);

      final studentId = responseData['studentId'];
      final parentId = responseData['parentId'];

      bool studentRoleAdded = await _addRoleToKorisnik(studentId, 2);

      bool parentRoleAdded = await _addRoleToKorisnik(parentId, 4);

      if (studentRoleAdded && parentRoleAdded) {
        RazredKorisnikProvider razredKorisnikProvider = RazredKorisnikProvider();
        bool razredKorisnikInserted = await razredKorisnikProvider.insert(studentId, razredId, DateTime.now());

        return razredKorisnikInserted;
      } else {
        return false;
      }
    } else {
      return false;
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
      int razredId,
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
      print(response.body);
      final razredKorisnikProvider = RazredKorisnikProvider();
      DateTime currentDate = DateTime.now();

      bool razredKorisnikUpdated = await razredKorisnikProvider.insert(id, razredId, currentDate);

      return razredKorisnikUpdated;
    } else {
      return false;
    }
  }


}