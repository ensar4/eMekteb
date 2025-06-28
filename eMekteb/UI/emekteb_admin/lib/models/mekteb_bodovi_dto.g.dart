// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mekteb_bodovi_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MektebBodoviDto _$MektebBodoviDtoFromJson(Map<String, dynamic> json) =>
    MektebBodoviDto(
      (json['mektebId'] as num?)?.toInt(),
      json['nazivMekteba'] as String?,
      (json['ukupnoBodova'] as num?)?.toInt(),
    );

Map<String, dynamic> _$MektebBodoviDtoToJson(MektebBodoviDto instance) =>
    <String, dynamic>{
      'mektebId': instance.mektebId,
      'nazivMekteba': instance.nazivMekteba,
      'ukupnoBodova': instance.ukupnoBodova,
    };
