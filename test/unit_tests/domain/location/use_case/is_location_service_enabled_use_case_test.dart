import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:weather_app/domain/location/service/location_service.dart';
import 'package:weather_app/domain/location/use_case/is_location_service_enabled_use_case.dart';

import 'check_location_permission_status_use_case_test.mocks.dart';

@GenerateMocks([LocationService])
void main() {
  late LocationService locationService;
  late IsLocationServiceEnabledUseCase isLocationServiceEnabledUseCase;

  setUp(() {
    locationService = MockLocationService();
    isLocationServiceEnabledUseCase = IsLocationServiceEnabledUseCase(locationService);
  });

  group('isLocationServiceEnabledUseCase', () {
    test('invokes isLocationServiceEnabledUseCase method in LocationService once', () async {
      when(locationService.isLocationServiceEnabled()).thenAnswer((_) async => true);
      await isLocationServiceEnabledUseCase();

      verify(locationService.isLocationServiceEnabled()).called(1);
    });
  });
}
