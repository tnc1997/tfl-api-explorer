import 'dart:async' as _i25;
import 'dart:ui' as _i24;

import 'package:mockito/mockito.dart' as _i1;
import 'package:tfl_api_client/src/models/arrival_departure.dart' as _i39;
import 'package:tfl_api_client/src/models/bike_point_occupancy.dart' as _i32;
import 'package:tfl_api_client/src/models/car_park_occupancy.dart' as _i6;
import 'package:tfl_api_client/src/models/charge_connector_occupancy.dart'
    as _i31;
import 'package:tfl_api_client/src/models/disrupted_point.dart' as _i41;
import 'package:tfl_api_client/src/models/disrupted_street_segment.dart'
    as _i36;
import 'package:tfl_api_client/src/models/disruption.dart' as _i29;
import 'package:tfl_api_client/src/models/line.dart' as _i28;
import 'package:tfl_api_client/src/models/line_service_type.dart' as _i38;
import 'package:tfl_api_client/src/models/mode.dart' as _i26;
import 'package:tfl_api_client/src/models/place.dart' as _i2;
import 'package:tfl_api_client/src/models/place_category.dart' as _i33;
import 'package:tfl_api_client/src/models/places_response.dart' as _i7;
import 'package:tfl_api_client/src/models/prediction.dart' as _i30;
import 'package:tfl_api_client/src/models/road_corridor.dart' as _i34;
import 'package:tfl_api_client/src/models/road_disruption.dart' as _i35;
import 'package:tfl_api_client/src/models/route_search_response.dart' as _i4;
import 'package:tfl_api_client/src/models/route_sequence.dart' as _i3;
import 'package:tfl_api_client/src/models/search_response.dart' as _i10;
import 'package:tfl_api_client/src/models/status_severity.dart' as _i27;
import 'package:tfl_api_client/src/models/stop_point.dart' as _i8;
import 'package:tfl_api_client/src/models/stop_point_category.dart' as _i37;
import 'package:tfl_api_client/src/models/stop_point_route_section.dart'
    as _i40;
import 'package:tfl_api_client/src/models/stop_points_response.dart' as _i9;
import 'package:tfl_api_client/src/models/timetable_response.dart' as _i5;
import 'package:tfl_api_client/src/services/accident_stat_service.dart' as _i11;
import 'package:tfl_api_client/src/services/air_quality_service.dart' as _i12;
import 'package:tfl_api_client/src/services/bike_point_service.dart' as _i13;
import 'package:tfl_api_client/src/services/journey_service.dart' as _i14;
import 'package:tfl_api_client/src/services/line_service.dart' as _i15;
import 'package:tfl_api_client/src/services/mode_service.dart' as _i16;
import 'package:tfl_api_client/src/services/occupancy_service.dart' as _i17;
import 'package:tfl_api_client/src/services/place_service.dart' as _i18;
import 'package:tfl_api_client/src/services/road_service.dart' as _i19;
import 'package:tfl_api_client/src/services/search_service.dart' as _i20;
import 'package:tfl_api_client/src/services/stop_point_service.dart' as _i21;
import 'package:tfl_api_client/src/services/vehicle_service.dart' as _i22;
import 'package:tfl_api_client/src/tfl_api_client_base.dart' as _i42;
import 'package:tfl_api_explorer/src/notifiers/authentication_change_notifier.dart'
    as _i23;

// ignore_for_file: comment_references

// ignore_for_file: unnecessary_parenthesis

class _FakePlace extends _i1.Fake implements _i2.Place {}

class _FakeRouteSequence extends _i1.Fake implements _i3.RouteSequence {}

class _FakeRouteSearchResponse extends _i1.Fake
    implements _i4.RouteSearchResponse {}

class _FakeTimetableResponse extends _i1.Fake implements _i5.TimetableResponse {
}

class _FakeCarParkOccupancy extends _i1.Fake implements _i6.CarParkOccupancy {}

class _FakePlacesResponse extends _i1.Fake implements _i7.PlacesResponse {}

class _FakeStopPoint extends _i1.Fake implements _i8.StopPoint {}

class _FakeStopPointsResponse extends _i1.Fake
    implements _i9.StopPointsResponse {}

class _FakeSearchResponse extends _i1.Fake implements _i10.SearchResponse {}

class _FakeAccidentStatService extends _i1.Fake
    implements _i11.AccidentStatService {}

class _FakeAirQualityService extends _i1.Fake
    implements _i12.AirQualityService {}

class _FakeBikePointService extends _i1.Fake implements _i13.BikePointService {}

class _FakeJourneyService extends _i1.Fake implements _i14.JourneyService {}

class _FakeLineService extends _i1.Fake implements _i15.LineService {}

class _FakeModeService extends _i1.Fake implements _i16.ModeService {}

class _FakeOccupancyService extends _i1.Fake implements _i17.OccupancyService {}

class _FakePlaceService extends _i1.Fake implements _i18.PlaceService {}

class _FakeRoadService extends _i1.Fake implements _i19.RoadService {}

class _FakeSearchService extends _i1.Fake implements _i20.SearchService {}

class _FakeStopPointService extends _i1.Fake implements _i21.StopPointService {}

class _FakeVehicleService extends _i1.Fake implements _i22.VehicleService {}

/// A class which mocks [AuthenticationChangeNotifier].
///
/// See the documentation for Mockito's code generation for more information.
class MockAuthenticationChangeNotifier extends _i1.Mock
    implements _i23.AuthenticationChangeNotifier {
  MockAuthenticationChangeNotifier() {
    _i1.throwOnMissingStub(this);
  }

  bool get hasListeners =>
      (super.noSuchMethod(Invocation.getter(#hasListeners), false) as bool);
  @override
  void login(String? appKey) =>
      super.noSuchMethod(Invocation.method(#login, [appKey]));
  @override
  void addListener(_i24.VoidCallback? listener) =>
      super.noSuchMethod(Invocation.method(#addListener, [listener]));
  @override
  void removeListener(_i24.VoidCallback? listener) =>
      super.noSuchMethod(Invocation.method(#removeListener, [listener]));
}

/// A class which mocks [BikePointService].
///
/// See the documentation for Mockito's code generation for more information.
class MockBikePointService extends _i1.Mock implements _i13.BikePointService {
  MockBikePointService() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i25.Future<List<_i2.Place>> getAll() => (super.noSuchMethod(
          Invocation.method(#getAll, []), Future.value(<_i2.Place>[]))
      as _i25.Future<List<_i2.Place>>);
  @override
  _i25.Future<_i2.Place> get(String? id) => (super.noSuchMethod(
          Invocation.method(#get, [id]), Future.value(_FakePlace()))
      as _i25.Future<_i2.Place>);
  @override
  _i25.Future<List<_i2.Place>> search(String? query) => (super.noSuchMethod(
          Invocation.method(#search, [query]), Future.value(<_i2.Place>[]))
      as _i25.Future<List<_i2.Place>>);
}

/// A class which mocks [LineService].
///
/// See the documentation for Mockito's code generation for more information.
class MockLineService extends _i1.Mock implements _i15.LineService {
  MockLineService() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i25.Future<List<_i26.Mode>> metaModes() => (super.noSuchMethod(
          Invocation.method(#metaModes, []), Future.value(<_i26.Mode>[]))
      as _i25.Future<List<_i26.Mode>>);
  @override
  _i25.Future<List<_i27.StatusSeverity>> metaSeverity() => (super.noSuchMethod(
          Invocation.method(#metaSeverity, []),
          Future.value(<_i27.StatusSeverity>[]))
      as _i25.Future<List<_i27.StatusSeverity>>);
  @override
  _i25.Future<List<String>> metaDisruptionCategories() => (super.noSuchMethod(
      Invocation.method(#metaDisruptionCategories, []),
      Future.value(<String>[])) as _i25.Future<List<String>>);
  @override
  _i25.Future<List<String>> metaServiceTypes() => (super.noSuchMethod(
          Invocation.method(#metaServiceTypes, []), Future.value(<String>[]))
      as _i25.Future<List<String>>);
  @override
  _i25.Future<List<_i28.Line>> getByPathIds(List<String>? ids) =>
      (super.noSuchMethod(Invocation.method(#getByPathIds, [ids]),
          Future.value(<_i28.Line>[])) as _i25.Future<List<_i28.Line>>);
  @override
  _i25.Future<List<_i28.Line>> getByModeByPathModes(List<String>? modes) =>
      (super.noSuchMethod(Invocation.method(#getByModeByPathModes, [modes]),
          Future.value(<_i28.Line>[])) as _i25.Future<List<_i28.Line>>);
  @override
  _i25.Future<List<_i28.Line>> routeByQueryServiceTypes(
          [List<String>? serviceTypes]) =>
      (super.noSuchMethod(
          Invocation.method(#routeByQueryServiceTypes, [serviceTypes]),
          Future.value(<_i28.Line>[])) as _i25.Future<List<_i28.Line>>);
  @override
  _i25.Future<List<_i28.Line>> lineRoutesByIdsByPathIdsQueryServiceTypes(
          List<String>? ids,
          [List<String>? serviceTypes]) =>
      (super.noSuchMethod(
          Invocation.method(
              #lineRoutesByIdsByPathIdsQueryServiceTypes, [ids, serviceTypes]),
          Future.value(<_i28.Line>[])) as _i25.Future<List<_i28.Line>>);
  @override
  _i25.Future<List<_i28.Line>> routeByModeByPathModesQueryServiceTypes(
          List<String>? modes,
          [List<String>? serviceTypes]) =>
      (super.noSuchMethod(
          Invocation.method(
              #routeByModeByPathModesQueryServiceTypes, [modes, serviceTypes]),
          Future.value(<_i28.Line>[])) as _i25.Future<List<_i28.Line>>);
  @override
  _i25.Future<_i3.RouteSequence>
      routeSequenceByPathIdPathDirectionQueryServiceTypesQueryExcludeCrowding(
              String? id, String? direction,
              [List<String>? serviceTypes, bool? excludeCrowding]) =>
          (super.noSuchMethod(
              Invocation.method(
                  #routeSequenceByPathIdPathDirectionQueryServiceTypesQueryExcludeCrowding,
                  [
                    id,
                    direction,
                    serviceTypes,
                    excludeCrowding
                  ]),
              Future.value(
                  _FakeRouteSequence())) as _i25.Future<_i3.RouteSequence>);
  @override
  _i25.Future<List<_i28.Line>>
      statusByPathIdsPathStartDatePathEndDateQueryDetail(
              List<String>? ids, DateTime? startDate, DateTime? endDate,
              [bool? detail]) =>
          (super.noSuchMethod(
              Invocation.method(
                  #statusByPathIdsPathStartDatePathEndDateQueryDetail,
                  [ids, startDate, endDate, detail]),
              Future.value(<_i28.Line>[])) as _i25.Future<List<_i28.Line>>);
  @override
  _i25.Future<List<_i28.Line>> statusByIdsByPathIdsQueryDetail(
          List<String>? ids,
          [bool? detail]) =>
      (super.noSuchMethod(
          Invocation.method(#statusByIdsByPathIdsQueryDetail, [ids, detail]),
          Future.value(<_i28.Line>[])) as _i25.Future<List<_i28.Line>>);
  @override
  _i25.Future<_i4.RouteSearchResponse>
      searchByPathQueryQueryModesQueryServiceTypes(String? query,
              [List<String>? modes, List<String>? serviceTypes]) =>
          (super.noSuchMethod(
                  Invocation.method(
                      #searchByPathQueryQueryModesQueryServiceTypes,
                      [query, modes, serviceTypes]),
                  Future.value(_FakeRouteSearchResponse()))
              as _i25.Future<_i4.RouteSearchResponse>);
  @override
  _i25.Future<List<_i28.Line>> statusBySeverityByPathSeverity(int? severity) =>
      (super.noSuchMethod(
          Invocation.method(#statusBySeverityByPathSeverity, [severity]),
          Future.value(<_i28.Line>[])) as _i25.Future<List<_i28.Line>>);
  @override
  _i25.Future<List<_i28.Line>>
      statusByModeByPathModesQueryDetailQuerySeverityLevel(List<String>? modes,
              [bool? detail, String? severityLevel]) =>
          (super.noSuchMethod(
              Invocation.method(
                  #statusByModeByPathModesQueryDetailQuerySeverityLevel,
                  [modes, detail, severityLevel]),
              Future.value(<_i28.Line>[])) as _i25.Future<List<_i28.Line>>);
  @override
  _i25.Future<List<_i8.StopPoint>>
      stopPointsByPathIdQueryTflOperatedNationalRailStationsOnly(String? id,
              [bool? tflOperatedNationalRailStationsOnly]) =>
          (super.noSuchMethod(
              Invocation.method(
                  #stopPointsByPathIdQueryTflOperatedNationalRailStationsOnly,
                  [id, tflOperatedNationalRailStationsOnly]),
              Future.value(
                  <_i8.StopPoint>[])) as _i25.Future<List<_i8.StopPoint>>);
  @override
  _i25.Future<_i5.TimetableResponse> timetableByPathFromStopPointIdPathId(
          String? fromStopPointId, String? id) =>
      (super.noSuchMethod(
              Invocation.method(
                  #timetableByPathFromStopPointIdPathId, [fromStopPointId, id]),
              Future.value(_FakeTimetableResponse()))
          as _i25.Future<_i5.TimetableResponse>);
  @override
  _i25.Future<_i5.TimetableResponse>
      timetableToByPathFromStopPointIdPathIdPathToStopPointId(
              String? fromStopPointId, String? id, String? toStopPointId) =>
          (super.noSuchMethod(
                  Invocation.method(
                      #timetableToByPathFromStopPointIdPathIdPathToStopPointId,
                      [fromStopPointId, id, toStopPointId]),
                  Future.value(_FakeTimetableResponse()))
              as _i25.Future<_i5.TimetableResponse>);
  @override
  _i25.Future<List<_i29.Disruption>> disruptionByPathIds(List<String>? ids) =>
      (super.noSuchMethod(Invocation.method(#disruptionByPathIds, [ids]),
              Future.value(<_i29.Disruption>[]))
          as _i25.Future<List<_i29.Disruption>>);
  @override
  _i25.Future<List<_i29.Disruption>> disruptionByModeByPathModes(
          List<String>? modes) =>
      (super.noSuchMethod(
              Invocation.method(#disruptionByModeByPathModes, [modes]),
              Future.value(<_i29.Disruption>[]))
          as _i25.Future<List<_i29.Disruption>>);
  @override
  _i25.Future<List<_i30.Prediction>>
      arrivalsWithStopPointByPathIdsPathStopPointIdQueryDirectionQueryDestina(
              List<String>? ids, String? stopPointId,
              [String? direction, String? destinationStationId]) =>
          (super.noSuchMethod(
              Invocation.method(
                  #arrivalsWithStopPointByPathIdsPathStopPointIdQueryDirectionQueryDestina,
                  [
                    ids,
                    stopPointId,
                    direction,
                    destinationStationId
                  ]),
              Future.value(
                  <_i30.Prediction>[])) as _i25.Future<List<_i30.Prediction>>);
  @override
  _i25.Future<List<_i30.Prediction>> arrivalsByPathIds(List<String>? ids) =>
      (super.noSuchMethod(Invocation.method(#arrivalsByPathIds, [ids]),
              Future.value(<_i30.Prediction>[]))
          as _i25.Future<List<_i30.Prediction>>);
}

/// A class which mocks [OccupancyService].
///
/// See the documentation for Mockito's code generation for more information.
class MockOccupancyService extends _i1.Mock implements _i17.OccupancyService {
  MockOccupancyService() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i25.Future<List<_i6.CarParkOccupancy>> get() => (super.noSuchMethod(
          Invocation.method(#get, []), Future.value(<_i6.CarParkOccupancy>[]))
      as _i25.Future<List<_i6.CarParkOccupancy>>);
  @override
  _i25.Future<List<_i31.ChargeConnectorOccupancy>>
      getAllChargeConnectorStatus() => (super.noSuchMethod(
              Invocation.method(#getAllChargeConnectorStatus, []),
              Future.value(<_i31.ChargeConnectorOccupancy>[]))
          as _i25.Future<List<_i31.ChargeConnectorOccupancy>>);
  @override
  _i25.Future<_i6.CarParkOccupancy> getByPathId(String? id) =>
      (super.noSuchMethod(Invocation.method(#getByPathId, [id]),
              Future.value(_FakeCarParkOccupancy()))
          as _i25.Future<_i6.CarParkOccupancy>);
  @override
  _i25.Future<List<_i31.ChargeConnectorOccupancy>>
      getChargeConnectorStatusByPathIds(List<String>? ids) =>
          (super.noSuchMethod(
                  Invocation.method(#getChargeConnectorStatusByPathIds, [ids]),
                  Future.value(<_i31.ChargeConnectorOccupancy>[]))
              as _i25.Future<List<_i31.ChargeConnectorOccupancy>>);
  @override
  _i25.Future<List<_i32.BikePointOccupancy>> getBikePointsOccupanciesByPathIds(
          List<String>? ids) =>
      (super.noSuchMethod(
              Invocation.method(#getBikePointsOccupanciesByPathIds, [ids]),
              Future.value(<_i32.BikePointOccupancy>[]))
          as _i25.Future<List<_i32.BikePointOccupancy>>);
}

/// A class which mocks [PlaceService].
///
/// See the documentation for Mockito's code generation for more information.
class MockPlaceService extends _i1.Mock implements _i18.PlaceService {
  MockPlaceService() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i25.Future<List<_i33.PlaceCategory>> metaCategories() => (super.noSuchMethod(
          Invocation.method(#metaCategories, []),
          Future.value(<_i33.PlaceCategory>[]))
      as _i25.Future<List<_i33.PlaceCategory>>);
  @override
  _i25.Future<List<String>> metaPlaceTypes() => (super.noSuchMethod(
          Invocation.method(#metaPlaceTypes, []), Future.value(<String>[]))
      as _i25.Future<List<String>>);
  @override
  _i25.Future<List<_i2.Place>> getByTypeByPathTypesQueryActiveOnly(
          List<String>? types,
          [bool? activeOnly]) =>
      (super.noSuchMethod(
          Invocation.method(
              #getByTypeByPathTypesQueryActiveOnly, [types, activeOnly]),
          Future.value(<_i2.Place>[])) as _i25.Future<List<_i2.Place>>);
  @override
  _i25.Future<_i2.Place> getByPathIdQueryIncludeChildren(String? id,
          [bool? includeChildren]) =>
      (super.noSuchMethod(
          Invocation.method(
              #getByPathIdQueryIncludeChildren, [id, includeChildren]),
          Future.value(_FakePlace())) as _i25.Future<_i2.Place>);
  @override
  _i25.Future<_i7.PlacesResponse>
      getByGeoPointByQueryLatQueryLonQueryRadiusQueryCategoriesQueryIncludeC(
              double? lat, double? lon,
              [double? radius,
              List<String>? categories,
              bool? includeChildren,
              List<String>? type,
              bool? activeOnly,
              int? numberOfPlacesToReturn]) =>
          (super.noSuchMethod(
              Invocation.method(
                  #getByGeoPointByQueryLatQueryLonQueryRadiusQueryCategoriesQueryIncludeC,
                  [
                    lat,
                    lon,
                    radius,
                    categories,
                    includeChildren,
                    type,
                    activeOnly,
                    numberOfPlacesToReturn
                  ]),
              Future.value(
                  _FakePlacesResponse())) as _i25.Future<_i7.PlacesResponse>);
  @override
  _i25.Future<List<_i2.Place>> getAtByPathTypePathLatPathLon(
          String? type, double? lat, double? lon) =>
      (super.noSuchMethod(
          Invocation.method(#getAtByPathTypePathLatPathLon, [type, lat, lon]),
          Future.value(<_i2.Place>[])) as _i25.Future<List<_i2.Place>>);
  @override
  _i25.Future<List<_i2.Place>> searchByQueryNameQueryTypes(String? name,
          [List<String>? types]) =>
      (super.noSuchMethod(
          Invocation.method(#searchByQueryNameQueryTypes, [name, types]),
          Future.value(<_i2.Place>[])) as _i25.Future<List<_i2.Place>>);
}

/// A class which mocks [RoadService].
///
/// See the documentation for Mockito's code generation for more information.
class MockRoadService extends _i1.Mock implements _i19.RoadService {
  MockRoadService() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i25.Future<List<_i34.RoadCorridor>> get() => (super.noSuchMethod(
          Invocation.method(#get, []), Future.value(<_i34.RoadCorridor>[]))
      as _i25.Future<List<_i34.RoadCorridor>>);
  @override
  _i25.Future<List<_i34.RoadCorridor>> getByPathIds(List<String>? ids) =>
      (super.noSuchMethod(Invocation.method(#getByPathIds, [ids]),
              Future.value(<_i34.RoadCorridor>[]))
          as _i25.Future<List<_i34.RoadCorridor>>);
  @override
  _i25.Future<List<_i34.RoadCorridor>>
      statusByPathIdsQueryStartDateQueryEndDate(List<String>? ids,
              [DateTime? startDate, DateTime? endDate]) =>
          (super.noSuchMethod(
                  Invocation.method(#statusByPathIdsQueryStartDateQueryEndDate,
                      [ids, startDate, endDate]),
                  Future.value(<_i34.RoadCorridor>[]))
              as _i25.Future<List<_i34.RoadCorridor>>);
  @override
  _i25.Future<List<_i35.RoadDisruption>>
      disruptionByPathIdsQueryStripContentQuerySeveritiesQueryCategoriesQuery(
              List<String>? ids,
              [bool? stripContent,
              List<String>? severities,
              List<String>? categories,
              bool? closures]) =>
          (super.noSuchMethod(
              Invocation.method(
                  #disruptionByPathIdsQueryStripContentQuerySeveritiesQueryCategoriesQuery,
                  [
                    ids,
                    stripContent,
                    severities,
                    categories,
                    closures
                  ]),
              Future.value(
                  <_i35.RoadDisruption>[])) as _i25
              .Future<List<_i35.RoadDisruption>>);
  @override
  _i25.Future<List<_i36.DisruptedStreetSegment>>
      disruptedStreetsByQueryStartDateQueryEndDate(
              [DateTime? startDate, DateTime? endDate]) =>
          (super.noSuchMethod(
                  Invocation.method(
                      #disruptedStreetsByQueryStartDateQueryEndDate,
                      [startDate, endDate]),
                  Future.value(<_i36.DisruptedStreetSegment>[]))
              as _i25.Future<List<_i36.DisruptedStreetSegment>>);
  @override
  _i25.Future<List<_i35.RoadDisruption>>
      disruptionByIdByPathDisruptionIdsQueryStripContent(
              List<String>? disruptionIds,
              [bool? stripContent]) =>
          (super.noSuchMethod(
                  Invocation.method(
                      #disruptionByIdByPathDisruptionIdsQueryStripContent,
                      [disruptionIds, stripContent]),
                  Future.value(<_i35.RoadDisruption>[]))
              as _i25.Future<List<_i35.RoadDisruption>>);
  @override
  _i25.Future<List<String>> metaCategories() => (super.noSuchMethod(
          Invocation.method(#metaCategories, []), Future.value(<String>[]))
      as _i25.Future<List<String>>);
  @override
  _i25.Future<List<_i27.StatusSeverity>> metaSeverities() =>
      (super.noSuchMethod(Invocation.method(#metaSeverities, []),
              Future.value(<_i27.StatusSeverity>[]))
          as _i25.Future<List<_i27.StatusSeverity>>);
}

/// A class which mocks [StopPointService].
///
/// See the documentation for Mockito's code generation for more information.
class MockStopPointService extends _i1.Mock implements _i21.StopPointService {
  MockStopPointService() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i25.Future<List<_i37.StopPointCategory>> metaCategories() =>
      (super.noSuchMethod(Invocation.method(#metaCategories, []),
              Future.value(<_i37.StopPointCategory>[]))
          as _i25.Future<List<_i37.StopPointCategory>>);
  @override
  _i25.Future<List<String>> metaStopTypes() => (super.noSuchMethod(
          Invocation.method(#metaStopTypes, []), Future.value(<String>[]))
      as _i25.Future<List<String>>);
  @override
  _i25.Future<List<_i26.Mode>> metaModes() => (super.noSuchMethod(
          Invocation.method(#metaModes, []), Future.value(<_i26.Mode>[]))
      as _i25.Future<List<_i26.Mode>>);
  @override
  _i25.Future<List<_i8.StopPoint>> getByPathIdsQueryIncludeCrowdingData(
          List<String>? ids,
          [bool? includeCrowdingData]) =>
      (super.noSuchMethod(
          Invocation.method(#getByPathIdsQueryIncludeCrowdingData,
              [ids, includeCrowdingData]),
          Future.value(<_i8.StopPoint>[])) as _i25.Future<List<_i8.StopPoint>>);
  @override
  _i25.Future<List<_i2.Place>> getByPathIdQueryPlaceTypes(
          String? id, List<String>? placeTypes) =>
      (super.noSuchMethod(
          Invocation.method(#getByPathIdQueryPlaceTypes, [id, placeTypes]),
          Future.value(<_i2.Place>[])) as _i25.Future<List<_i2.Place>>);
  @override
  _i25.Future<_i8.StopPoint> crowdingByPathIdPathLineQueryDirection(
          String? id, String? line, String? direction) =>
      (super.noSuchMethod(
          Invocation.method(
              #crowdingByPathIdPathLineQueryDirection, [id, line, direction]),
          Future.value(_FakeStopPoint())) as _i25.Future<_i8.StopPoint>);
  @override
  _i25.Future<List<_i8.StopPoint>> getByTypeByPathTypes(List<String>? types) =>
      (super.noSuchMethod(Invocation.method(#getByTypeByPathTypes, [types]),
          Future.value(<_i8.StopPoint>[])) as _i25.Future<List<_i8.StopPoint>>);
  @override
  _i25.Future<List<_i8.StopPoint>> getByTypeWithPaginationByPathTypesPathPage(
          List<String>? types, int? page) =>
      (super.noSuchMethod(
          Invocation.method(
              #getByTypeWithPaginationByPathTypesPathPage, [types, page]),
          Future.value(<_i8.StopPoint>[])) as _i25.Future<List<_i8.StopPoint>>);
  @override
  _i25.Future<List<_i38.LineServiceType>>
      getServiceTypesByQueryIdQueryLineIdsQueryModes(String? id,
              [List<String>? lineIds, List<String>? modes]) =>
          (super.noSuchMethod(
                  Invocation.method(
                      #getServiceTypesByQueryIdQueryLineIdsQueryModes,
                      [id, lineIds, modes]),
                  Future.value(<_i38.LineServiceType>[]))
              as _i25.Future<List<_i38.LineServiceType>>);
  @override
  _i25.Future<List<_i30.Prediction>> arrivalsByPathId(String? id) =>
      (super.noSuchMethod(Invocation.method(#arrivalsByPathId, [id]),
              Future.value(<_i30.Prediction>[]))
          as _i25.Future<List<_i30.Prediction>>);
  @override
  _i25.Future<List<_i39.ArrivalDeparture>>
      arrivalDeparturesByPathIdQueryLineIds(
              String? id, List<String>? lineIds) =>
          (super.noSuchMethod(
                  Invocation.method(
                      #arrivalDeparturesByPathIdQueryLineIds, [id, lineIds]),
                  Future.value(<_i39.ArrivalDeparture>[]))
              as _i25.Future<List<_i39.ArrivalDeparture>>);
  @override
  _i25.Future<List<_i8.StopPoint>>
      reachableFromByPathIdPathLineIdQueryServiceTypes(
              String? id, String? lineId,
              [List<String>? serviceTypes]) =>
          (super.noSuchMethod(
                  Invocation.method(
                      #reachableFromByPathIdPathLineIdQueryServiceTypes,
                      [id, lineId, serviceTypes]),
                  Future.value(<_i8.StopPoint>[]))
              as _i25.Future<List<_i8.StopPoint>>);
  @override
  _i25.Future<List<_i40.StopPointRouteSection>> routeByPathIdQueryServiceTypes(
          String? id,
          [List<String>? serviceTypes]) =>
      (super.noSuchMethod(
              Invocation.method(
                  #routeByPathIdQueryServiceTypes, [id, serviceTypes]),
              Future.value(<_i40.StopPointRouteSection>[]))
          as _i25.Future<List<_i40.StopPointRouteSection>>);
  @override
  _i25.Future<List<_i41.DisruptedPoint>>
      disruptionByModeByPathModesQueryIncludeRouteBlockedStops(
              List<String>? modes,
              [bool? includeRouteBlockedStops]) =>
          (super.noSuchMethod(
                  Invocation.method(
                      #disruptionByModeByPathModesQueryIncludeRouteBlockedStops,
                      [modes, includeRouteBlockedStops]),
                  Future.value(<_i41.DisruptedPoint>[]))
              as _i25.Future<List<_i41.DisruptedPoint>>);
  @override
  _i25.Future<List<_i41.DisruptedPoint>>
      disruptionByPathIdsQueryGetFamilyQueryIncludeRouteBlockedStopsQuer(
              List<String>? ids,
              [bool? getFamily,
              bool? includeRouteBlockedStops,
              bool? flattenResponse]) =>
          (super.noSuchMethod(
              Invocation.method(
                  #disruptionByPathIdsQueryGetFamilyQueryIncludeRouteBlockedStopsQuer,
                  [
                    ids,
                    getFamily,
                    includeRouteBlockedStops,
                    flattenResponse
                  ]),
              Future.value(
                  <_i41.DisruptedPoint>[])) as _i25
              .Future<List<_i41.DisruptedPoint>>);
  @override
  _i25.Future<String> directionByPathIdPathToStopPointIdQueryLineId(
          String? id, String? toStopPointId, [String? lineId]) =>
      (super.noSuchMethod(
          Invocation.method(#directionByPathIdPathToStopPointIdQueryLineId,
              [id, toStopPointId, lineId]),
          Future.value('')) as _i25.Future<String>);
  @override
  _i25.Future<_i9.StopPointsResponse>
      getByGeoPointByQueryLatQueryLonQueryStopTypesQueryRadiusQueryUseSt(
              List<String>? stopTypes, double? lat, double? lon,
              [int? radius,
              bool? useStopPointHierarchy,
              List<String>? modes,
              List<String>? categories,
              bool? returnLines]) =>
          (super.noSuchMethod(
              Invocation.method(
                  #getByGeoPointByQueryLatQueryLonQueryStopTypesQueryRadiusQueryUseSt,
                  [
                    stopTypes,
                    lat,
                    lon,
                    radius,
                    useStopPointHierarchy,
                    modes,
                    categories,
                    returnLines
                  ]),
              Future.value(
                  _FakeStopPointsResponse())) as _i25
              .Future<_i9.StopPointsResponse>);
  @override
  _i25.Future<_i9.StopPointsResponse> getByModeByPathModesQueryPage(
          List<String>? modes,
          [int? page]) =>
      (super.noSuchMethod(
              Invocation.method(#getByModeByPathModesQueryPage, [modes, page]),
              Future.value(_FakeStopPointsResponse()))
          as _i25.Future<_i9.StopPointsResponse>);
  @override
  _i25.Future<_i10.SearchResponse>
      searchByPathQueryQueryModesQueryFaresOnlyQueryMaxResultsQueryLines(
              String? query,
              [List<String>? modes,
              bool? faresOnly,
              int? maxResults,
              List<String>? lines,
              bool? includeHubs,
              bool? tflOperatedNationalRailStationsOnly]) =>
          (super.noSuchMethod(
              Invocation.method(
                  #searchByPathQueryQueryModesQueryFaresOnlyQueryMaxResultsQueryLines,
                  [
                    query,
                    modes,
                    faresOnly,
                    maxResults,
                    lines,
                    includeHubs,
                    tflOperatedNationalRailStationsOnly
                  ]),
              Future.value(
                  _FakeSearchResponse())) as _i25.Future<_i10.SearchResponse>);
  @override
  _i25.Future<_i10.SearchResponse>
      searchByQueryQueryQueryModesQueryFaresOnlyQueryMaxResultsQueryLine(
              String? query,
              [List<String>? modes,
              bool? faresOnly,
              int? maxResults,
              List<String>? lines,
              bool? includeHubs,
              bool? tflOperatedNationalRailStationsOnly]) =>
          (super.noSuchMethod(
              Invocation.method(
                  #searchByQueryQueryQueryModesQueryFaresOnlyQueryMaxResultsQueryLine,
                  [
                    query,
                    modes,
                    faresOnly,
                    maxResults,
                    lines,
                    includeHubs,
                    tflOperatedNationalRailStationsOnly
                  ]),
              Future.value(
                  _FakeSearchResponse())) as _i25.Future<_i10.SearchResponse>);
  @override
  _i25.Future<_i8.StopPoint> getBySmsByPathIdQueryOutput(String? id,
          [String? output]) =>
      (super.noSuchMethod(
          Invocation.method(#getBySmsByPathIdQueryOutput, [id, output]),
          Future.value(_FakeStopPoint())) as _i25.Future<_i8.StopPoint>);
  @override
  _i25.Future<List<_i2.Place>> getTaxiRanksByIdsByPathStopPointId(
          String? stopPointId) =>
      (super.noSuchMethod(
          Invocation.method(#getTaxiRanksByIdsByPathStopPointId, [stopPointId]),
          Future.value(<_i2.Place>[])) as _i25.Future<List<_i2.Place>>);
  @override
  _i25.Future<List<_i2.Place>> getCarParksByIdByPathStopPointId(
          String? stopPointId) =>
      (super.noSuchMethod(
          Invocation.method(#getCarParksByIdByPathStopPointId, [stopPointId]),
          Future.value(<_i2.Place>[])) as _i25.Future<List<_i2.Place>>);
}

/// A class which mocks [TflApiClient].
///
/// See the documentation for Mockito's code generation for more information.
class MockTflApiClient extends _i1.Mock implements _i42.TflApiClient {
  MockTflApiClient() {
    _i1.throwOnMissingStub(this);
  }

  _i11.AccidentStatService get accidentStats => (super.noSuchMethod(
          Invocation.getter(#accidentStats), _FakeAccidentStatService())
      as _i11.AccidentStatService);
  _i12.AirQualityService get airQualities => (super.noSuchMethod(
          Invocation.getter(#airQualities), _FakeAirQualityService())
      as _i12.AirQualityService);
  _i13.BikePointService get bikePoints => (super
          .noSuchMethod(Invocation.getter(#bikePoints), _FakeBikePointService())
      as _i13.BikePointService);
  _i14.JourneyService get journeys =>
      (super.noSuchMethod(Invocation.getter(#journeys), _FakeJourneyService())
          as _i14.JourneyService);
  _i15.LineService get lines =>
      (super.noSuchMethod(Invocation.getter(#lines), _FakeLineService())
          as _i15.LineService);
  _i16.ModeService get modes =>
      (super.noSuchMethod(Invocation.getter(#modes), _FakeModeService())
          as _i16.ModeService);
  _i17.OccupancyService get occupancies => (super.noSuchMethod(
          Invocation.getter(#occupancies), _FakeOccupancyService())
      as _i17.OccupancyService);
  _i18.PlaceService get places =>
      (super.noSuchMethod(Invocation.getter(#places), _FakePlaceService())
          as _i18.PlaceService);
  _i19.RoadService get roads =>
      (super.noSuchMethod(Invocation.getter(#roads), _FakeRoadService())
          as _i19.RoadService);
  _i20.SearchService get searches =>
      (super.noSuchMethod(Invocation.getter(#searches), _FakeSearchService())
          as _i20.SearchService);
  _i21.StopPointService get stopPoints => (super
          .noSuchMethod(Invocation.getter(#stopPoints), _FakeStopPointService())
      as _i21.StopPointService);
  _i22.VehicleService get vehicles =>
      (super.noSuchMethod(Invocation.getter(#vehicles), _FakeVehicleService())
          as _i22.VehicleService);
}
