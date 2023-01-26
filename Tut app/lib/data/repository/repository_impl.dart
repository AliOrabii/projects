import 'package:mvvm_project_1/data/data_source/local_data_source.dart';
import 'package:mvvm_project_1/data/data_source/remote_data_source.dart';
import 'package:mvvm_project_1/data/network/error_handler.dart';
import 'package:mvvm_project_1/data/network/failure.dart';
import 'package:mvvm_project_1/data/network/network_info.dart';
import 'package:mvvm_project_1/data/request/request.dart';
import 'package:mvvm_project_1/domain/model/model.dart';
import 'package:mvvm_project_1/domain/repository/repository.dart';
import 'package:dartz/dartz.dart';
import 'package:mvvm_project_1/data/mapper/mapper.dart';

class RepositoryImpl extends Repository {
  RemoteDataSource _remoteDataSource;
  NetworkInfo _networkInfo;
  LocalDataSource _localDataSource;

  RepositoryImpl(
      this._remoteDataSource, this._networkInfo, this._localDataSource);

  @override
  Future<Either<Failure, Authentication>> login(
      LoginRequest loginRequest) async {
    if (await _networkInfo.isConnected) {
      try {
        // its safe to call the API
        final response = await _remoteDataSource.login(loginRequest);

        if (response.status == ApiInternalStatus.SUCCESS) // success
        {
          // return data (success)
          // return right
          return Right(response.toDomain());
        } else {
          // return biz logic error
          // return left
          return Left(Failure(response.status ?? ApiInternalStatus.FAILURE,
              response.message ?? ResponseMessage.DEFAULT));
        }
      } catch (error) {
        return (Left(ErrorHandler.handle(error).failure));
      }
    } else {
      // return connection error
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }

  @override
  Future<Either<Failure, String>> forgotPassword(String email) async {
    if (await _networkInfo.isConnected) {
      try {
        // its safe to call API
        final response = await _remoteDataSource.forgotPassword(email);

        if (response.status == ApiInternalStatus.SUCCESS) {
          // success
          // return right
          return Right(response.toDomain());
        } else {
          // failure
          // return left
          return Left(Failure(response.status ?? ResponseCode.DEFAULT,
              response.message ?? ResponseMessage.DEFAULT));
        }
      } catch (error) {
        return Left(ErrorHandler.handle(error).failure);
      }
    } else {
      // return network connection error
      // return left
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }

  @override
  Future<Either<Failure, Authentication>> register(
      RegisterRequest registerRequest) async {
    if (await _networkInfo.isConnected) {
      try {
        // its safe to call the API
        final response = await _remoteDataSource.register(registerRequest);

        if (response.status == ApiInternalStatus.SUCCESS) // success
        {
          // return data (success)
          // return right
          return Right(response.toDomain());
        } else {
          // return biz logic error
          // return left
          return Left(Failure(response.status ?? ApiInternalStatus.FAILURE,
              response.message ?? ResponseMessage.DEFAULT));
        }
      } catch (error) {
        return (Left(ErrorHandler.handle(error).failure));
      }
    } else {
      // return connection error
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }

  @override
  Future<Either<Failure, HomeObject>> getHomeData() async {
    try {
      final response = await _localDataSource.getHomeData();
      return Right(response.toDomain());
    } catch (caceError) {
      if (await _networkInfo.isConnected) {
        try {
          // its safe to call API

          final response = await _remoteDataSource.getHomeData();
          if (response.status == ApiInternalStatus.SUCCESS) {
            // success
            // return right
            _localDataSource.saveHomeToCache(response, CACHE_HOME_KEY);
            return Right(response.toDomain());
          } else {
            // failure
            // return left
            return Left(Failure(response.status ?? ResponseCode.DEFAULT,
                response.message ?? ResponseMessage.DEFAULT));
          }
        } catch (error) {
          return Left(ErrorHandler.handle(error).failure);
        }
      } else {
        // return network connection error
        // return left
        return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
      }
    }
  }

  @override
  Future<Either<Failure, StoreDetailsObject>> getStoreDetails() async {
    try {
      final response = await _localDataSource.getStoreDetails();
      return Right(response.toDomain());
    } catch (caceError) {
      if (await _networkInfo.isConnected) {
        try {
          // its safe to call API

          final response = await _remoteDataSource.getStoreDetails();
          if (response.status == ApiInternalStatus.SUCCESS) {
            // success
            // return right
            _localDataSource.saveHomeToCache(response, CACHE_STORE_DETAILS_KEY);
            return Right(response.toDomain());
          } else {
            // failure
            // return left
            return Left(Failure(response.status ?? ResponseCode.DEFAULT,
                response.message ?? ResponseMessage.DEFAULT));
          }
        } catch (error) {
          return Left(ErrorHandler.handle(error).failure);
        }
      } else {
        // return network connection error
        // return left
        return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
      }
    }
  }
}
