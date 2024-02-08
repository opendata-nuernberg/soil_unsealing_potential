import 'dart:convert';
import 'dart:io';

import 'package:polygon_analyzer/yaml_parser.dart';
import 'package:turf/turf.dart';

void main(List<String> arguments) {
  final filename = arguments.first;
  parseConfig(filename);
}

void old(List<String> arguments) {
  final filename = arguments.first;
  final body = File(filename).readAsStringSync();
  final json = jsonDecode(body);
  final coll = FeatureCollection.fromJson(json);
  final polygons = coll.features
      .where(
        (e) => e.geometry is Polygon || e.geometry is MultiPolygon,
      )
      .toList();
  print(polygons.length);
  final calculatedArea = area(FeatureCollection(features: polygons));
  print('${calculatedArea!.toStringAsFixed(0)} sq m');
  print('${(calculatedArea / 1000).toStringAsFixed(0)} sq km');
}
