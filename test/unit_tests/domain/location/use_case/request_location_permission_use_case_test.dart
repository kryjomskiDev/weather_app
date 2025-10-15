import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:weather_app/domain/location/model/location_permission_status.dart';
import 'package:weather_app/domain/location/service/location_service.dart';
import 'package:weather_app/domain/location/use_case/request_location_permission_use_case.dart';

import 'request_location_permission_use_case_test.mocks.dart';

@GenerateMocks([LocationService])
void main() {
  late LocationService locationService;
  late RequestLocationPermissionUseCase requestLocationPermissionUseCase;

  setUp(() {
    locationService = MockLocationService();
    requestLocationPermissionUseCase = RequestLocationPermissionUseCase(locationService);
  });

  group('RequestLocationPermissionUseCase', () {
    test('invokes requestLocationPermission method in LocationService once', () async {
      when(locationService.requestLocationPermission()).thenAnswer(
        (_) async => LocationPermissionStatus.always,
      );
      await requestLocationPermissionUseCase();

      verify(locationService.requestLocationPermission()).called(1);
    });
  });
}
