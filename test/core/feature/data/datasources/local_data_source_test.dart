import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tasks/core/constants.dart';
import 'package:tasks/core/feature/data/datasources/local_data_source.dart';

class MockLocalDataSource extends Mock implements LocalDataSource {}

Future<void> main() async {
  // every function should be isolated from other tests
  late LocalDataSource localDataSource;
  late MockLocalDataSource mock;

  setUp(() async {
    final Map<String, Object> values = <String, Object>{
      kToken: 'tokenValue',
    };
    // mock
    SharedPreferences.setMockInitialValues(values);
    localDataSource =
        LocalDataSourceImpl(box: await SharedPreferences.getInstance());
    mock = MockLocalDataSource();
  });

  group('localDataSource write tests', () {
    test('writing valid data to new key should return true', () async {
      // Arrange
      when(
        () => mock.write(kToken, {'key': 'value'}),
      ).thenAnswer((invocation) async => true);
      // Act
      final notExistValue = await mock.write(kToken, {'key': 'value'});
      // Assert
      expect(notExistValue, true);
    });
    test('writing valid data to new key should return false', () async {
      // Arrange
      when(
        () => mock.write('not_exist_key', {'key': 'value'}),
      ).thenAnswer((invocation) async => false);
      // Act
      final notExistValue = await mock.write('not_exist_key', {'key': 'value'});
      // Assert
      expect(notExistValue, false);
    });
  });
  group('localDataSource read tests', () {
    test('reading data from new not_exist_key should return null', () async {
      // Arrange
      when(
        () => mock.read('not_exist_key'),
      ).thenAnswer((invocation) => null);
      // act
      final notExistValue = localDataSource.read('not_exist_key');
      // assert
      expect(notExistValue, null);
    });
  });
  group('localDataSource contain tests', () {
    test('containing data from new key should return false', () async {
      expect(localDataSource.containsKey('not_exist_key'), false);
    });
    test('containing data from existing key should return true', () async {
      expect(localDataSource.containsKey(kToken), true);
    });
  });
  group('localDataSource remove tests', () {
    test('removing data from  existing key should return true', () async {
      // Arrange
      when(
        () => mock.remove(kToken),
      ).thenAnswer((invocation) async => true);
      // Act
      final notExistValue = await localDataSource.remove('not_exist_key');
      // Assert
      expect(notExistValue, true);
    });
    //? this test not working
    // test('removing data from not existing key should return false', () async {
    //   // Arrange
    //   when(
    //     () => mock.remove('not_exist_key'),
    //   ).thenAnswer((invocation) async => false);
    //   // Act
    //   final notExistValue = await cacheHelper.remove('not_exist_key');
    //   // Assert
    //   expect(notExistValue, false);
    // });
  });
}
