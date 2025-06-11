abstract class Failure {
  final String message;
  final int? statusCode;

  const Failure(this.message, [this.statusCode]);
}

class ServerFailure extends Failure {
  // New constructor with named parameters
  const ServerFailure({required String message, int? statusCode})
    : super(message, statusCode);

  // Legacy constructor for backward compatibility
  const ServerFailure.legacy(String message) : super(message);
}
