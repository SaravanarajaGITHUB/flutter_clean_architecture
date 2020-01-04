import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:state_management/data/local/cache.dart';
import 'package:state_management/data/local/cache_impl.dart';
import 'package:state_management/data/remote/mock_web_service_impl.dart';
import 'package:state_management/data/remote/web_service.dart';
import 'package:state_management/data/remote/web_service_impl.dart';
import 'package:state_management/data/repo/movie_repository.dart';
import 'package:state_management/data/repo/movie_repository_impl.dart';
import 'package:state_management/data/store/data_store.dart';
import 'package:state_management/data/store/data_store_impl.dart';
import 'package:state_management/data/utils/data_to_domain_mapper.dart';
import 'package:state_management/domain/usecase/detail/movie_detail_use_case.dart';
import 'package:state_management/domain/usecase/detail/movie_detail_use_case_impl.dart';
import 'package:state_management/domain/usecase/movie/movie_use_case.dart';
import 'package:state_management/domain/usecase/movie/movie_use_case_impl.dart';
import 'package:state_management/domain/utils/domain_to_model_mapper.dart';
import 'package:state_management/ui/movie/detail/view_model/detail_view_model.dart';
import 'package:state_management/ui/movie/list/view_model/movie_list_view_model.dart';

GetIt locator = GetIt.instance;

void _setupLocator() {
  // Cache
  locator.registerLazySingleton<Cache>(() => CacheImpl());

  // Data Store
  locator.registerLazySingleton<DataStore>(
      () => DataStoreImpl(locator<WebService>(), locator<Cache>()));

  // Mapper
  locator.registerLazySingleton(() => DataToDomainMapper());
  locator.registerLazySingleton(() => DomainToModelMapper());

  // Repository
  locator.registerLazySingleton<MovieRepository>(() =>
      MovieRepositoryImpl(locator<DataStore>(), locator<DataToDomainMapper>()));

  // UseCase
  locator.registerFactory<MovieUseCase>(() => MovieUseCaseImpl(
      locator<MovieRepository>(), locator<DomainToModelMapper>()));
  locator.registerFactory<MovieDetailUseCase>(() => MovieDetailUseCaseImpl(
      locator<MovieRepository>(), locator<DomainToModelMapper>()));

  // View Model
  locator.registerFactory(() => MovieListViewModel(locator<MovieUseCase>()));
  locator.registerFactory(() => DetailViewModel(locator<MovieDetailUseCase>()));
}

void setupMockLocator(BuildContext context) {
  //Mock Service
  locator.registerLazySingleton<WebService>(
      () => MockWebServiceImpl(DefaultAssetBundle.of(context)));
  _setupLocator();
}

void setupLocator() {
  // Web Service
  locator.registerLazySingleton<WebService>(() => WebServiceImpl());
  _setupLocator();
}
