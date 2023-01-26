import 'package:news_app/data/network/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:news_app/data/repository/repository.dart';
import 'package:news_app/domain/models/models.dart';
import 'package:news_app/domain/usecase/base_usecase.dart';

class NewsUseCase implements BaseUseCase<void, NewsData> {
  Repository _repository;

  NewsUseCase(this._repository);
  @override
  Future<Either<Failure, NewsData>> execute(void input) async {
    return await _repository.getData();
  }
}
