import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/intl.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';
import 'package:tfl_api_client/tfl_api_client.dart';
import 'package:tfl_api_explorer/notifiers/line_filters_change_notifier.dart';
import 'package:tfl_api_explorer/notifiers/line_line_route_filters_change_notifier.dart';
import 'package:tfl_api_explorer/notifiers/line_prediction_filters_change_notifier.dart';
import 'package:tfl_api_explorer/pages/bike_points/bike_point_page.dart';
import 'package:tfl_api_explorer/pages/bike_points/bike_points_page.dart';
import 'package:tfl_api_explorer/pages/lines/line_line_disruptions_page.dart';
import 'package:tfl_api_explorer/pages/lines/line_line_routes_page.dart';
import 'package:tfl_api_explorer/pages/lines/line_line_statuses_page.dart';
import 'package:tfl_api_explorer/pages/lines/line_page.dart';
import 'package:tfl_api_explorer/pages/lines/line_predictions_page.dart';
import 'package:tfl_api_explorer/pages/lines/line_route_sequences_page.dart';
import 'package:tfl_api_explorer/pages/lines/line_stop_points_page.dart';
import 'package:tfl_api_explorer/pages/lines/lines_page.dart';
import 'package:tfl_api_explorer/pages/settings/about_page.dart';
import 'package:tfl_api_explorer/pages/settings/account_page.dart';
import 'package:tfl_api_explorer/pages/settings/settings_page.dart';
import 'package:tfl_api_explorer/pages/home_page.dart';
import 'package:tfl_api_explorer/states/tfl_api_state.dart';

import 'mocks/tfl_api_mock.dart';
import 'mocks/tfl_api_state_mock.dart';

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
      id: '490004733C',
      commonName: 'Canada Water',
    ),
    StopPoint(
      id: '490000235N',
      commonName: 'Tottenham Court Road',
    ),
  ];

  final _tflApi = TflApiMock();

  final _tflApiState = TflApiStateMock();

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
              providers: <SingleChildCloneableWidget>[
                Provider<TflApiState>.value(value: _tflApiState),
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
              providers: <SingleChildCloneableWidget>[
                Provider<TflApiState>.value(value: _tflApiState),
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
              providers: <SingleChildCloneableWidget>[
                ChangeNotifierProvider(
                  builder: (context) {
                    return LineLineRouteFiltersChangeNotifier();
                  },
                ),
                Provider<TflApiState>.value(value: _tflApiState),
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
              providers: <SingleChildCloneableWidget>[
                Provider<TflApiState>.value(value: _tflApiState),
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
              providers: <SingleChildCloneableWidget>[
                ChangeNotifierProvider(
                  builder: (context) {
                    return LinePredictionFiltersChangeNotifier();
                  },
                ),
                Provider<TflApiState>.value(value: _tflApiState),
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
              providers: <SingleChildCloneableWidget>[
                Provider<TflApiState>.value(value: _tflApiState),
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
              providers: <SingleChildCloneableWidget>[
                Provider<TflApiState>.value(value: _tflApiState),
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
              providers: <SingleChildCloneableWidget>[
                ChangeNotifierProvider<LineFiltersChangeNotifier>(
                  builder: (context) {
                    return LineFiltersChangeNotifier();
                  },
                ),
                Provider<TflApiState>.value(value: _tflApiState),
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
        testWidgets('App id', (tester) async {
          await tester.pumpWidget(
            MultiProvider(
              providers: <SingleChildCloneableWidget>[
                Provider<TflApiState>.value(value: _tflApiState),
              ],
              child: MaterialApp(
                home: AccountPage(),
              ),
            ),
          );

          expect(
            find.text('App id'),
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
              providers: <SingleChildCloneableWidget>[
                Provider<TflApiState>.value(value: _tflApiState),
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

    when(_linesResourceApi.get()).thenAnswer((answer) {
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

    when(_tflApi.bikePoints).thenReturn(_bikePointsResourceApi);
    when(_tflApi.lines).thenReturn(_linesResourceApi);

    when(_tflApiState.appId).thenReturn('123');
    when(_tflApiState.appKey).thenReturn('abc');
    when(_tflApiState.tflApi).thenReturn(_tflApi);
  });
}
