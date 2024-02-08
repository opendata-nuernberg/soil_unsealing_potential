import 'dart:convert';

import 'package:polygon_analyzer/turf/bool.dart';
import 'package:test/test.dart';
import 'package:turf/turf.dart';

main() {
  test('diff', () {
    final json = jsonDecode('''
{
  "type": "FeatureCollection",
  "features": [
    {
      "type": "Feature",
      "properties": {},
      "geometry": {
        "coordinates": [
          [
            [
              10.312916372180894,
              51.19838166577071
            ],
            [
              10.214808624917708,
              50.35747426357594
            ],
            [
              11.773634838145,
              50.21120043242749
            ],
            [
              12.275075262227944,
              50.958683905584735
            ],
            [
              11.315797446576227,
              51.72810568451416
            ],
            [
              10.803456644079574,
              51.606406374518286
            ],
            [
              10.312916372180894,
              51.19838166577071
            ]
          ]
        ],
        "type": "Polygon"
      }
    },
    {
      "type": "Feature",
      "properties": {},
      "geometry": {
        "coordinates": [
          [
            [
              12.400312875351801,
              51.14104754375137
            ],
            [
              11.073074351555107,
              50.88145969035705
            ],
            [
              11.217740073718176,
              50.18310435100631
            ],
            [
              12.361800519726586,
              50.21517827288565
            ],
            [
              12.645621515138657,
              50.758998981127945
            ],
            [
              12.400312875351801,
              51.14104754375137
            ]
          ]
        ],
        "type": "Polygon"
      }
    }
  ]
}
''');
    final coll = FeatureCollection.fromJson(json);
    final polygons = coll.features
        .where(
          (e) => e.geometry is Polygon || e.geometry is MultiPolygon,
        )
        .toList();
    final first = polygons.first.geometry as Polygon;
    final second = polygons.last.geometry as Polygon;
    final diffed = diff(
      first,
      FeatureCollection(
        features: [Feature(geometry: second)],
      ),
    );
    print(jsonEncode(Feature(geometry: diffed).toJson()));
  });
}
