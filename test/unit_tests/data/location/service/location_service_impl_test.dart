import 'package:flutter_test/flutter_test.dart';
import 'package:geolocator/geolocator.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:weather_app/data/location/data_source/location_data_source.dart';
import 'package:weather_app/data/location/service/location_service_impl.dart';
import 'package:weather_app/domain/location/model/current_location.dart';
import 'package:weather_app/domain/location/model/location_permission_status.dart';
import 'package:weather_app/domain/location/service/location_service.dart';

import 'location_service_impl_test.mocks.dart';

@GenerateMocks([LocationDataSource])
void main() {
  late LocationDataSource locationDataSource;
  late LocationService locationService;

  setUp(() {
    locationDataSource = MockLocationDataSource();
    locationService = LocationServiceImpl(locationDataSource);
  });

  group('LocationService', () {
    group('checkLocationPermission method', () {
      test('returns denied status successfully', () async {
        when(locationDataSource.checkLocationPermission())
            .thenAnswer((_) async => Future.value(LocationPermission.denied));

        final result = await locationService.checkLocationPermission();

        verify(locationDataSource.checkLocationPermission()).called(1);
        expect(result, equals(LocationPermissionStatus.denied));
      });

      test('returns deniedForever status successfully', () async {
        when(locationDataSource.checkLocationPermission())
            .thenAnswer((_) async => Future.value(LocationPermission.deniedForever));

        final result = await locationService.checkLocationPermission();

        verify(locationDataSource.checkLocationPermission()).called(1);
        expect(result, equals(LocationPermissionStatus.deniedForever));
      });

      test('returns whileInUse status successfully', () async {
        when(locationDataSource.checkLocationPermission())
            .thenAnswer((_) async => Future.value(LocationPermission.whileInUse));

        final result = await locationService.checkLocationPermission();

        verify(locationDataSource.checkLocationPermission()).called(1);
        expect(result, equals(LocationPermissionStatus.whileInUse));
      });

      test('returns always status successfully', () async {
        when(locationDataSource.checkLocationPermission())
            .thenAnswer((_) async => Future.value(LocationPermission.always));

        final result = await locationService.checkLocationPermission();

        verify(locationDataSource.checkLocationPermission()).called(1);
        expect(result, equals(LocationPermissionStatus.always));
      });

      test('returns restricted status successfully', () async {
        when(locationDataSource.checkLocationPermission())
            .thenAnswer((_) async => Future.value(LocationPermission.unableToDetermine));

        final result = await locationService.checkLocationPermission();

        verify(locationDataSource.checkLocationPermission()).called(1);
        expect(result, equals(LocationPermissionStatus.unableToDetermine));
      });

      test('throws an exception', () async {
        when(locationDataSource.checkLocationPermission()).thenThrow(Exception());

        expect(locationService.checkLocationPermission(), throwsException);

        verify(locationDataSource.checkLocationPermission()).called(1);
      });
    });

    group('getCurrentLocation method', () {
      test('returns CurrentLocation successfully', () async {
        const latitude = 10.0;
        const longitude = 20.0;

        final dto = Position(
          latitude: latitude,
          longitude: longitude,
          timestamp: DateTime.now(),
          accuracy: 1.0,
          altitude: 1.0,
          heading: 1.0,
          speed: 1.0,
          speedAccuracy: 1.0,
          altitudeAccuracy: 1.0,
          headingAccuracy: 1.0,
        );

        const expectedAnswer = CurrentLocation(
          latitude: latitude,
          longitude: longitude,
        );

        when(locationDataSource.getCurrentLocation()).thenAnswer((_) async => dto);

        final result = await locationService.getCurrentLocation();

        verify(locationDataSource.getCurrentLocation()).called(1);
        expect(result, equals(expectedAnswer));
      });

      test('throws an exception', () async {
        when(locationDataSource.getCurrentLocation()).thenThrow(Exception());

        expect(locationService.getCurrentLocation(), throwsException);

        verify(locationDataSource.getCurrentLocation()).called(1);
      });
    });

    group('requestLocationPermission method', () {
      test('requests location permission and returns status successfully', () async {
        when(locationDataSource.requestLocationPermission())
            .thenAnswer((_) async => Future.value(LocationPermission.whileInUse));

        final result = await locationService.requestLocationPermission();

        verify(locationDataSource.requestLocationPermission()).called(1);
        expect(result, equals(LocationPermissionStatus.whileInUse));
      });

      test('throws an exception', () async {
        when(locationDataSource.requestLocationPermission()).thenThrow(Exception());

        expect(locationService.requestLocationPermission(), throwsException);

        verify(locationDataSource.requestLocationPermission()).called(1);
      });
    });

    group('isLocationServiceEnabled method', () {
      test('returns true if location service is enabled', () async {
        when(locationDataSource.isLocationServiceEnabled()).thenAnswer((_) async => true);

        final result = await locationService.isLocationServiceEnabled();

        verify(locationDataSource.isLocationServiceEnabled()).called(1);
        expect(result, isTrue);
      });

      test('returns false if location service is disabled', () async {
        when(locationDataSource.isLocationServiceEnabled()).thenAnswer((_) async => false);

        final result = await locationService.isLocationServiceEnabled();

        verify(locationDataSource.isLocationServiceEnabled()).called(1);
        expect(result, isFalse);
      });
    });
  });
}
