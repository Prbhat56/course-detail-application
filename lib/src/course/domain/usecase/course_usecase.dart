import 'package:course_assignment_app/src/course/domain/repository/course_repository.dart';
import 'package:dartz/dartz.dart';
import '../../../../core/failures.dart';
import '../entities/course.dart';

class CourseUseCases {
  final CourseRepository repository;

  CourseUseCases(this.repository);


  Future<Either<Failure, List<Course>>> getAllCourses() {
    return repository.getAllCourses();
  }

  Future<Either<Failure, Course>> getCourse(int id) {
    return repository.getCourse(id);
  }

 
  Future<Either<Failure, Course>> createCourse(Course course) {
    return repository.createCourse(course);
  }


  Future<Either<Failure, Course>> updateCourse(Course course) {
    return repository.updateCourse(course);
  }

  
  Future<Either<Failure, void>> deleteCourse(int id) {
    return repository.deleteCourse(id);
  }


  Future<Either<Failure, List<Course>>> searchCourses(String query) {
    return repository.searchCourses(query);
  }


  Future<Either<Failure, List<Course>>> filterByCategory(String category) {
    return repository.filterByCategory(category);
  }
}
