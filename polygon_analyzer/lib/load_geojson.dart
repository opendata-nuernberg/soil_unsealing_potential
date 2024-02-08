import 'dart:convert';
import 'dart:io';

import 'package:turf/turf.dart';

const FOLDER_PREFIX = '../data/';

FeatureCollection loadGeoJSONFile(String layer) {
  final fileContent = File('$FOLDER_PREFIX$layer.geojson').readAsStringSync();
  final json = jsonDecode(fileContent);
  return FeatureCollection.fromJson(json);
}
