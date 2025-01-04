import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';
import 'package:tfl_api_client/tfl_api_client.dart';
import 'package:tfl_api_explorer/src/pages/bike_points/bike_points_page.dart';

import 'integration_test.mocks.dart';

@GenerateMocks([
  BikePointService,
  TflApiClient,
])
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

  final bikePointService = MockBikePointService();

  final tflApi = MockTflApiClient();

  setUpAll(() {
    when(bikePointService.getAll()).thenAnswer((answer) {
      return Future.delayed(
        Duration(seconds: 1),
        () => bikePoints,
      );
    });

    when(tflApi.bikePoints).thenReturn(bikePointService);
  });

  testWidgets('Bike point search', (tester) async {
    await tester.pumpWidget(
      MultiProvider(
        providers: [
          Provider<TflApiClient>.value(
            value: tflApi,
          ),
        ],
        child: MaterialApp(
          home: BikePointsPage(),
        ),
      ),
    );
    await tester.pumpAndSettle();

    await tester.tap(find.byIcon(Icons.search));
    await tester.pumpAndSettle();

    bikePoints.forEach((bikePoint) {
      expect(
        find.text(bikePoint.commonName!),
        findsWidgets,
      );
    });

    await tester.enterText(find.byType(TextField), 'clerkenwell');
    await tester.pumpAndSettle();

    expect(
      find.text(bikePoints[0].commonName!),
      findsWidgets,
    );

    await tester.tap(find.text(bikePoints[0].commonName!));
    await tester.pumpAndSettle();

    expect(
      find.text(bikePoints[0].id!),
      findsWidgets,
    );
    expect(
      find.text(bikePoints[0].commonName!),
      findsWidgets,
    );
  });
}
