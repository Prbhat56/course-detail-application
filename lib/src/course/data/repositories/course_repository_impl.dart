import 'package:course_assignment_app/core/failures.dart';
import 'package:course_assignment_app/core/network/network_info.dart';
import 'package:course_assignment_app/src/course/data/models/course_model.dart';
import 'package:course_assignment_app/src/course/domain/repository/course_repository.dart';

import '../../domain/entities/course.dart';
import '../datasources/local/course_local_datasource.dart';
import 'package:dartz/dartz.dart';

class CourseRepositoryImpl implements CourseRepository {
  final CourseLocalDataSource localDataSource;
  final NetworkInfo networkInfo;
  
  CourseRepositoryImpl({
    required this.localDataSource,
    required this.networkInfo,
  });
  
  @override
  Future<Either<Failure, List<Course>>> getAllCourses() async {
    try {
      final courses = await localDataSource.getAllCourses();
      return Right(courses);
    } catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }
  
  @override
  Future<Either<Failure, Course>> getCourse(int id) async {
    try {
      final course = await localDataSource.getCourse(id);
      if (course == null) {
        return Left(CacheFailure('Course not found'));
      }
      return Right(course);
    } catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }
  
  @override
  Future<Either<Failure, Course>> createCourse(Course course) async {
    try {
      final courseModel = CourseModel(
        id: course.id,
        title: course.title,
        description: course.description,
        category: course.category,
        lessons: course.lessons,
        score: course.title.length * course.lessons,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );
      
      final id = await localDataSource.insertCourse(courseModel);
      final createdCourse = courseModel.copyWith(id: id);
      return Right(createdCourse);
    } catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }
  
  @override
  Future<Either<Failure, Course>> updateCourse(Course course) async {
    try {
      final courseModel = CourseModel(
        id: course.id,
        title: course.title,
        description: course.description,
        category: course.category,
        lessons: course.lessons,
        score: course.title.length * course.lessons,
        createdAt: course.createdAt,
        updatedAt: DateTime.now(),
      );
      
      await localDataSource.updateCourse(courseModel);
      return Right(courseModel);
    } catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }
  
  @override
  Future<Either<Failure, void>> deleteCourse(int id) async {
    try {
      await localDataSource.deleteCourse(id);
      return const Right(null);
    } catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }
  
  @override
  Future<Either<Failure, List<Course>>> searchCourses(String query) async {
    try {
      final courses = await localDataSource.searchCourses(query);
      return Right(courses);
    } catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }
  
  @override
  Future<Either<Failure, List<Course>>> filterByCategory(String category) async {
    try {
      final courses = await localDataSource.filterByCategory(category);
      return Right(courses);
    } catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }
}