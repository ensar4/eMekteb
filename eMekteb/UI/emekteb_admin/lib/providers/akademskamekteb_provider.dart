import 'dart:convert';
import 'package:emekteb_admin/models/akademska_mekteb.dart';
import 'package:http/http.dart' as http;
import 'base_provider.dart';

class AkademskaMektebProvider extends BaseProvider<AkademskaMekteb> {
  AkademskaMektebProvider() : super("AkademskaMekteb");

  @override
  AkademskaMekteb fromJson(data) {
    return AkademskaMekteb.fromJson(data);
  }

  Future<bool> insertAkademskaMekteb(int? akademskaGodinaId, int? mektebId) async {
    final url = Uri.parse(fullUrl);
    var headers = getHeaders();
    final response = await http.post(
      url,
      headers: headers,
      body: json.encode({
        'akademskaGodinaId': akademskaGodinaId,
        'mektebId': mektebId,
      }),
    );

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }
}

