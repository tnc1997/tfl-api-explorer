import 'package:mockito/mockito.dart';
import 'package:tfl_api_client/tfl_api_client.dart';

class BikePointsResourceApiMock extends Mock implements BikePointsResourceApi {}

class CarParkOccupanciesResourceApiMock extends Mock
    implements CarParkOccupanciesResourceApi {}

class CarParksResourceApiMock extends Mock implements CarParksResourceApi {}

class LinesResourceApiMock extends Mock implements LinesResourceApi {}

class RoadsResourceApiMock extends Mock implements RoadsResourceApi {}

class StopPointsResourceApiMock extends Mock implements StopPointsResourceApi {}

class TflApiMock extends Mock implements TflApi {}
