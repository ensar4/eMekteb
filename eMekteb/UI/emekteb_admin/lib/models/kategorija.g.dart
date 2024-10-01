// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'kategorija.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Kategorija _$KategorijaFromJson(Map<String, dynamic> json) => Kategorija(
      (json['id'] as num?)?.toInt(),
      json['naziv'] as String?,
      json['nivo'] as String?,
      (json['takmicenjeId'] as num?)?.toInt(),
    );

Map<String, dynamic> _$KategorijaToJson(Kategorija instance) =>
    <String, dynamic>{
      'id': instance.id,
      'naziv': instance.naziv,
      'nivo': instance.nivo,
      'takmicenjeId': instance.takmicenjeId,
    };
