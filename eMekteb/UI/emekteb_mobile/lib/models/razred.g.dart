// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'razred.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Razred _$RazredFromJson(Map<String, dynamic> json) => Razred(
      (json['id'] as num).toInt(),
      json['naziv'] as String?,
    );

Map<String, dynamic> _$RazredToJson(Razred instance) => <String, dynamic>{
      'id': instance.id,
      'naziv': instance.naziv,
    };