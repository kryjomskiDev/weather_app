import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:weather_app/domain/location/model/location_permission_status.dart';
import 'package:weather_app/domain/location/service/location_service.dart';
import 'package:weather_app/domain/location/use_case/check_location_permission_status_use_case.dart';

import 'check_location_permission_status_use_case_test.mocks.dart';

@GenerateMocks([LocationService])
void main() {
  late LocationService locationService;
  late CheckLocationPermissionStatusUseCase checkLocationPermissionStatusUseCase;

  setUp(() {
    locationService = MockLocationService();
    checkLocationPermissionStatusUseCase = CheckLocationPermissionStatusUseCase(locationService);
  });

  group('CheckLocationPermissionStatusUseCase', () {
    test('invokes checkLocationPermission method in LocationService once', () async {
      when(locationService.checkLocationPermission()).thenAnswer(
        (_) async => LocationPermissionStatus.always,
      );
      await checkLocationPermissionStatusUseCase();

      verify(locationService.checkLocationPermission()).called(1);
    });
  });
}
