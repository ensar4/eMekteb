import 'dart:convert';
import 'package:emekteb_mobile/models/kamp_korisnik.dart';
import 'package:emekteb_mobile/providers/base_provider.dart';

import '../models/razred_korisnik.dart';

class RazredKorisnikProvider extends BaseProvider<RazredKorisnik>{
  RazredKorisnikProvider() : super("RazredKorisnik");

@override
  RazredKorisnik fromJson(data) {
    // TODO: implement fromJson
    return RazredKorisnik.fromJson(data);
  }

  Future<bool> insert(int? korisnikId,  int? razredId, DateTime datumUpisa) async {
    final url = Uri.parse(fullUrl);
    final headers = getHeaders();

    final response = await http?.post(
      url,
      headers: headers,
      body: json.encode({
        'korisnikId': korisnikId,
        'razredId': razredId,
        'datumUpisa': datumUpisa.toIso8601String(),
      }),
    );

    if (response?.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }
}