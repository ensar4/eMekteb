import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/kategorija.dart';
import 'base_provider.dart';

class KategorijaProvider extends BaseProvider<Kategorija> {
  KategorijaProvider() : super("Kategorija");

  @override
  Kategorija fromJson(data) {
    return Kategorija.fromJson(data);
  }

  Future<bool> insert(String naziv, String nivo, int? takmicenjeId) async {
    final url = Uri.parse(fullUrl);
    var headers = getHeaders();
    final response = await http.post(
      url,
      headers: headers,
      body: json.encode({
        'naziv': naziv,
        'nivo':nivo,
        'takmicenjeId': takmicenjeId,

      }),
    );

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

}

