import 'package:intl/intl.dart';

class WeatherAppNumberFormats {
  const WeatherAppNumberFormats._();

  static NumberFormat get temperature => NumberFormat('##.#');
}
