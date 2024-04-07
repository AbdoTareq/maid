import 'package:tasks/core/feature/data/models/token_wrapper.dart';
import 'package:tasks/core/feature/domain/repositories/repositories.dart';

import '../../../../export.dart';

class AuthUseCase {
  final Repository repository;

  AuthUseCase({required this.repository});

  Future<Either<Failure, TokenWrapper>> login(Map user) async {
    return (repository.post('api/login', user, cashName: kToken)).then(
        (value) => value
            .map((r) => r == null ? TokenWrapper() : TokenWrapper.fromJson(r)));
  }

  Future<Either<Failure, Map>> logout() async {
    return (repository.post('api/logout', {}))
        .then((value) => value.map((r) => r!));
  }
}
