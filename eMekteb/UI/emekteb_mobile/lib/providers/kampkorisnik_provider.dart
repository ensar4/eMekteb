import 'dart:convert';
import 'package:emekteb_mobile/models/kamp_korisnik.dart';
import 'package:emekteb_mobile/providers/base_provider.dart';

class KampKorisnikProvider extends BaseProvider<KampKorisnik>{
  KampKorisnikProvider() : super("KampKorisnik");

@override
  KampKorisnik fromJson(data) {
    // TODO: implement fromJson
    return KampKorisnik.fromJson(data);
  }

  Future<bool> insert(DateTime datumDodavanja, int? kampId,  int? korisnikId) async {
    final url = Uri.parse(fullUrl);
    final headers = getHeaders();

    final response = await http?.post(
      url,
      headers: headers,
      body: json.encode({
        'datumDodavanja': datumDodavanja.toIso8601String(),
        'kampId': kampId,
        'korisnikId': korisnikId,
      }),
    );

    if (response?.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }
}