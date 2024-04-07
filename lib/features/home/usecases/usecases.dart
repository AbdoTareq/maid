import 'package:tasks/core/feature/data/models/users_wrapper.dart';
import 'package:tasks/core/feature/domain/repositories/repositories.dart';

import '../../../export.dart';

class TaskUseCase {
  final Repository repository;

  TaskUseCase({required this.repository});

  Future<Either<Failure, UsersWrapper>> get(int pageKey) async {
    return (repository.get('api/users?page=$pageKey', cashName: tasks))
        .then((value) => value.map((r) => UsersWrapper.fromJson(r ?? {})));
  }

  Future<Either<Failure, Task>> create(Map<String, dynamic> task) async {
    return (repository.post('api/users', task))
        .then((value) => value.map((r) => Task.fromJson(r ?? {})));
  }

  Future<Either<Failure, Task>> update(
      String id, Map<String, dynamic> task) async {
    return (repository.update('api/users/$id', task))
        .then((value) => value.map((r) => Task.fromJson(r ?? {})));
  }

  Future<Either<Failure, Map<String, dynamic>?>> delete(String id) async {
    return (repository.delete('api/users/$id', null));
  }
}
