import 'dart:convert';
import 'dart:io';

import 'package:polygon_analyzer/load_geojson.dart';
import 'package:polygon_analyzer/yaml_parser.dart';
import 'package:turf/turf.dart';

void main(List<String> arguments) {
  final filename = arguments.first;
  final config = parseConfig(filename);
  final base = loadGeoJSONFile('base');
  for (final layer in config.layers) {
    final layerColl = loadGeoJSONFile(layer.name);
    if (layer.operation == Operation.remove) {
    } else {}
  }
}
