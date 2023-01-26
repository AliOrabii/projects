import 'package:mvvm_project_1/app/functions.dart';
import 'package:mvvm_project_1/data/network/failure.dart';
import 'package:mvvm_project_1/data/request/request.dart';
import 'package:mvvm_project_1/domain/model/model.dart';
import 'package:mvvm_project_1/domain/repository/repository.dart';
import 'package:mvvm_project_1/domain/usecase/base_usecase.dart';
import 'package:dartz/dartz.dart';

class LoginUseCase implements BaseUseCase<LoginUseCaseInput, Authentication> {
  Repository _repository;

  LoginUseCase(this._repository);

  @override
  Future<Either<Failure, Authentication>> execute(
      LoginUseCaseInput input) async {
    DeviceInfo deviceInfo = await getDeviceDetails();
    return await _repository.login(LoginRequest(
      input.email,
      input.password,
    ));
  }
}

class LoginUseCaseInput {
  String email;
  String password;

  LoginUseCaseInput(this.email, this.password);
}
