// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'obavijest.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Obavijest _$ObavijestFromJson(Map<String, dynamic> json) => Obavijest(
      (json['id'] as num?)?.toInt(),
      json['naslov'] as String,
      json['opis'] as String,
      DateTime.parse(json['datumObjave'] as String),
      json['vrstaObjave'] as String,
      (json['mektebId'] as num).toInt(),
      json['stateMachine'] as String,
    );

Map<String, dynamic> _$ObavijestToJson(Obavijest instance) => <String, dynamic>{
      'id': instance.id,
      'naslov': instance.naslov,
      'opis': instance.opis,
      'datumObjave': instance.datumObjave.toIso8601String(),
      'vrstaObjave': instance.vrstaObjave,
      'mektebId': instance.mektebId,
      'stateMachine': instance.stateMachine,
    };
