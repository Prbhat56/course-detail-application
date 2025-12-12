import 'package:sqflite/sqflite.dart';
import '../../../domain/entities/course.dart';
import '../../models/course_model.dart';

abstract class CourseLocalDataSource {
  Future<List<CourseModel>> getAllCourses();
  Future<CourseModel?> getCourse(int id);
  Future<int> insertCourse(CourseModel course);
  Future<int> updateCourse(CourseModel course);
  Future<int> deleteCourse(int id);
  Future<List<CourseModel>> searchCourses(String query);
  Future<List<CourseModel>> filterByCategory(String category);
}

class CourseLocalDataSourceImpl implements CourseLocalDataSource {
  final Database database;

  CourseLocalDataSourceImpl(this.database);

  @override
  Future<List<CourseModel>> getAllCourses() async {
    final maps = await database.query('courses', orderBy: 'updatedAt DESC');
    return maps.map((map) => CourseModel.fromJson(map)).toList();
  }

  @override
  Future<CourseModel?> getCourse(int id) async {
    final maps = await database.query(
      'courses',
      where: 'id = ?',
      whereArgs: [id],
    );
    if (maps.isNotEmpty) {
      return CourseModel.fromJson(maps.first);
    }
    return null;
  }

  @override
  Future<int> insertCourse(CourseModel course) async {
    return await database.insert('courses', course.toJson());
  }

  @override
  Future<int> updateCourse(CourseModel course) async {
    return await database.update(
      'courses',
      course.toJson(),
      where: 'id = ?',
      whereArgs: [course.id],
    );
  }

  @override
  Future<int> deleteCourse(int id) async {
    return await database.delete(
      'courses',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  @override
  Future<List<CourseModel>> searchCourses(String query) async {
    final maps = await database.query(
      'courses',
      where: 'title LIKE ? OR description LIKE ?',
      whereArgs: ['%$query%', '%$query%'],
    );
    return maps.map((map) => CourseModel.fromJson(map)).toList();
  }

  @override
  Future<List<CourseModel>> filterByCategory(String category) async {
    final maps = await database.query(
      'courses',
      where: 'category = ?',
      whereArgs: [category],
    );
    return maps.map((map) => CourseModel.fromJson(map)).toList();
  }
}
