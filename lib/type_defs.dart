import 'package:fpdart/fpdart.dart';
import 'package:reddit/failure.dart';

typedef FutureEither<T> = Future<Either<Failure, T>>;
// Future<Either<Failure, T>> means that you have an asynchronous operation (Future) that will eventually complete with an Either value. The Either can be:

// Left<Failure>: Represents a failure, containing a Failure object.
// Right<T>: Represents a success, containing a value of type T.

typedef FutureVoid = FutureEither<void>;