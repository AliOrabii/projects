import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:news_app/data/data_source/remote_data_source.dart';
import 'package:news_app/data/network/app_api.dart';
import 'package:news_app/data/network/dio_factory.dart';
import 'package:news_app/data/repository/repository.dart';
import 'package:news_app/domain/provider/news.dart';
import 'package:news_app/domain/usecase/news_usecase.dart';
import 'package:news_app/presentation/home/viewmodel/home_viewmodel.dart';

final instance = GetIt.instance;

Future<void> initAppModule() async {
  instance.registerLazySingleton<DioFactory>(() => DioFactory());

  final dio = await instance<DioFactory>().getDio();
  instance.registerLazySingleton<AppServiceClient>(() => AppServiceClient(dio));

  instance.registerLazySingleton<RemoteDataSource>(
    () => RemoteDataSourceImpl(
      instance(),
    ),
  );
  instance.registerLazySingleton<InternetConnectionChecker>(
      () => InternetConnectionChecker());
  instance.registerLazySingleton<Repository>(
      () => RepositoryImpl(instance(), instance()));
}

initHomeModule() {
  if (!GetIt.I.isRegistered<NewsUseCase>()) {
    instance.registerFactory<NewsUseCase>(() => NewsUseCase(instance()));
    instance.registerFactory<homeViewModel>(() => homeViewModel(instance()));
  }
}

initDetailsModule() {
  if (!GetIt.I.isRegistered<News>()) {
    instance.registerLazySingleton<News>(() => News());
  }
}
