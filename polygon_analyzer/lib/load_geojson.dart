import 'dart:convert';
import 'dart:io';

import 'package:turf/turf.dart';

FeatureCollection loadGeoJSONFile(String layer) {
  final fileContent = File('$layer.geojson').readAsStringSync();
  final json = jsonDecode(fileContent);
  return FeatureCollection.fromJson(json);
}
