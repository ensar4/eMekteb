import 'package:emekteb_mobile/models/akademska_godina.dart';
import 'package:emekteb_mobile/providers/base_provider.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class AkademskagodinaProvider extends BaseProvider<AkademskaGodina>{
  AkademskagodinaProvider() : super("AkademskaGodina");

@override
  AkademskaGodina fromJson(data) {
    // TODO: implement fromJson
    return AkademskaGodina.fromJson(data);
  }




}