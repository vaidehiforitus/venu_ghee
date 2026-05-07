import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final String message;
  final int? code; // Added to propagate error codes
  const Failure(this.message, {this.code});

  @override
  String toString() => message;

  @override
  List<Object?> get props => [message, code];
}

class ServerFailure extends Failure {
  const ServerFailure(String message, {int? code}) : super(message, code: code);
}

class NetworkFailure extends Failure {
  const NetworkFailure(String message) : super(message);
}

class CacheFailure extends Failure {
  const CacheFailure(String message) : super(message);
}

class ValidationFailure extends Failure {
  const ValidationFailure(String message) : super(message);
}
