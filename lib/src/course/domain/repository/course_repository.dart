import 'package:course_assignment_app/core/failures.dart';

import '../entities/course.dart';
import 'package:dartz/dartz.dart';

abstract class CourseRepository {
  Future<Either<Failure, List<Course>>> getAllCourses();
  Future<Either<Failure, Course>> getCourse(int id);
  Future<Either<Failure, Course>> createCourse(Course course);
  Future<Either<Failure, Course>> updateCourse(Course course);
  Future<Either<Failure, void>> deleteCourse(int id);
  Future<Either<Failure, List<Course>>> searchCourses(String query);
  Future<Either<Failure, List<Course>>> filterByCategory(String category);
}