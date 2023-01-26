import 'package:mvvm_project_1/data/network/failure.dart';
import 'package:mvvm_project_1/data/request/request.dart';
import 'package:dartz/dartz.dart';

import '../model/model.dart';

abstract class Repository {
  Future<Either<Failure, Authentication>> login(LoginRequest loginRequest);
  Future<Either<Failure, String>> forgotPassword(String email);
  Future<Either<Failure, Authentication>> register(
      RegisterRequest registerRequest);
  Future<Either<Failure, HomeObject>> getHomeData();
  Future<Either<Failure, StoreDetailsObject>> getStoreDetails();
}
