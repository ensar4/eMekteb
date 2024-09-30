// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'kategorija.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Kategorija _$KategorijaFromJson(Map<String, dynamic> json) => Kategorija(
      json['id'] as int?,
      json['naziv'] as String?,
      json['nivo'] as String?,
      json['takmicenjeId'] as int?,
    );

Map<String, dynamic> _$KategorijaToJson(Kategorija instance) =>
    <String, dynamic>{
      'id': instance.id,
      'naziv': instance.naziv,
      'nivo': instance.nivo,
      'takmicenjeId': instance.takmicenjeId,
    };
