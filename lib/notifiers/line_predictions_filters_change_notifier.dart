import 'package:tfl_api_client/tfl_api_client.dart';

import '../specifications/prediction_destination_name_specification.dart';
import '../specifications/prediction_station_name_specification.dart';
import '../specifications/specification.dart';
import 'filters_change_notifier.dart';

class LinePredictionsFiltersChangeNotifier
    extends FiltersChangeNotifier<Prediction> {
  LinePredictionsFiltersChangeNotifier()
      : super(
          <String, Specification<Prediction>>{
            'Station name': null,
            'Destination name': null,
          },
        );

  String get stationName {
    return specifications['Station name']?.toString();
  }

  set stationName(String value) {
    super.update(
      'Station name',
      PredictionStationNameSpecification(value),
    );
  }

  String get destinationName {
    return specifications['Destination name']?.toString();
  }

  set destinationName(String value) {
    super.update(
      'Destination name',
      PredictionDestinationNameSpecification(value),
    );
  }
}
