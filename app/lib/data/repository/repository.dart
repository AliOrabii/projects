import 'package:dartz/dartz.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:news_app/app/constants.dart';
import 'package:news_app/data/data_source/remote_data_source.dart';
import 'package:news_app/data/network/error_handler.dart';
import 'package:news_app/data/network/failure.dart';
import 'package:news_app/data/responses/responses.dart';
import 'package:news_app/domain/models/models.dart';
import 'package:news_app/data/mapper/mapper.dart';
import 'package:news_app/presentation/resources/strings_manager.dart';

abstract class Repository {
  Future<Either<Failure, NewsData>> getData();
}

class RepositoryImpl implements Repository {
  final RemoteDataSource _remoteDataSource;
  final InternetConnectionChecker _connectionChecker;

  RepositoryImpl(this._remoteDataSource, this._connectionChecker);
  @override
  Future<Either<Failure, NewsData>> getData() async {
    if (await _connectionChecker.hasConnection) {
      final response = await _remoteDataSource.getData();
      if (response.status == AppStrings.ok) {
        return right(response.toDomain());
      } else {
        return left(Failure(response.status ?? AppStrings.notOk,
            response.totalResults ?? Constants.ZERO));
      }
    } else {
      return left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }
}
