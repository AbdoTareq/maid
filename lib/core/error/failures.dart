abstract class Failure {
  final String message;

  const Failure({required this.message});
}

class OfflineFailure extends Failure {
  const OfflineFailure({required super.message});
}

class ServerFailure extends Failure {
  const ServerFailure({required super.message});
}

class EmptyCacheFailure extends Failure {
  const EmptyCacheFailure({required super.message});
}

/// exception in fromMap or fromJson
class SerializeFailure extends Failure {
  const SerializeFailure({required super.message});
}
