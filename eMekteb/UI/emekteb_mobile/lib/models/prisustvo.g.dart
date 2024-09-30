// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'prisustvo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Prisustvo _$PrisustvoFromJson(Map<String, dynamic> json) => Prisustvo(
      (json['id'] as num?)?.toInt(),
      json['prisutan'] as bool?,
      json['datum'] == null ? null : DateTime.parse(json['datum'] as String),
      (json['casId'] as num?)?.toInt(),
      (json['korisnikId'] as num?)?.toInt(),
    );

Map<String, dynamic> _$PrisustvoToJson(Prisustvo instance) => <String, dynamic>{
      'id': instance.id,
      'prisutan': instance.prisutan,
      'datum': instance.datum?.toIso8601String(),
      'korisnikId': instance.korisnikId,
      'casId': instance.casId,
    };
