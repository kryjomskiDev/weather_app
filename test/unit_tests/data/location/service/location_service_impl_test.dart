import 'package:flutter_test/flutter_test.dart';
import 'package:geolocator/geolocator.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:weather_app/data/location/data_source/location_data_source.dart';
import 'package:weather_app/data/location/service/location_service_impl.dart';
import 'package:weather_app/domain/location/model/current_location.dart';
import 'package:weather_app/domain/location/model/location_permission_status.dart';
import 'package:weather_app/domain/location/service/location_service.dart';
import 'package:weather_app/utils/error_handling/either.dart';
import 'package:weather_app/utils/error_handling/errors/generic_error.dart';

import 'location_service_impl_test.mocks.dart';

@GenerateMocks(<Type>[LocationDataSource])
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
        when(
          locationDataSource.checkLocationPermission(),
        ).thenAnswer((Invocation _) async => Future<LocationPermission>.value(LocationPermission.denied));

        final Either<GenericError, LocationPermissionStatus> result = await locationService.checkLocationPermission();

        verify(locationDataSource.checkLocationPermission()).called(1);
        expect(result.isSuccess(), isTrue);
        expect(result.getOrElse(LocationPermissionStatus.granted), equals(LocationPermissionStatus.denied));
      });

      test('returns Failure for deniedForever', () async {
        when(
          locationDataSource.checkLocationPermission(),
        ).thenAnswer((Invocation _) async => Future<LocationPermission>.value(LocationPermission.deniedForever));

        final Either<GenericError, LocationPermissionStatus> result = await locationService.checkLocationPermission();

        verify(locationDataSource.checkLocationPermission()).called(1);
        expect(result.isFailure(), isTrue);
      });

      test('maps whileInUse to granted domain status', () async {
        when(
          locationDataSource.checkLocationPermission(),
        ).thenAnswer((Invocation _) async => Future<LocationPermission>.value(LocationPermission.whileInUse));

        final Either<GenericError, LocationPermissionStatus> result = await locationService.checkLocationPermission();

        verify(locationDataSource.checkLocationPermission()).called(1);
        expect(result.isSuccess(), isTrue);
        expect(result.getOrElse(LocationPermissionStatus.denied), equals(LocationPermissionStatus.granted));
      });

      test('maps always to granted domain status', () async {
        when(
          locationDataSource.checkLocationPermission(),
        ).thenAnswer((Invocation _) async => Future<LocationPermission>.value(LocationPermission.always));

        final Either<GenericError, LocationPermissionStatus> result = await locationService.checkLocationPermission();

        verify(locationDataSource.checkLocationPermission()).called(1);
        expect(result.isSuccess(), isTrue);
        expect(result.getOrElse(LocationPermissionStatus.denied), equals(LocationPermissionStatus.granted));
      });

      test('maps unableToDetermine to granted domain status', () async {
        when(
          locationDataSource.checkLocationPermission(),
        ).thenAnswer((Invocation _) async => Future<LocationPermission>.value(LocationPermission.unableToDetermine));

        final Either<GenericError, LocationPermissionStatus> result = await locationService.checkLocationPermission();

        verify(locationDataSource.checkLocationPermission()).called(1);
        expect(result.isSuccess(), isTrue);
        expect(result.getOrElse(LocationPermissionStatus.denied), equals(LocationPermissionStatus.granted));
      });

      test('returns Failure when data source throws', () async {
        when(locationDataSource.checkLocationPermission()).thenThrow(Exception());

        final Either<GenericError, LocationPermissionStatus> result = await locationService.checkLocationPermission();

        expect(result.isFailure(), isTrue);
        verify(locationDataSource.checkLocationPermission()).called(1);
      });
    });

    group('getCurrentLocation method', () {
      test('returns CurrentLocation successfully', () async {
        const double latitude = 10.0;
        const double longitude = 20.0;

        final Position dto = Position(
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

        const CurrentLocation expectedAnswer = CurrentLocation(
          latitude: latitude,
          longitude: longitude,
        );

        when(locationDataSource.getCurrentLocation()).thenAnswer((Invocation _) async => dto);

        final Either<GenericError, CurrentLocation> result = await locationService.getCurrentLocation();

        verify(locationDataSource.getCurrentLocation()).called(1);
        expect(result.isSuccess(), isTrue);
        expect(result.getOrElse(expectedAnswer), equals(expectedAnswer));
      });

      test('returns Failure when data source throws', () async {
        when(locationDataSource.getCurrentLocation()).thenThrow(Exception());

        final Either<GenericError, CurrentLocation> result = await locationService.getCurrentLocation();

        expect(result.isFailure(), isTrue);
        verify(locationDataSource.getCurrentLocation()).called(1);
      });
    });

    group('requestLocationPermission method', () {
      test('requests location permission and returns status successfully', () async {
        when(
          locationDataSource.requestLocationPermission(),
        ).thenAnswer((Invocation _) async => Future<LocationPermission>.value(LocationPermission.whileInUse));

        final Either<GenericError, LocationPermissionStatus> result = await locationService.requestLocationPermission();

        verify(locationDataSource.requestLocationPermission()).called(1);
        expect(result.isSuccess(), isTrue);
        expect(result.getOrElse(LocationPermissionStatus.denied), equals(LocationPermissionStatus.granted));
      });

      test('returns Failure for deniedForever', () async {
        when(
          locationDataSource.requestLocationPermission(),
        ).thenAnswer((Invocation _) async => Future<LocationPermission>.value(LocationPermission.deniedForever));

        final Either<GenericError, LocationPermissionStatus> result = await locationService.requestLocationPermission();

        verify(locationDataSource.requestLocationPermission()).called(1);
        expect(result.isFailure(), isTrue);
      });

      test('returns Failure when data source throws', () async {
        when(locationDataSource.requestLocationPermission()).thenThrow(Exception());

        final Either<GenericError, LocationPermissionStatus> result = await locationService.requestLocationPermission();

        expect(result.isFailure(), isTrue);
        verify(locationDataSource.requestLocationPermission()).called(1);
      });
    });

    group('isLocationServiceEnabled method', () {
      test('returns true if location service is enabled', () async {
        when(locationDataSource.isLocationServiceEnabled()).thenAnswer((Invocation _) async => true);

        final Either<GenericError, bool> result = await locationService.isLocationServiceEnabled();

        verify(locationDataSource.isLocationServiceEnabled()).called(1);
        expect(result.isSuccess(), isTrue);
        expect(result.getOrElse(false), isTrue);
      });

      test('returns Failure when location service is disabled', () async {
        when(locationDataSource.isLocationServiceEnabled()).thenAnswer((Invocation _) async => false);

        final Either<GenericError, bool> result = await locationService.isLocationServiceEnabled();

        verify(locationDataSource.isLocationServiceEnabled()).called(1);
        expect(result.isFailure(), isTrue);
      });

      test('returns Failure when data source throws', () async {
        when(locationDataSource.isLocationServiceEnabled()).thenThrow(Exception());

        final Either<GenericError, bool> result = await locationService.isLocationServiceEnabled();

        expect(result.isFailure(), isTrue);
        verify(locationDataSource.isLocationServiceEnabled()).called(1);
      });
    });
  });
}
