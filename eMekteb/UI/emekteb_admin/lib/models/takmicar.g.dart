// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'takmicar.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Takmicar _$TakmicarFromJson(Map<String, dynamic> json) => Takmicar(
      (json['id'] as num?)?.toInt(),
      json['ime'] as String?,
      json['prezime'] as String?,
      DateTime.parse(json['datumRodjenja'] as String),
      (json['kategorijaId'] as num?)?.toInt(),
      (json['ukupnoBodova'] as num?)?.toInt(),
    );

Map<String, dynamic> _$TakmicarToJson(Takmicar instance) => <String, dynamic>{
      'id': instance.id,
      'ime': instance.ime,
      'prezime': instance.prezime,
      'datumRodjenja': instance.datumRodjenja.toIso8601String(),
      'kategorijaId': instance.kategorijaId,
      'ukupnoBodova': instance.ukupnoBodova,
    };
