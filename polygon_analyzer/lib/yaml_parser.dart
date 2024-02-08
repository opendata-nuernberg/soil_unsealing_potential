import 'dart:convert';
import 'dart:io';
import 'package:yaml/yaml.dart';
import 'package:json_annotation/json_annotation.dart';
part 'yaml_parser.g.dart';

enum Operation { difference, union }

@JsonSerializable()
class ConfigLayer {
  String name;
  Operation operation;

  ConfigLayer({required this.name, required this.operation});

  factory ConfigLayer.fromJson(Map<String, dynamic> json) =>
      _$ConfigLayerFromJson(json);

  Map<String, dynamic> toJson() => _$ConfigLayerToJson(this);
}

@JsonSerializable()
class UnsealingConfig {
  List<ConfigLayer> layers;
  String city;

  UnsealingConfig({required this.layers, required this.city});

  factory UnsealingConfig.fromJson(Map<String, dynamic> json) =>
      _$UnsealingConfigFromJson(json);

  Map<String, dynamic> toJson() => _$UnsealingConfigToJson(this);
}

UnsealingConfig parseConfig(String filename) {
  final fileContent = File(filename).readAsStringSync();
  final yamlMap = jsonDecode(jsonEncode(loadYaml(fileContent) as YamlMap))
      as Map<String, dynamic>;

  return UnsealingConfig.fromJson(yamlMap);
}
