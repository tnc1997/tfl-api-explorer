import 'package:flutter_test/flutter_test.dart';
import 'package:tfl_api_client/tfl_api_client.dart';
import 'package:tfl_api_explorer/common/specification.dart';
import 'package:tfl_api_explorer/lines/line_route_service_type_specification.dart';
import 'package:tfl_api_explorer/places/place_common_name_specification.dart';
import 'package:tfl_api_explorer/roads/road_display_name_specification.dart';

void main() {
  final bikePoints = <Place>[
    Place(
      id: 'BikePoints_1',
      commonName: 'River Street, Clerkenwell',
      placeType: 'BikePoint',
      lat: 51.529162,
      lon: -0.10997,
    ),
    Place(
      id: 'BikePoints_2',
      commonName: 'Phillimore Gardens, Kensington',
      placeType: 'BikePoint',
      lat: 51.499606,
      lon: -0.197574,
    ),
    Place(
      id: 'BikePoints_3',
      commonName: 'Christopher Street, Liverpool Street',
      placeType: 'BikePoint',
      lat: 51.521283,
      lon: -0.084605,
    ),
  ];

  final matchedRoutes = <MatchedRoute>[
    MatchedRoute(
      serviceType: 'Night',
    ),
    MatchedRoute(
      serviceType: 'Regular',
    ),
  ];

  final roadCorridors = <RoadCorridor>[
    RoadCorridor(
      id: 'a1',
      displayName: 'A1',
    ),
    RoadCorridor(
      id: 'a2',
      displayName: 'A2',
    ),
  ];

  group('specifications', () {
    group('LineRouteServiceTypeSpecification', () {
      test('isSatisfiedBy', () {
        Specification<MatchedRoute> specification;

        specification = LineRouteServiceTypeSpecification(
          serviceType: 'Day',
        );
        expect(
          specification.isSatisfiedBy(matchedRoutes[0]),
          isFalse,
        );
        expect(
          specification.isSatisfiedBy(matchedRoutes[1]),
          isFalse,
        );
        expect(
          matchedRoutes.where(specification.isSatisfiedBy).toList(),
          isEmpty,
        );

        specification = LineRouteServiceTypeSpecification(
          serviceType: 'Night',
        );
        expect(
          specification.isSatisfiedBy(matchedRoutes[0]),
          isTrue,
        );
        expect(
          specification.isSatisfiedBy(matchedRoutes[1]),
          isFalse,
        );
        expect(
          matchedRoutes.where(specification.isSatisfiedBy).toList(),
          hasLength(1),
        );

        specification = LineRouteServiceTypeSpecification(
          serviceType: 'Regular',
        );
        expect(
          specification.isSatisfiedBy(matchedRoutes[0]),
          isFalse,
        );
        expect(
          specification.isSatisfiedBy(matchedRoutes[1]),
          isTrue,
        );
        expect(
          matchedRoutes.where(specification.isSatisfiedBy).toList(),
          hasLength(1),
        );
      });
    });

    group('PlaceCommonNameSpecification', () {
      test('isSatisfiedBy', () {
        Specification<Place> specification;

        specification = PlaceCommonNameSpecification(
          commonName: 'Christopher Street',
        );
        expect(
          specification.isSatisfiedBy(bikePoints[0]),
          isFalse,
        );
        expect(
          specification.isSatisfiedBy(bikePoints[1]),
          isFalse,
        );
        expect(
          specification.isSatisfiedBy(bikePoints[2]),
          isTrue,
        );
        expect(
          bikePoints.where(specification.isSatisfiedBy).toList(),
          hasLength(1),
        );

        specification = PlaceCommonNameSpecification(
          commonName: 'Russell Street',
        );
        expect(
          specification.isSatisfiedBy(bikePoints[0]),
          isFalse,
        );
        expect(
          specification.isSatisfiedBy(bikePoints[1]),
          isFalse,
        );
        expect(
          specification.isSatisfiedBy(bikePoints[2]),
          isFalse,
        );
        expect(
          bikePoints.where(specification.isSatisfiedBy).toList(),
          isEmpty,
        );
      });
    });

    group('RoadDisplayNameSpecification', () {
      test('isSatisfiedBy', () {
        Specification<RoadCorridor> specification;

        specification = RoadDisplayNameSpecification(
          displayName: 'A1',
        );
        expect(
          specification.isSatisfiedBy(roadCorridors[0]),
          isTrue,
        );
        expect(
          specification.isSatisfiedBy(roadCorridors[1]),
          isFalse,
        );
        expect(
          roadCorridors.where(specification.isSatisfiedBy).toList(),
          hasLength(1),
        );

        specification = RoadDisplayNameSpecification(
          displayName: 'A0',
        );
        expect(
          specification.isSatisfiedBy(roadCorridors[0]),
          isFalse,
        );
        expect(
          specification.isSatisfiedBy(roadCorridors[1]),
          isFalse,
        );
        expect(
          roadCorridors.where(specification.isSatisfiedBy).toList(),
          isEmpty,
        );
      });
    });
  });
}
