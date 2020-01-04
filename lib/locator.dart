import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:state_management/data/repo/movie_repository.dart';
import 'package:state_management/data/repo/movie_repository_impl.dart';
import 'package:state_management/data/service/mock_web_service_impl.dart';
import 'package:state_management/data/service/web_service.dart';
import 'package:state_management/data/service/web_service_impl.dart';
import 'package:state_management/data/store/data_store.dart';
import 'package:state_management/data/store/data_store_impl.dart';
import 'package:state_management/data/utils/data_to_domain_mapper.dart';
import 'package:state_management/ui/movie/detail/view_model/detail_view_model.dart';
import 'package:state_management/ui/movie/list/view_model/movie_list_view_model.dart';

GetIt locator = GetIt.instance;

void _setupLocator() {

  // Service
  locator.registerLazySingleton<DataStore>(
      () => DataStoreImpl(locator<WebService>()));

  // Mapper
  locator.registerLazySingleton(() => DataToDomainMapper());

  // Repository
  locator.registerLazySingleton<MovieRepository>(() =>
      MovieRepositoryImpl(locator<DataStore>(), locator<DataToDomainMapper>()));

  // View Model
  locator.registerFactory(() => MovieListViewModel(locator<MovieRepository>()));
  locator.registerFactory(() => DetailViewModel());
}

void setupMockLocator(BuildContext context) {
  locator.registerLazySingleton<WebService>(
      () => MockWebServiceImpl(DefaultAssetBundle.of(context)));
  _setupLocator();
}

void setupLocator() {
  locator.registerLazySingleton<WebService>(() => WebServiceImpl());
  _setupLocator();
}
