import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:weather_app/domain/location/model/current_location.dart';
import 'package:weather_app/domain/location/service/location_service.dart';
import 'package:weather_app/domain/location/use_case/get_current_location_use_case.dart';
import 'package:weather_app/utils/error_handling/either.dart';

import 'get_current_location_use_case_test.mocks.dart';

@GenerateMocks(<Type>[LocationService])
void main() {
  late LocationService locationService;
  late GetCurrentLocationUseCase getCurrentLocationUseCase;

  setUp(() {
    locationService = MockLocationService();
    getCurrentLocationUseCase = GetCurrentLocationUseCase(locationService);
  });

  group('getCurrentLocationUseCase', () {
    test('invokes getCurrentLocation method in LocationService once', () async {
      when(
        locationService.getCurrentLocation(),
      ).thenAnswer((_) async => Either.success(const CurrentLocation(latitude: 1, longitude: 1)));
      await getCurrentLocationUseCase();

      verify(locationService.getCurrentLocation()).called(1);
    });
  });
}
