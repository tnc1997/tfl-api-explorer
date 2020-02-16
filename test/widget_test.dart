import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/intl.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';
import 'package:tfl_api_client/tfl_api_client.dart';
import 'package:tfl_api_explorer/src/notifiers/authentication_change_notifier.dart';
import 'package:tfl_api_explorer/src/notifiers/line_filters_change_notifier.dart';
import 'package:tfl_api_explorer/src/notifiers/line_line_route_filters_change_notifier.dart';
import 'package:tfl_api_explorer/src/notifiers/line_prediction_filters_change_notifier.dart';
import 'package:tfl_api_explorer/src/notifiers/stop_point_filters_change_notifier.dart';
import 'package:tfl_api_explorer/src/pages/bike_points/bike_point_page.dart';
import 'package:tfl_api_explorer/src/pages/bike_points/bike_points_page.dart';
import 'package:tfl_api_explorer/src/pages/home_page.dart';
import 'package:tfl_api_explorer/src/pages/lines/line_line_disruptions_page.dart';
import 'package:tfl_api_explorer/src/pages/lines/line_line_routes_page.dart';
import 'package:tfl_api_explorer/src/pages/lines/line_line_statuses_page.dart';
import 'package:tfl_api_explorer/src/pages/lines/line_page.dart';
import 'package:tfl_api_explorer/src/pages/lines/line_predictions_page.dart';
import 'package:tfl_api_explorer/src/pages/lines/line_route_sequences_page.dart';
import 'package:tfl_api_explorer/src/pages/lines/line_stop_points_page.dart';
import 'package:tfl_api_explorer/src/pages/lines/lines_page.dart';
import 'package:tfl_api_explorer/src/pages/settings/about_page.dart';
import 'package:tfl_api_explorer/src/pages/settings/account_page.dart';
import 'package:tfl_api_explorer/src/pages/settings/settings_page.dart';
import 'package:tfl_api_explorer/src/pages/stop_points/stop_point_page.dart';
import 'package:tfl_api_explorer/src/pages/stop_points/stop_points_page.dart';

import 'mocks/authentication_change_notifier_mock.dart';
import 'mocks/tfl_api_mock.dart';

void main() {
  final _authenticationChangeNotifier = AuthenticationChangeNotifierMock();

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

  final _bikePointsResourceApi = BikePointsResourceApiMock();

  final _lineDisruptions = <LineDisruption>[
    LineDisruption(
      categoryDescription: 'PlannedWork',
      description: 'This is a planned work line disruption.',
      created: DateTime(2020, 1, 1, 0, 0),
    ),
    LineDisruption(
      categoryDescription: 'RealTime',
      description: 'This is a real time line disruption.',
      created: DateTime(2020, 1, 1, 12, 0),
    ),
  ];

  final _lineRoutes = <LineRoute>[
    LineRoute(
      name: 'Canada Water - Tottenham Court Road',
      serviceType: 'Regular',
    ),
    LineRoute(
      name: 'Tottenham Court Road - Canada Water',
      serviceType: 'Regular',
    ),
  ];

  final _lineStatuses = <LineStatus>[
    LineStatus(
      statusSeverityDescription: 'Good Service',
    ),
    LineStatus(
      statusSeverityDescription: 'Part Closure',
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

  final _linesResourceApi = LinesResourceApiMock();

  final _predictions = <Prediction>[
    Prediction(
      id: '1',
      destinationName: 'Canada Water',
      expectedArrival: DateTime(2020, 1, 1, 0, 0),
    ),
    Prediction(
      id: '2',
      destinationName: 'Tottenham Court Road',
      expectedArrival: DateTime(2020, 1, 1, 12, 0),
    ),
  ];

  final _routeSequences = <RouteSequence>[
    RouteSequence(
      direction: 'Inbound',
      orderedLineRoutes: <OrderedRoute>[
        OrderedRoute(
          name: 'Inbound Route',
        ),
      ],
    ),
    RouteSequence(
      direction: 'Outbound',
      orderedLineRoutes: <OrderedRoute>[
        OrderedRoute(
          name: 'Outbound Route',
        ),
      ],
    ),
  ];

  final _stopPoints = <StopPoint>[
    StopPoint(
      naptanId: 'HUBZCW',
      modes: ['bus', 'overground', 'tube'],
      icsCode: '1000037',
      smsCode: '48366',
      stopType: 'TransportInterchange',
      accessibilitySummary: 'N/A',
      hubNaptanCode: 'HUBZCW',
      id: '490004733C',
      url: 'N/A',
      commonName: 'Canada Water',
      placeType: 'StopPoint',
      lat: 51.498053,
      lon: -0.049667,
    ),
    StopPoint(
      naptanId: '940GZZLUTCR',
      modes: ['bus', 'tube'],
      icsCode: '1000235',
      smsCode: '47657',
      stopType: 'NaptanMetroStation',
      accessibilitySummary: 'N/A',
      hubNaptanCode: 'N/A',
      id: '490000235N',
      url: 'N/A',
      commonName: 'Tottenham Court Road',
      placeType: 'StopPoint',
      lat: 51.516426,
      lon: -0.13041,
    ),
  ];

  final _stopPointsResourceApi = StopPointsResourceApiMock();

  final _tflApi = TflApiMock();

  group('pages', () {
    group('bike_points', () {
      group('BikePointPage', () {
        final _bikePoint = _bikePoints[0];

        testWidgets('Name', (tester) async {
          await tester.pumpWidget(
            MaterialApp(
              home: BikePointPage(bikePoint: _bikePoint),
            ),
          );

          expect(
            find.text('Name'),
            findsWidgets,
          );
          expect(
            find.text(_bikePoint.commonName),
            findsWidgets,
          );
        });

        testWidgets('Place type', (tester) async {
          await tester.pumpWidget(
            MaterialApp(
              home: BikePointPage(bikePoint: _bikePoint),
            ),
          );

          expect(
            find.text('Place type'),
            findsWidgets,
          );
          expect(
            find.text(_bikePoint.placeType),
            findsWidgets,
          );
        });

        testWidgets('Lat', (tester) async {
          await tester.pumpWidget(
            MaterialApp(
              home: BikePointPage(bikePoint: _bikePoint),
            ),
          );

          expect(
            find.text('Lat'),
            findsWidgets,
          );
          expect(
            find.text('${_bikePoint.lat}'),
            findsWidgets,
          );
        });

        testWidgets('Lon', (tester) async {
          await tester.pumpWidget(
            MaterialApp(
              home: BikePointPage(bikePoint: _bikePoint),
            ),
          );

          expect(
            find.text('Lon'),
            findsWidgets,
          );
          expect(
            find.text('${_bikePoint.lon}'),
            findsWidgets,
          );
        });
      });

      group('BikePointsPage', () {
        testWidgets('', (tester) async {
          await tester.pumpWidget(
            MultiProvider(
              providers: [
                Provider<TflApi>.value(
                  value: _tflApi,
                ),
              ],
              child: MaterialApp(
                home: BikePointsPage(),
              ),
            ),
          );
          await tester.pumpAndSettle();

          _bikePoints.forEach((bikePoint) {
            expect(
              find.text(bikePoint.id),
              findsWidgets,
            );
            expect(
              find.text(bikePoint.commonName),
              findsWidgets,
            );
          });
        });
      });
    });

    group('lines', () {
      group('LineLineDisruptionsPage', () {
        final _line = _lines[0];

        testWidgets('', (tester) async {
          await tester.pumpWidget(
            MultiProvider(
              providers: [
                Provider<TflApi>.value(
                  value: _tflApi,
                ),
              ],
              child: MaterialApp(
                home: LineLineDisruptionsPage(line: _line),
              ),
            ),
          );
          await tester.pumpAndSettle();

          _lineDisruptions.forEach((lineDisruption) {
            expect(
              find.text(lineDisruption.categoryDescription),
              findsWidgets,
            );
            expect(
              find.text(DateFormat.Hm().format(lineDisruption.created)),
              findsWidgets,
            );
          });
        });
      });

      group('LineLineRoutesPage', () {
        final _line = _lines[0];

        testWidgets('', (tester) async {
          await tester.pumpWidget(
            MultiProvider(
              providers: [
                ChangeNotifierProvider<LineLineRouteFiltersChangeNotifier>(
                  create: (context) {
                    return LineLineRouteFiltersChangeNotifier();
                  },
                ),
                Provider<TflApi>.value(
                  value: _tflApi,
                ),
              ],
              child: MaterialApp(
                home: LineLineRoutesPage(line: _line),
              ),
            ),
          );
          await tester.pumpAndSettle();

          _lineRoutes.forEach((lineRoute) {
            expect(
              find.text(lineRoute.name),
              findsWidgets,
            );
            expect(
              find.text(lineRoute.serviceType),
              findsWidgets,
            );
          });
        });
      });

      group('LineLineStatusesPage', () {
        final _line = _lines[0];

        testWidgets('', (tester) async {
          await tester.pumpWidget(
            MultiProvider(
              providers: [
                Provider<TflApi>.value(
                  value: _tflApi,
                ),
              ],
              child: MaterialApp(
                home: LineLineStatusesPage(line: _line),
              ),
            ),
          );
          await tester.pumpAndSettle();

          _lineStatuses.forEach((lineStatus) {
            expect(
              find.text(lineStatus.statusSeverityDescription),
              findsWidgets,
            );
          });
        });
      });

      group('LinePage', () {
        final _line = _lines[0];

        testWidgets('Mode name', (tester) async {
          await tester.pumpWidget(
            MaterialApp(
              home: LinePage(line: _line),
            ),
          );

          expect(
            find.text('Mode name'),
            findsWidgets,
          );
          expect(
            find.text(_line.modeName),
            findsWidgets,
          );
        });

        testWidgets('Name', (tester) async {
          await tester.pumpWidget(
            MaterialApp(
              home: LinePage(line: _line),
            ),
          );

          expect(
            find.text('Name'),
            findsWidgets,
          );
          expect(
            find.text(_line.name),
            findsWidgets,
          );
        });
      });

      group('LinePredictionsPage', () {
        final _line = _lines[0];

        testWidgets('', (tester) async {
          await tester.pumpWidget(
            MultiProvider(
              providers: [
                ChangeNotifierProvider<LinePredictionFiltersChangeNotifier>(
                  create: (context) {
                    return LinePredictionFiltersChangeNotifier();
                  },
                ),
                Provider<TflApi>.value(
                  value: _tflApi,
                ),
              ],
              child: MaterialApp(
                home: LinePredictionsPage(line: _line),
              ),
            ),
          );
          await tester.pumpAndSettle();

          _predictions.forEach((prediction) {
            expect(
              find.text(prediction.id),
              findsWidgets,
            );
            expect(
              find.text(
                '${DateFormat.Hm().format(prediction.expectedArrival)} - ${prediction.destinationName}',
              ),
              findsWidgets,
            );
          });
        });
      });

      group('LineRouteSequencesPage', () {
        final _line = _lines[0];

        testWidgets('', (tester) async {
          await tester.pumpWidget(
            MultiProvider(
              providers: [
                Provider<TflApi>.value(
                  value: _tflApi,
                ),
              ],
              child: MaterialApp(
                home: LineRouteSequencesPage(line: _line),
              ),
            ),
          );
          await tester.pumpAndSettle();

          _routeSequences.forEach((routeSequence) {
            expect(
              find.text(routeSequence.direction),
              findsWidgets,
            );
            expect(
              find.text(routeSequence.orderedLineRoutes.first.name),
              findsWidgets,
            );
          });
        });
      });

      group('LineStopPointsPage', () {
        final _line = _lines[0];

        testWidgets('', (tester) async {
          await tester.pumpWidget(
            MultiProvider(
              providers: [
                Provider<TflApi>.value(
                  value: _tflApi,
                ),
              ],
              child: MaterialApp(
                home: LineStopPointsPage(line: _line),
              ),
            ),
          );
          await tester.pumpAndSettle();

          _stopPoints.forEach((stopPoint) {
            expect(
              find.text(stopPoint.id),
              findsWidgets,
            );
            expect(
              find.text(stopPoint.commonName),
              findsWidgets,
            );
          });
        });
      });

      group('LinesPage', () {
        testWidgets('', (tester) async {
          await tester.pumpWidget(
            MultiProvider(
              providers: [
                ChangeNotifierProvider<LineFiltersChangeNotifier>(
                  create: (context) {
                    return LineFiltersChangeNotifier();
                  },
                ),
                Provider<TflApi>.value(
                  value: _tflApi,
                ),
              ],
              child: MaterialApp(
                home: LinesPage(),
              ),
            ),
          );
          await tester.pumpAndSettle();

          _lines.forEach((line) {
            expect(
              find.text(line.id),
              findsWidgets,
            );
            expect(
              find.text(line.name),
              findsWidgets,
            );
          });
        });
      });
    });

    group('settings', () {
      group('AboutPage', () {
        setUpAll(() {
          MethodChannel(
            'plugins.flutter.io/package_info',
          ).setMockMethodCallHandler((methodCall) async {
            switch (methodCall.method) {
              case 'getAll':
                return <String, dynamic>{
                  'appName': 'TfL API Explorer',
                  'packageName': 'app.thomasclark.tflapiexplorer',
                  'version': '1.0.0',
                  'buildNumber': '10000'
                };
              default:
                return null;
            }
          });
        });

        testWidgets('Package name', (tester) async {
          await tester.pumpWidget(
            MaterialApp(
              home: AboutPage(),
            ),
          );
          await tester.pumpAndSettle();

          expect(
            find.text('Package name'),
            findsWidgets,
          );
          expect(
            find.text('app.thomasclark.tflapiexplorer'),
            findsWidgets,
          );
        });

        testWidgets('Version', (tester) async {
          await tester.pumpWidget(
            MaterialApp(
              home: AboutPage(),
            ),
          );
          await tester.pumpAndSettle();

          expect(
            find.text('Version'),
            findsWidgets,
          );
          expect(
            find.text('1.0.0'),
            findsWidgets,
          );
        });
      });

      group('AccountPage', () {
        testWidgets('App ID', (tester) async {
          await tester.pumpWidget(
            MultiProvider(
              providers: [
                ChangeNotifierProvider<AuthenticationChangeNotifier>.value(
                  value: _authenticationChangeNotifier,
                ),
              ],
              child: MaterialApp(
                home: AccountPage(),
              ),
            ),
          );

          expect(
            find.text('App ID'),
            findsWidgets,
          );
          expect(
            find.text('123'),
            findsWidgets,
          );
        });

        testWidgets('App key', (tester) async {
          await tester.pumpWidget(
            MultiProvider(
              providers: [
                ChangeNotifierProvider<AuthenticationChangeNotifier>.value(
                  value: _authenticationChangeNotifier,
                ),
              ],
              child: MaterialApp(
                home: AccountPage(),
              ),
            ),
          );

          expect(
            find.text('App key'),
            findsWidgets,
          );
          expect(
            find.text('abc'),
            findsWidgets,
          );
        });
      });

      group('SettingsPage', () {
        testWidgets('', (tester) async {
          await tester.pumpWidget(
            MaterialApp(
              home: SettingsPage(),
            ),
          );

          expect(
            find.text('Account'),
            findsWidgets,
          );
          expect(
            find.text('About'),
            findsWidgets,
          );
        });
      });
    });

    group('stop_points', () {
      group('StopPointPage', () {
        final _stopPoint = _stopPoints[0];

        testWidgets('Name', (tester) async {
          await tester.pumpWidget(
            MaterialApp(
              home: StopPointPage(stopPoint: _stopPoint),
            ),
          );

          expect(
            find.text('Name'),
            findsWidgets,
          );
          expect(
            find.text(_stopPoint.commonName),
            findsWidgets,
          );
        });

        testWidgets('ICS code', (tester) async {
          await tester.pumpWidget(
            MaterialApp(
              home: StopPointPage(stopPoint: _stopPoint),
            ),
          );

          expect(
            find.text('ICS code'),
            findsWidgets,
          );
          expect(
            find.text(_stopPoint.icsCode),
            findsWidgets,
          );
        });

        testWidgets('SMS code', (tester) async {
          await tester.pumpWidget(
            MaterialApp(
              home: StopPointPage(stopPoint: _stopPoint),
            ),
          );

          expect(
            find.text('SMS code'),
            findsWidgets,
          );
          expect(
            find.text(_stopPoint.smsCode),
            findsWidgets,
          );
        });

        testWidgets('Stop type', (tester) async {
          await tester.pumpWidget(
            MaterialApp(
              home: StopPointPage(stopPoint: _stopPoint),
            ),
          );

          expect(
            find.text('Stop type'),
            findsWidgets,
          );
          expect(
            find.text(_stopPoint.stopType),
            findsWidgets,
          );
        });

        testWidgets('Accessibility', (tester) async {
          await tester.pumpWidget(
            MaterialApp(
              home: StopPointPage(stopPoint: _stopPoint),
            ),
          );

          expect(
            find.text('Accessibility'),
            findsWidgets,
          );
          expect(
            find.text(_stopPoint.accessibilitySummary),
            findsWidgets,
          );
        });

        testWidgets('Hub NaPTAN code', (tester) async {
          await tester.pumpWidget(
            MaterialApp(
              home: StopPointPage(stopPoint: _stopPoint),
            ),
          );

          expect(
            find.text('Hub NaPTAN code'),
            findsWidgets,
          );
          expect(
            find.text(_stopPoint.hubNaptanCode),
            findsWidgets,
          );
        });

        testWidgets('URL', (tester) async {
          await tester.pumpWidget(
            MaterialApp(
              home: StopPointPage(stopPoint: _stopPoint),
            ),
          );

          expect(
            find.text('URL'),
            findsWidgets,
          );
          expect(
            find.text(_stopPoint.url),
            findsWidgets,
          );
        });

        testWidgets('Place type', (tester) async {
          await tester.pumpWidget(
            MaterialApp(
              home: StopPointPage(stopPoint: _stopPoint),
            ),
          );

          expect(
            find.text('Place type'),
            findsWidgets,
          );
          expect(
            find.text(_stopPoint.placeType),
            findsWidgets,
          );
        });
      });

      group('StopPointsPage', () {
        testWidgets('', (tester) async {
          await tester.pumpWidget(
            MultiProvider(
              providers: [
                ChangeNotifierProvider<StopPointFiltersChangeNotifier>(
                  create: (context) {
                    return StopPointFiltersChangeNotifier();
                  },
                ),
                Provider<TflApi>.value(
                  value: _tflApi,
                ),
              ],
              child: MaterialApp(
                home: StopPointsPage(),
              ),
            ),
          );
          await tester.pumpAndSettle();

          _stopPoints.forEach((stopPoint) {
            expect(
              find.text(stopPoint.id),
              findsWidgets,
            );
            expect(
              find.text(stopPoint.commonName),
              findsWidgets,
            );
          });
        });
      });
    });

    group('HomePage', () {
      testWidgets('Welcome to the TfL API Explorer', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: HomePage(),
          ),
        );

        expect(
          find.text('Welcome to the TfL API Explorer'),
          findsWidgets,
        );
      });
    });
  });

  setUpAll(() {
    when(_bikePointsResourceApi.get()).thenAnswer((answer) {
      return Future.delayed(
        Duration(seconds: 1),
        () => _bikePoints,
      );
    });

    when(_linesResourceApi.get(mode: anyNamed('mode'))).thenAnswer((answer) {
      return Future.delayed(
        Duration(seconds: 1),
        () => _lines,
      );
    });
    when(_linesResourceApi.getLineDisruptions(any)).thenAnswer((answer) {
      return Future.delayed(
        Duration(seconds: 1),
        () => _lineDisruptions,
      );
    });
    when(_linesResourceApi.getLineRoutes(any)).thenAnswer((answer) {
      return Future.delayed(
        Duration(seconds: 1),
        () => _lineRoutes,
      );
    });
    when(_linesResourceApi.getLineStatuses(any)).thenAnswer((answer) {
      return Future.delayed(
        Duration(seconds: 1),
        () => _lineStatuses,
      );
    });
    when(_linesResourceApi.getPredictions(any)).thenAnswer((answer) {
      return Future.delayed(
        Duration(seconds: 1),
        () => _predictions,
      );
    });
    when(_linesResourceApi.getRouteSequences(any)).thenAnswer((answer) {
      return Future.delayed(
        Duration(seconds: 1),
        () => _routeSequences,
      );
    });
    when(_linesResourceApi.getStopPoints(any)).thenAnswer((answer) {
      return Future.delayed(
        Duration(seconds: 1),
        () => _stopPoints,
      );
    });

    when(_stopPointsResourceApi.get(type: anyNamed('type'), mode: anyNamed('mode'))).thenAnswer((answer) {
      return Future.delayed(
        Duration(seconds: 1),
        () => _stopPoints,
      );
    });

    when(_tflApi.bikePoints).thenReturn(_bikePointsResourceApi);
    when(_tflApi.lines).thenReturn(_linesResourceApi);
    when(_tflApi.stopPoints).thenReturn(_stopPointsResourceApi);

    when(_authenticationChangeNotifier.appId).thenReturn('123');
    when(_authenticationChangeNotifier.appKey).thenReturn('abc');
  });
}
