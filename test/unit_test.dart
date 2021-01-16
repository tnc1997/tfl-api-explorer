import 'package:flutter_test/flutter_test.dart';
import 'package:tfl_api_client/tfl_api_client.dart';
import 'package:tfl_api_explorer/src/specifications/line_mode_name_specification.dart';
import 'package:tfl_api_explorer/src/specifications/line_route_service_type_specification.dart';
import 'package:tfl_api_explorer/src/specifications/place_common_name_specification.dart';
import 'package:tfl_api_explorer/src/specifications/prediction_destination_name_specification.dart';
import 'package:tfl_api_explorer/src/specifications/prediction_station_name_specification.dart';
import 'package:tfl_api_explorer/src/specifications/road_display_name_specification.dart';
import 'package:tfl_api_explorer/src/specifications/specification.dart';
import 'package:tfl_api_explorer/src/specifications/stop_point_modes_specification.dart';

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

  final lines = <Line>[
    Line(
      id: '1',
      name: '1',
      modeName: 'bus',
    ),
    Line(
      id: 'bakerloo',
      name: 'Bakerloo',
      modeName: 'tube',
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

  final predictions = <Prediction>[
    Prediction(
      stationName: 'Elephant & Castle',
      destinationName: 'Canada Water',
    ),
    Prediction(
      stationName: 'Elephant & Castle',
      destinationName: 'Tottenham Court Road',
    ),
    Prediction(
      stationName: 'Holborn',
      destinationName: 'Canada Water',
    ),
    Prediction(
      stationName: 'Holborn',
      destinationName: 'Tottenham Court Road',
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

  final stopPoints = <StopPoint>[
    StopPoint(
      naptanId: 'HUBZCW',
      modes: ['bus', 'overground', 'tube'],
      icsCode: '1000037',
      sMSCode: '48366',
      stopType: 'TransportInterchange',
      accessibilitySummary: 'Unknown',
      hubNaptanCode: 'HUBZCW',
      id: '490004733C',
      url: 'Unknown',
      commonName: 'Canada Water',
      placeType: 'StopPoint',
      lat: 51.498053,
      lon: -0.049667,
    ),
    StopPoint(
      naptanId: '940GZZLUTCR',
      modes: ['bus', 'tube'],
      icsCode: '1000235',
      sMSCode: '47657',
      stopType: 'NaptanMetroStation',
      accessibilitySummary: 'Unknown',
      hubNaptanCode: 'Unknown',
      id: '490000235N',
      url: 'Unknown',
      commonName: 'Tottenham Court Road',
      placeType: 'StopPoint',
      lat: 51.516426,
      lon: -0.13041,
    ),
  ];

  group('specifications', () {
    group('LineModeNameSpecification', () {
      test('isSatisfiedBy', () {
        Specification<Line> specification;

        specification = LineModeNameSpecification(
          modeName: 'bus',
        );
        expect(
          specification.isSatisfiedBy(lines[0]),
          isTrue,
        );
        expect(
          specification.isSatisfiedBy(lines[1]),
          isFalse,
        );
        expect(
          lines.where(specification.isSatisfiedBy).toList(),
          hasLength(1),
        );

        specification = LineModeNameSpecification(
          modeName: 'overground',
        );
        expect(
          specification.isSatisfiedBy(lines[0]),
          isFalse,
        );
        expect(
          specification.isSatisfiedBy(lines[1]),
          isFalse,
        );
        expect(
          lines.where(specification.isSatisfiedBy).toList(),
          isEmpty,
        );

        specification = LineModeNameSpecification(
          modeName: 'tube',
        );
        expect(
          specification.isSatisfiedBy(lines[0]),
          isFalse,
        );
        expect(
          specification.isSatisfiedBy(lines[1]),
          isTrue,
        );
        expect(
          lines.where(specification.isSatisfiedBy).toList(),
          hasLength(1),
        );
      });
    });

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

    group('PredictionDestinationNameSpecification', () {
      test('isSatisfiedBy', () {
        Specification<Prediction> specification;

        specification = PredictionDestinationNameSpecification(
          destinationName: 'Canada Water',
        );
        expect(
          specification.isSatisfiedBy(predictions[0]),
          isTrue,
        );
        expect(
          specification.isSatisfiedBy(predictions[1]),
          isFalse,
        );
        expect(
          specification.isSatisfiedBy(predictions[2]),
          isTrue,
        );
        expect(
          specification.isSatisfiedBy(predictions[3]),
          isFalse,
        );
        expect(
          predictions.where(specification.isSatisfiedBy).toList(),
          hasLength(2),
        );

        specification = PredictionDestinationNameSpecification(
          destinationName: 'Surrey Quays',
        );
        expect(
          specification.isSatisfiedBy(predictions[0]),
          isFalse,
        );
        expect(
          specification.isSatisfiedBy(predictions[1]),
          isFalse,
        );
        expect(
          specification.isSatisfiedBy(predictions[2]),
          isFalse,
        );
        expect(
          specification.isSatisfiedBy(predictions[3]),
          isFalse,
        );
        expect(
          predictions.where(specification.isSatisfiedBy).toList(),
          isEmpty,
        );

        specification = PredictionDestinationNameSpecification(
          destinationName: 'Tottenham Court Road',
        );
        expect(
          specification.isSatisfiedBy(predictions[0]),
          isFalse,
        );
        expect(
          specification.isSatisfiedBy(predictions[1]),
          isTrue,
        );
        expect(
          specification.isSatisfiedBy(predictions[2]),
          isFalse,
        );
        expect(
          specification.isSatisfiedBy(predictions[3]),
          isTrue,
        );
        expect(
          predictions.where(specification.isSatisfiedBy).toList(),
          hasLength(2),
        );
      });
    });

    group('PredictionStationNameSpecification', () {
      test('isSatisfiedBy', () {
        Specification<Prediction> specification;

        specification = PredictionStationNameSpecification(
          stationName: 'Elephant & Castle',
        );
        expect(
          specification.isSatisfiedBy(predictions[0]),
          isTrue,
        );
        expect(
          specification.isSatisfiedBy(predictions[1]),
          isTrue,
        );
        expect(
          specification.isSatisfiedBy(predictions[2]),
          isFalse,
        );
        expect(
          specification.isSatisfiedBy(predictions[3]),
          isFalse,
        );
        expect(
          predictions.where(specification.isSatisfiedBy).toList(),
          hasLength(2),
        );

        specification = PredictionStationNameSpecification(
          stationName: 'Holborn',
        );
        expect(
          specification.isSatisfiedBy(predictions[0]),
          isFalse,
        );
        expect(
          specification.isSatisfiedBy(predictions[1]),
          isFalse,
        );
        expect(
          specification.isSatisfiedBy(predictions[2]),
          isTrue,
        );
        expect(
          specification.isSatisfiedBy(predictions[3]),
          isTrue,
        );
        expect(
          predictions.where(specification.isSatisfiedBy).toList(),
          hasLength(2),
        );

        specification = PredictionStationNameSpecification(
          stationName: 'Waterloo',
        );
        expect(
          specification.isSatisfiedBy(predictions[0]),
          isFalse,
        );
        expect(
          specification.isSatisfiedBy(predictions[1]),
          isFalse,
        );
        expect(
          specification.isSatisfiedBy(predictions[2]),
          isFalse,
        );
        expect(
          specification.isSatisfiedBy(predictions[3]),
          isFalse,
        );
        expect(
          predictions.where(specification.isSatisfiedBy).toList(),
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

    group('StopPointModesSpecification', () {
      test('isSatisfiedBy', () {
        Specification<StopPoint> specification;

        specification = StopPointModesSpecification(
          modes: {'bus', 'overground', 'tube'},
        );
        expect(
          specification.isSatisfiedBy(stopPoints[0]),
          isTrue,
        );
        expect(
          specification.isSatisfiedBy(stopPoints[1]),
          isFalse,
        );
        expect(
          stopPoints.where(specification.isSatisfiedBy).toList(),
          hasLength(1),
        );

        specification = StopPointModesSpecification(
          modes: {'dlr'},
        );
        expect(
          specification.isSatisfiedBy(stopPoints[0]),
          isFalse,
        );
        expect(
          specification.isSatisfiedBy(stopPoints[1]),
          isFalse,
        );
        expect(
          stopPoints.where(specification.isSatisfiedBy).toList(),
          isEmpty,
        );
      });
    });
  });
}
