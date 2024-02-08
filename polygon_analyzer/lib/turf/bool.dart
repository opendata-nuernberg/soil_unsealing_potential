import 'package:turf/meta.dart';
import 'package:turf/turf.dart';

import 'package:polybool/polybool.dart' as poly;

poly.Polygon turfToPoly(Polygon polygon) {
  return poly.Polygon(
    regions: [
      ...polygon.coordinates
          .map(
            (i) => i
                .map(
                  (j) => poly.Coordinate(
                    j.lat.toDouble(),
                    j.lng.toDouble(),
                  ),
                )
                .toList(),
          )
          .toList()
    ],
  );
}

Polygon polyToTurf(poly.Polygon polygon) {
  return Polygon(
    coordinates: polygon.regions
        .map(
          (e) => [
            ...e.map(
              (e) => Position.named(lat: e.x, lng: e.y),
            ),
            Position.named(lat: e.first.x, lng: e.first.y)
          ],
        )
        .toList(),
  );
}

Polygon polyDiff(Polygon baseTurfPoly, FeatureCollection coll) {
  final polys = <poly.Polygon>[];

  var basePoly = turfToPoly(baseTurfPoly);

  geomEach(coll, (geom, _, __, ___, ____) {
    if (geom is Polygon) {
      polys.add(turfToPoly(geom));
    }
  });

  for (final geom in polys) {
    // TODO add if(overlaps / intersects)
    // https://github.com/dartclub/turf_dart/pull/141

    basePoly = basePoly.difference(geom);
  }

  return polyToTurf(basePoly);
}

MultiPolygon multiPolyDiff(MultiPolygon baseTurfPoly, FeatureCollection coll) {
  final basePolys =
      baseTurfPoly.coordinates.map((e) => Polygon(coordinates: e)).toList();

  final resultPolys = <Polygon>[];
  for (final basePoly in basePolys) {
    resultPolys.add(polyDiff(basePoly, coll));
  }
  return MultiPolygon(
    coordinates: resultPolys.map((e) => e.coordinates).toList(),
  );
}
