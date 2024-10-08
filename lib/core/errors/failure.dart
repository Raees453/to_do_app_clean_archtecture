import 'package:equatable/equatable.dart';
import 'package:to_do_app/core/errors/exceptions.dart';

abstract class Failure extends Equatable {
  const Failure({required this.message, required this.statusCode});

  final String message;
  final dynamic statusCode;

  String get error => 'Code: $statusCode, Error: $message';

  @override
  List<dynamic> get props => [message, statusCode];
}

class ServerFailure extends Failure {
  const ServerFailure({required super.message, required super.statusCode});

  ServerFailure.fromException(ServerException exception)
      : this(message: exception.message, statusCode: exception.statusCode);
}
