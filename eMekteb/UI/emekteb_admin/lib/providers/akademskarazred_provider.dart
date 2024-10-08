import 'dart:convert';
import 'package:emekteb_admin/models/akademska_mekteb.dart';
import 'package:http/http.dart' as http;
import '../models/akademska_razred.dart';
import 'base_provider.dart';

class AkademskaRazredProvider extends BaseProvider<AkademskaRazred> {
  AkademskaRazredProvider() : super("AkademskaRazred");

  @override
  AkademskaRazred fromJson(data) {
    return AkademskaRazred.fromJson(data);
  }

  Future<bool> insertAkademskaRazred(int? akademskaGodinaId, int? razredId) async {
    final url = Uri.parse(fullUrl);
    var headers = getHeaders();
    final response = await http.post(
      url,
      headers: headers,
      body: json.encode({
        'akademskaGodinaId': akademskaGodinaId,
        'razredId': razredId,
      }),
    );

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }
}

