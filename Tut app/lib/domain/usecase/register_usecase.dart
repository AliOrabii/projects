import 'package:mvvm_project_1/data/network/failure.dart';
import 'package:mvvm_project_1/data/request/request.dart';
import 'package:mvvm_project_1/domain/model/model.dart';
import 'package:mvvm_project_1/domain/repository/repository.dart';
import 'package:mvvm_project_1/domain/usecase/base_usecase.dart';
import 'package:dartz/dartz.dart';

class RegisterUseCase
    implements BaseUseCase<RegisterUseCaseInput, Authentication> {
  Repository _repository;

  RegisterUseCase(this._repository);

  @override
  Future<Either<Failure, Authentication>> execute(
      RegisterUseCaseInput input) async {
    return await _repository.register(RegisterRequest(
      input.userName,
      input.countryMobileCode,
      input.mobileNumber,
      input.email,
      input.password,
      input.profilePicture,
    ));
  }
}

class RegisterUseCaseInput {
  String userName;
  String countryMobileCode;
  String mobileNumber;
  String email;
  String password;
  String profilePicture;

  RegisterUseCaseInput(
    this.userName,
    this.countryMobileCode,
    this.mobileNumber,
    this.email,
    this.password,
    this.profilePicture,
  );
}
