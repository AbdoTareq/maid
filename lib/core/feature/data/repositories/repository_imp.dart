import 'package:tasks/core/feature/data/datasources/local_data_source.dart';
import 'package:tasks/core/feature/data/datasources/remote_data_source.dart';
import 'package:tasks/export.dart';

import '../../domain/repositories/repositories.dart';

class RepoImp implements Repository {
  final RemoteDataSource remoteDataSource;
  final LocalDataSource localDataSource;

  RepoImp({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  @override
  Future<Either<Failure, Map<String, dynamic>?>> get(String endPoint,
      {Map? data, String? cashName}) async {
    final res = await remoteDataSource.get(endPoint, data);
    return res.fold(
      (failure) async {
        if (failure is OfflineFailure && cashName != null) {
          if (localDataSource.containsKey(cashName)) {
            final cachedData = localDataSource.read(cashName);
            return Right(cachedData);
          }
          return left(const EmptyCacheFailure(message: no_data));
        }
        return left(failure);
      },
      (serverResponse) {
        if (cashName != null && serverResponse.data != null) {
          localDataSource.write(cashName, serverResponse.data!);
        }
        return right(serverResponse.data);
      },
    );
  }

  @override
  Future<Either<Failure, Map<String, dynamic>?>> post(
      String endPoint, Map? data,
      {String? cashName}) async {
    final res = await remoteDataSource.post(endPoint, data);
    return res.fold(
      (failure) async {
        return left(failure);
      },
      (serverResponse) {
        if (cashName != null) {
          localDataSource.write(cashName, serverResponse.data ?? {});
        }
        return right(serverResponse.data);
      },
    );
  }

  @override
  Future<Either<Failure, Map<String, dynamic>?>> update(
      String endPoint, Map? data) async {
    final res = await remoteDataSource.patch(endPoint, data);
    return res.fold(
      (failure) => left(failure),
      (serverResponse) {
        return right(serverResponse.data);
      },
    );
  }

  @override
  Future<Either<Failure, Map<String, dynamic>?>> delete(
      String endPoint, Map? data) async {
    final res = await remoteDataSource.delete(endPoint, data);
    return res.fold(
      (failure) => left(failure),
      (serverResponse) {
        return right({'data': serverResponse.data});
      },
    );
  }
}
