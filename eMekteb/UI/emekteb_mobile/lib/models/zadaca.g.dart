// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'zadaca.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Zadaca _$ZadacaFromJson(Map<String, dynamic> json) => Zadaca(
      DateTime.parse(json['datumDodjele'] as String),
      (json['korisnikId'] as num).toInt(),
      (json['ocjeneId'] as num).toInt(),
      json['lekcija'] as String,
      (json['razredId'] as num?)?.toInt(),
    );

Map<String, dynamic> _$ZadacaToJson(Zadaca instance) => <String, dynamic>{
      'datumDodjele': instance.datumDodjele.toIso8601String(),
      'korisnikId': instance.korisnikId,
      'ocjeneId': instance.ocjeneId,
      'lekcija': instance.lekcija,
      'razredId': instance.razredId,
    };
