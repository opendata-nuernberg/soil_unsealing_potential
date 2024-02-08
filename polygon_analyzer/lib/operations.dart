import 'package:polygon_analyzer/turf/bool.dart';
import 'package:turf/turf.dart';

GeometryObject differenceOperation(
    GeometryObject base, FeatureCollection layers) {
  if (base is Polygon) {
    return polyDiff(base, layers);
  } else if (base is MultiPolygon) {
    return multiPolyDiff(base, layers);
  } else {
    throw Exception('Base layer must be a Polygon or MultiPolygon');
  }
}

GeometryObject unionOperation(GeometryObject base, FeatureCollection layers) {
  // TODO implement
  throw Exception('Operation \'union\' not implemented');
}
