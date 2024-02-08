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

Polygon diff(Polygon baseTurfPoly, FeatureCollection features) {
  final polys = <poly.Polygon>[];

  var basePoly = turfToPoly(baseTurfPoly);

  geomEach(features, (geom, _, __, ___, ____) {
    if (geom is Polygon) {
      polys.add(turfToPoly(geom));
    }
  });

  for (final geom in polys) {
    basePoly = basePoly.difference(geom);
  }

  return polyToTurf(basePoly);
}
