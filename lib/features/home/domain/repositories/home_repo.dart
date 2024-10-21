import 'package:either_dart/either.dart';
import 'package:local_db/utils/error/failure.dart';

abstract class HomeRepository {
  Future<Either<Failure, dynamic>> fetchResults();
}
