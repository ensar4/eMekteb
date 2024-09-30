// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'slika.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Slika _$SlikaFromJson(Map<String, dynamic> json) => Slika(
      (json['id'] as num?)?.toInt(),
      json['slikaBytes'] as String?,
      (json['korisnikId'] as num?)?.toInt(),
    );

Map<String, dynamic> _$SlikaToJson(Slika instance) => <String, dynamic>{
      'id': instance.id,
      'slikaBytes': instance.slikaBytes,
      'korisnikId': instance.korisnikId,
    };
