import 'package:course_assignment_app/core/failures.dart';

import '../entities/category.dart';
import 'package:dartz/dartz.dart';

abstract class CategoryRepository {
  Future<Either<Failure, List<Category>>> getCategories();
  Future<Either<Failure, void>> cacheCategories(List<Category> categories);
  Future<Either<Failure, List<Category>>> getCachedCategories();
}