import 'package:course_assignment_app/core/failures.dart';
import 'package:course_assignment_app/core/network/network_info.dart';
import 'package:course_assignment_app/src/course/data/datasources/local/category_local_data_source.dart';
import 'package:course_assignment_app/src/course/data/datasources/remote/category_remote_datasource.dart';
import 'package:course_assignment_app/src/course/data/models/category_model.dart';
import 'package:course_assignment_app/src/course/domain/repository/category_repository.dart';

import '../../domain/entities/category.dart';
import 'package:dartz/dartz.dart';

class CategoryRepositoryImpl implements CategoryRepository {
  final CategoryRemoteDataSource remoteDataSource;
  final CategoryLocalDataSource localDataSource;
  final NetworkInfo networkInfo;
  
  CategoryRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });
  
  @override
  Future<Either<Failure, List<Category>>> getCategories() async {
    try {
      if (await networkInfo.isConnected) {
        final remoteCategories = await remoteDataSource.getCategories();
        await localDataSource.cacheCategories(remoteCategories);
        return Right(remoteCategories);
      } else {
        final localCategories = await localDataSource.getCachedCategories();
        return Right(localCategories);
      }
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
  
  @override
  Future<Either<Failure, void>> cacheCategories(List<Category> categories) async {
    try {
      final categoryModels = categories
          .map((c) => CategoryModel(id: c.id, name: c.name))
          .toList();
      await localDataSource.cacheCategories(categoryModels);
      return const Right(null);
    } catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }
  
  @override
  Future<Either<Failure, List<Category>>> getCachedCategories() async {
    try {
      final categories = await localDataSource.getCachedCategories();
      return Right(categories);
    } catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }
}