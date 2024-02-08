// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'yaml_parser.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ConfigLayer _$ConfigLayerFromJson(Map<String, dynamic> json) => ConfigLayer(
      name: json['name'] as String,
      operation: $enumDecode(_$OperationEnumMap, json['operation']),
    );

Map<String, dynamic> _$ConfigLayerToJson(ConfigLayer instance) =>
    <String, dynamic>{
      'name': instance.name,
      'operation': _$OperationEnumMap[instance.operation]!,
    };

const _$OperationEnumMap = {
  Operation.remove: 'remove',
  Operation.union: 'union',
};

UnsealingConfig _$UnsealingConfigFromJson(Map<String, dynamic> json) =>
    UnsealingConfig(
      layers: (json['layers'] as List<dynamic>)
          .map((e) => ConfigLayer.fromJson(e as Map<String, dynamic>))
          .toList(),
      city: json['city'] as String,
    );

Map<String, dynamic> _$UnsealingConfigToJson(UnsealingConfig instance) =>
    <String, dynamic>{
      'layers': instance.layers,
      'city': instance.city,
    };
