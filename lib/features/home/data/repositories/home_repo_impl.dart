import 'package:either_dart/either.dart';
import 'package:local_db/features/home/domain/repositories/home_repo.dart';
import 'package:local_db/utils/api_handler.dart';
import 'package:local_db/utils/error/failure.dart';

class HomeRepositoryImpl implements HomeRepository {
  final ApiHandler _apiHandler;

  HomeRepositoryImpl(this._apiHandler);

  @override
  Future<Either<Failure, dynamic>> fetchResults() async {
    try {
      final response = await _apiHandler.get('/todos');
      if (response.statusCode == 200) {
        return Right(response.data);
      } else {
        return Left(ServerFailure(message: "Error: ${response.statusCode}"));
      }
    } catch (e) {
      return Left(ServerFailure(message: "Error: $e"));
    }
  }
}
