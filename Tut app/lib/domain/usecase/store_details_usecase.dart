import 'package:mvvm_project_1/data/network/failure.dart';
import 'package:mvvm_project_1/domain/model/model.dart';
import 'package:mvvm_project_1/domain/repository/repository.dart';
import 'package:mvvm_project_1/domain/usecase/base_usecase.dart';
import 'package:dartz/dartz.dart';

class StoreDetailsUseCase implements BaseUseCase<void, StoreDetailsObject> {
  Repository _repository;

  StoreDetailsUseCase(this._repository);

  @override
  Future<Either<Failure, StoreDetailsObject>> execute(void input) async {
    return await _repository.getStoreDetails();
  }
}
