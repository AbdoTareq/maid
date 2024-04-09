import '../../../../export.dart';

abstract class Repository {
  Future<Either<Failure, Map<String, dynamic>?>> get(String endPoint,
      {Map? data, String? cashName});
  Future<Either<Failure, Map<String, dynamic>?>> post(
      String endPoint, Map? data,
      {String? cashName});
  Future<Either<Failure, Map<String, dynamic>?>> update(
      String endPoint, Map? data);
  Future<Either<Failure, Map<String, dynamic>?>> delete(
      String endPoint, Map? data);
}
