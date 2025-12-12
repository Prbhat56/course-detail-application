import 'package:course_assignment_app/core/constants/app_constant.dart';
import 'package:course_assignment_app/src/course/data/datasources/local/category_local_data_source.dart';
import 'package:course_assignment_app/src/course/data/datasources/local/course_local_datasource.dart';
import 'package:course_assignment_app/src/course/data/datasources/remote/category_remote_datasource.dart';
import 'package:course_assignment_app/src/course/domain/repository/category_repository.dart';
import 'package:course_assignment_app/src/course/domain/repository/course_repository.dart';
import 'package:course_assignment_app/src/course/domain/usecase/category_usecase.dart';
import 'package:course_assignment_app/src/course/domain/usecase/course_usecase.dart';
import 'package:course_assignment_app/src/course/presentation/bloc/courses/course_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'core/network/network_info.dart';
import 'src/course/data/repositories/course_repository_impl.dart';
import 'src/course/data/repositories/category_repository_impl.dart';
import 'src/course/presentation/bloc/category/category_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
  final database = await openDatabase(
    join(await getDatabasesPath(), AppConstants.databaseName),
    onCreate: (db, version) async {
      await db.execute('''
        CREATE TABLE courses(
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          title TEXT NOT NULL,
          description TEXT NOT NULL,
          category TEXT NOT NULL,
          lessons INTEGER NOT NULL,
          score INTEGER NOT NULL,
          createdAt TEXT NOT NULL,
          updatedAt TEXT NOT NULL
        )
      ''');

      await db.execute('''
        CREATE TABLE categories(
          id TEXT PRIMARY KEY,
          name TEXT NOT NULL
        )
      ''');
    },
    version: 1,
  );

  sl.registerLazySingleton<Database>(() => database);

  sl.registerLazySingleton<CourseLocalDataSource>(
    () => CourseLocalDataSourceImpl(sl()),
  );

  sl.registerLazySingleton<CategoryLocalDataSource>(
    () => CategoryLocalDataSourceImpl(sl()),
  );

  sl.registerLazySingleton<CategoryRemoteDataSource>(
    () => CategoryRemoteDataSourceImpl(sl()),
  );

  sl.registerLazySingleton<CourseRepository>(
    () => CourseRepositoryImpl(
      localDataSource: sl(),
      networkInfo: sl(),
    ),
  );

  sl.registerLazySingleton<CategoryRepository>(
    () => CategoryRepositoryImpl(
      remoteDataSource: sl(),
      localDataSource: sl(),
      networkInfo: sl(),
    ),
  );

  sl.registerLazySingleton(() => CourseUseCases(sl()));
  sl.registerLazySingleton(() => CategoryUseCases(sl()));

  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

  sl.registerLazySingleton(() => Dio()
    ..options = BaseOptions(
      baseUrl: AppConstants.mockApiBaseUrl,
      connectTimeout: AppConstants.apiTimeout,
      receiveTimeout: AppConstants.apiTimeout,
    ));

  sl.registerLazySingleton(() => Connectivity());

  sl.registerFactory(() => CourseBloc(useCases: sl()));
  sl.registerFactory(() => CategoryBloc(useCases: sl()));
}
