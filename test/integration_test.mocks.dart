import 'dart:async' as _i15;

import 'package:mockito/mockito.dart' as _i1;
import 'package:tfl_api_client/src/models/place.dart' as _i2;
import 'package:tfl_api_client/src/services/accident_stat_service.dart' as _i3;
import 'package:tfl_api_client/src/services/air_quality_service.dart' as _i4;
import 'package:tfl_api_client/src/services/bike_point_service.dart' as _i5;
import 'package:tfl_api_client/src/services/journey_service.dart' as _i6;
import 'package:tfl_api_client/src/services/line_service.dart' as _i7;
import 'package:tfl_api_client/src/services/mode_service.dart' as _i8;
import 'package:tfl_api_client/src/services/occupancy_service.dart' as _i9;
import 'package:tfl_api_client/src/services/place_service.dart' as _i10;
import 'package:tfl_api_client/src/services/road_service.dart' as _i11;
import 'package:tfl_api_client/src/services/search_service.dart' as _i12;
import 'package:tfl_api_client/src/services/stop_point_service.dart' as _i13;
import 'package:tfl_api_client/src/services/vehicle_service.dart' as _i14;
import 'package:tfl_api_client/src/tfl_api_client_base.dart' as _i16;

// ignore_for_file: comment_references

// ignore_for_file: unnecessary_parenthesis

class _FakePlace extends _i1.Fake implements _i2.Place {}

class _FakeAccidentStatService extends _i1.Fake
    implements _i3.AccidentStatService {}

class _FakeAirQualityService extends _i1.Fake implements _i4.AirQualityService {
}

class _FakeBikePointService extends _i1.Fake implements _i5.BikePointService {}

class _FakeJourneyService extends _i1.Fake implements _i6.JourneyService {}

class _FakeLineService extends _i1.Fake implements _i7.LineService {}

class _FakeModeService extends _i1.Fake implements _i8.ModeService {}

class _FakeOccupancyService extends _i1.Fake implements _i9.OccupancyService {}

class _FakePlaceService extends _i1.Fake implements _i10.PlaceService {}

class _FakeRoadService extends _i1.Fake implements _i11.RoadService {}

class _FakeSearchService extends _i1.Fake implements _i12.SearchService {}

class _FakeStopPointService extends _i1.Fake implements _i13.StopPointService {}

class _FakeVehicleService extends _i1.Fake implements _i14.VehicleService {}

/// A class which mocks [BikePointService].
///
/// See the documentation for Mockito's code generation for more information.
class MockBikePointService extends _i1.Mock implements _i5.BikePointService {
  MockBikePointService() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i15.Future<List<_i2.Place>> getAll() => (super.noSuchMethod(
          Invocation.method(#getAll, []), Future.value(<_i2.Place>[]))
      as _i15.Future<List<_i2.Place>>);
  @override
  _i15.Future<_i2.Place> get(String? id) => (super.noSuchMethod(
          Invocation.method(#get, [id]), Future.value(_FakePlace()))
      as _i15.Future<_i2.Place>);
  @override
  _i15.Future<List<_i2.Place>> search(String? query) => (super.noSuchMethod(
          Invocation.method(#search, [query]), Future.value(<_i2.Place>[]))
      as _i15.Future<List<_i2.Place>>);
}

/// A class which mocks [TflApiClient].
///
/// See the documentation for Mockito's code generation for more information.
class MockTflApiClient extends _i1.Mock implements _i16.TflApiClient {
  MockTflApiClient() {
    _i1.throwOnMissingStub(this);
  }

  _i3.AccidentStatService get accidentStats => (super.noSuchMethod(
          Invocation.getter(#accidentStats), _FakeAccidentStatService())
      as _i3.AccidentStatService);
  _i4.AirQualityService get airQualities => (super.noSuchMethod(
          Invocation.getter(#airQualities), _FakeAirQualityService())
      as _i4.AirQualityService);
  _i5.BikePointService get bikePoints => (super
          .noSuchMethod(Invocation.getter(#bikePoints), _FakeBikePointService())
      as _i5.BikePointService);
  _i6.JourneyService get journeys =>
      (super.noSuchMethod(Invocation.getter(#journeys), _FakeJourneyService())
          as _i6.JourneyService);
  _i7.LineService get lines =>
      (super.noSuchMethod(Invocation.getter(#lines), _FakeLineService())
          as _i7.LineService);
  _i8.ModeService get modes =>
      (super.noSuchMethod(Invocation.getter(#modes), _FakeModeService())
          as _i8.ModeService);
  _i9.OccupancyService get occupancies => (super.noSuchMethod(
          Invocation.getter(#occupancies), _FakeOccupancyService())
      as _i9.OccupancyService);
  _i10.PlaceService get places =>
      (super.noSuchMethod(Invocation.getter(#places), _FakePlaceService())
          as _i10.PlaceService);
  _i11.RoadService get roads =>
      (super.noSuchMethod(Invocation.getter(#roads), _FakeRoadService())
          as _i11.RoadService);
  _i12.SearchService get searches =>
      (super.noSuchMethod(Invocation.getter(#searches), _FakeSearchService())
          as _i12.SearchService);
  _i13.StopPointService get stopPoints => (super
          .noSuchMethod(Invocation.getter(#stopPoints), _FakeStopPointService())
      as _i13.StopPointService);
  _i14.VehicleService get vehicles =>
      (super.noSuchMethod(Invocation.getter(#vehicles), _FakeVehicleService())
          as _i14.VehicleService);
}
