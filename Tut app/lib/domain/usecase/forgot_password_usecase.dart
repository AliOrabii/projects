import 'package:mvvm_project_1/data/network/failure.dart';
import 'package:mvvm_project_1/domain/repository/repository.dart';
import 'package:mvvm_project_1/domain/usecase/base_usecase.dart';
import 'package:dartz/dartz.dart';

class ForgotPasswordUseCase implements BaseUseCase<String, String> {
  final Repository _repository;

  ForgotPasswordUseCase(this._repository);

  @override
  Future<Either<Failure, String>> execute(String input) async {
    return await _repository.forgotPassword(input);
  }
}
