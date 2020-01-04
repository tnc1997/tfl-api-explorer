import 'package:flutter_test/flutter_test.dart';
import 'package:tfl_api_client/tfl_api_client.dart';
import 'package:tfl_api_explorer/src/specifications/line_mode_name_specification.dart';
import 'package:tfl_api_explorer/src/specifications/line_route_service_type_specification.dart';
import 'package:tfl_api_explorer/src/specifications/place_common_name_specification.dart';
import 'package:tfl_api_explorer/src/specifications/prediction_destination_name_specification.dart';
import 'package:tfl_api_explorer/src/specifications/prediction_station_name_specification.dart';
import 'package:tfl_api_explorer/src/specifications/specification.dart';

void main() {
  final _bikePoints = <Place>[
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

  final _lineRoutes = <LineRoute>[
    LineRoute(
      serviceType: 'Night',
    ),
    LineRoute(
      serviceType: 'Regular',
    ),
  ];

  final _lines = <Line>[
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

  final _predictions = <Prediction>[
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

  group('specifications', () {
    group('LineModeNameSpecification', () {
      test('isSatisfiedBy', () {
        Specification<Line> specification;

        specification = LineModeNameSpecification(
          modeName: 'bus',
        );
        expect(
          specification.isSatisfiedBy(_lines[0]),
          isTrue,
        );
        expect(
          specification.isSatisfiedBy(_lines[1]),
          isFalse,
        );
        expect(
          _lines.where(specification.isSatisfiedBy).toList(),
          hasLength(1),
        );

        specification = LineModeNameSpecification(
          modeName: 'overground',
        );
        expect(
          specification.isSatisfiedBy(_lines[0]),
          isFalse,
        );
        expect(
          specification.isSatisfiedBy(_lines[1]),
          isFalse,
        );
        expect(
          _lines.where(specification.isSatisfiedBy).toList(),
          isEmpty,
        );

        specification = LineModeNameSpecification(
          modeName: 'tube',
        );
        expect(
          specification.isSatisfiedBy(_lines[0]),
          isFalse,
        );
        expect(
          specification.isSatisfiedBy(_lines[1]),
          isTrue,
        );
        expect(
          _lines.where(specification.isSatisfiedBy).toList(),
          hasLength(1),
        );
      });
    });

    group('LineRouteServiceTypeSpecification', () {
      test('isSatisfiedBy', () {
        Specification<LineRoute> specification;

        specification = LineRouteServiceTypeSpecification(
          serviceType: 'Day',
        );
        expect(
          specification.isSatisfiedBy(_lineRoutes[0]),
          isFalse,
        );
        expect(
          specification.isSatisfiedBy(_lineRoutes[1]),
          isFalse,
        );
        expect(
          _lineRoutes.where(specification.isSatisfiedBy).toList(),
          isEmpty,
        );

        specification = LineRouteServiceTypeSpecification(
          serviceType: 'Night',
        );
        expect(
          specification.isSatisfiedBy(_lineRoutes[0]),
          isTrue,
        );
        expect(
          specification.isSatisfiedBy(_lineRoutes[1]),
          isFalse,
        );
        expect(
          _lineRoutes.where(specification.isSatisfiedBy).toList(),
          hasLength(1),
        );

        specification = LineRouteServiceTypeSpecification(
          serviceType: 'Regular',
        );
        expect(
          specification.isSatisfiedBy(_lineRoutes[0]),
          isFalse,
        );
        expect(
          specification.isSatisfiedBy(_lineRoutes[1]),
          isTrue,
        );
        expect(
          _lineRoutes.where(specification.isSatisfiedBy).toList(),
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
          specification.isSatisfiedBy(_bikePoints[0]),
          isFalse,
        );
        expect(
          specification.isSatisfiedBy(_bikePoints[1]),
          isFalse,
        );
        expect(
          specification.isSatisfiedBy(_bikePoints[2]),
          isTrue,
        );
        expect(
          _bikePoints.where(specification.isSatisfiedBy).toList(),
          hasLength(1),
        );

        specification = PlaceCommonNameSpecification(
          commonName: 'Russell Street',
        );
        expect(
          specification.isSatisfiedBy(_bikePoints[0]),
          isFalse,
        );
        expect(
          specification.isSatisfiedBy(_bikePoints[1]),
          isFalse,
        );
        expect(
          specification.isSatisfiedBy(_bikePoints[2]),
          isFalse,
        );
        expect(
          _bikePoints.where(specification.isSatisfiedBy).toList(),
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
          specification.isSatisfiedBy(_predictions[0]),
          isTrue,
        );
        expect(
          specification.isSatisfiedBy(_predictions[1]),
          isFalse,
        );
        expect(
          specification.isSatisfiedBy(_predictions[2]),
          isTrue,
        );
        expect(
          specification.isSatisfiedBy(_predictions[3]),
          isFalse,
        );
        expect(
          _predictions.where(specification.isSatisfiedBy).toList(),
          hasLength(2),
        );

        specification = PredictionDestinationNameSpecification(
          destinationName: 'Surrey Quays',
        );
        expect(
          specification.isSatisfiedBy(_predictions[0]),
          isFalse,
        );
        expect(
          specification.isSatisfiedBy(_predictions[1]),
          isFalse,
        );
        expect(
          specification.isSatisfiedBy(_predictions[2]),
          isFalse,
        );
        expect(
          specification.isSatisfiedBy(_predictions[3]),
          isFalse,
        );
        expect(
          _predictions.where(specification.isSatisfiedBy).toList(),
          isEmpty,
        );

        specification = PredictionDestinationNameSpecification(
          destinationName: 'Tottenham Court Road',
        );
        expect(
          specification.isSatisfiedBy(_predictions[0]),
          isFalse,
        );
        expect(
          specification.isSatisfiedBy(_predictions[1]),
          isTrue,
        );
        expect(
          specification.isSatisfiedBy(_predictions[2]),
          isFalse,
        );
        expect(
          specification.isSatisfiedBy(_predictions[3]),
          isTrue,
        );
        expect(
          _predictions.where(specification.isSatisfiedBy).toList(),
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
          specification.isSatisfiedBy(_predictions[0]),
          isTrue,
        );
        expect(
          specification.isSatisfiedBy(_predictions[1]),
          isTrue,
        );
        expect(
          specification.isSatisfiedBy(_predictions[2]),
          isFalse,
        );
        expect(
          specification.isSatisfiedBy(_predictions[3]),
          isFalse,
        );
        expect(
          _predictions.where(specification.isSatisfiedBy).toList(),
          hasLength(2),
        );

        specification = PredictionStationNameSpecification(
          stationName: 'Holborn',
        );
        expect(
          specification.isSatisfiedBy(_predictions[0]),
          isFalse,
        );
        expect(
          specification.isSatisfiedBy(_predictions[1]),
          isFalse,
        );
        expect(
          specification.isSatisfiedBy(_predictions[2]),
          isTrue,
        );
        expect(
          specification.isSatisfiedBy(_predictions[3]),
          isTrue,
        );
        expect(
          _predictions.where(specification.isSatisfiedBy).toList(),
          hasLength(2),
        );

        specification = PredictionStationNameSpecification(
          stationName: 'Waterloo',
        );
        expect(
          specification.isSatisfiedBy(_predictions[0]),
          isFalse,
        );
        expect(
          specification.isSatisfiedBy(_predictions[1]),
          isFalse,
        );
        expect(
          specification.isSatisfiedBy(_predictions[2]),
          isFalse,
        );
        expect(
          specification.isSatisfiedBy(_predictions[3]),
          isFalse,
        );
        expect(
          _predictions.where(specification.isSatisfiedBy).toList(),
          isEmpty,
        );
      });
    });
  });
}
