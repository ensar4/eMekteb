// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cas.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Cas _$CasFromJson(Map<String, dynamic> json) => Cas(
      (json['id'] as num?)?.toInt(),
      DateTime.parse(json['datum'] as String),
      json['razred'] as String,
      json['lekcija'] as String,
      (json['mektebId'] as num).toInt(),
    );

Map<String, dynamic> _$CasToJson(Cas instance) => <String, dynamic>{
      'id': instance.id,
      'datum': instance.datum.toIso8601String(),
      'razred': instance.razred,
      'lekcija': instance.lekcija,
      'mektebId': instance.mektebId,
    };
