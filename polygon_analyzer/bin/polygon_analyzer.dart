import 'package:polygon_analyzer/load_geojson.dart';
import 'package:polygon_analyzer/operations.dart';
import 'package:polygon_analyzer/yaml_parser.dart';
import 'package:turf/turf.dart';

void main(List<String> arguments) {
  final filename = arguments.first;
  final config = parseConfig(filename);

  final base = loadGeoJSONFile('base');
  final basePoly = base.features.first.geometry;
  if (basePoly is! Polygon && basePoly is! MultiPolygon) {
    throw Exception(
        'Base layer must be a Polygon or MultiPolygon. It is instead: ${basePoly.runtimeType}');
  }
  GeometryObject result = basePoly!;

  print('loading base layer');
  final baseArea = area(basePoly)!.abs();
  print('base area: $baseArea (100%)');
  print('---');

  for (final layer in config.layers) {
    print('loading layer: ${layer.name}');
    final layersColl = loadGeoJSONFile(layer.name);
    print('performing operation: ${layer.operation}');
    switch (layer.operation) {
      case Operation.difference:
        result = differenceOperation(result, layersColl);
      case Operation.union:
        result = unionOperation(result, layersColl);
    }
    final resultingArea = area(result)!.abs();
    final resultingPercentage = (resultingArea / baseArea) * 100;

    print('resulting area: $resultingArea ($resultingPercentage%)');
    print('---');
  }
}
