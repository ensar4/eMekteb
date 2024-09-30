import 'dart:convert';
import 'package:emekteb_mobile/models/prisustvo.dart';
import 'package:emekteb_mobile/providers/base_provider.dart';
import 'package:http/http.dart' as http;
import '../models/searches/search_result.dart';

class PrisustvoProvider extends BaseProvider<Prisustvo>{
  PrisustvoProvider() : super("Prisustvo");

@override
Prisustvo fromJson(data) {
    // TODO: implement fromJson
    return Prisustvo.fromJson(data);
  }

  Future<bool> insert(bool prisutan, DateTime datum, int? korisnikId, int? casId) async {
    final url = Uri.parse(fullUrl);
    final headers = getHeaders();

    final response = await http.post(
      url,
      headers: headers,
      body: json.encode({
        'prisutan': prisutan,
        'datum': datum.toIso8601String(),
        'korisnikId': korisnikId,
        'casId': casId,
      }),
    );

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<SearchResult<Prisustvo>> getKorisnikById(int? id) async {
    var url = "$fullUrl/byKorisnikId/$id";
    var uri = Uri.parse(url);
    var headers = getHeaders();

    var response = await http.get(uri, headers: headers);


    if (isValidResponse(response)) {
      var data = jsonDecode(response.body);

      if (data is! Map<String, dynamic> || data['result'] == null) {
        throw Exception("Unexpected JSON format");
      }

      var result = SearchResult<Prisustvo>();

      // Parsing the list of Prisustvo objects from the 'result' field
      List<dynamic> prisustvoList = data['result'];
      result.result = prisustvoList.map((jsonItem) => Prisustvo.fromJson(jsonItem)).toList();

      // Storing the 'count' field value in the result
      result.count = data['count'] ?? 0;

      return result;
    } else {
      throw Exception("Error with response");
    }
  }


}