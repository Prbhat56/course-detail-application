import 'package:course_assignment_app/src/course/domain/repository/category_repository.dart';
import 'package:dartz/dartz.dart';
import '../../../../core/failures.dart';
import '../entities/category.dart';

class CategoryUseCases {
  final CategoryRepository repository;

  CategoryUseCases(this.repository);

  Future<Either<Failure, List<Category>>> getCategories() {
    return repository.getCategories();
  }
}
