import 'package:dartz/dartz.dart';
import 'package:to_do_app/core/errors/failure.dart';

typedef Json = Map<String, dynamic>;

// result is always going to be in the right, left with error/exception
typedef ResultFuture<T> = Future<Either<Failure, T>>;
