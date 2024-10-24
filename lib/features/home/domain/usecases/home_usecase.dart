import 'package:either_dart/either.dart';
import 'package:local_db/features/home/data/repositories/home_repo_impl.dart';
import 'package:local_db/utils/api_handler.dart';
import 'package:local_db/utils/error/failure.dart';
import 'package:local_db/utils/use_case.dart';

class HomeUseCase implements UseCaseNoInput<dynamic> {
  @override
  Future<Either<Failure, dynamic>> invoke() async {
    return await HomeRepositoryImpl(ApiHandler()).fetchResults();
  }
}

class HomeUseCasePut implements UseCaseTwoInput<int, bool, dynamic> {
  @override
  Future<Either<Failure, dynamic>> invoke(int id, bool isCompleted) async {
    return await HomeRepositoryImpl(ApiHandler())
        .changeResults(id, isCompleted);
  }
}
