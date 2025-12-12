import 'package:sqflite/sqflite.dart';
import '../../../domain/entities/category.dart';
import '../../models/category_model.dart';

abstract class CategoryLocalDataSource {
  Future<void> cacheCategories(List<CategoryModel> categories);
  Future<List<CategoryModel>> getCachedCategories();
}

class CategoryLocalDataSourceImpl implements CategoryLocalDataSource {
  final Database database;
  
  CategoryLocalDataSourceImpl(this.database);
  
  @override
  Future<void> cacheCategories(List<CategoryModel> categories) async {
    final batch = database.batch();
    for (final category in categories) {
      batch.insert(
        'categories',
        category.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }
    await batch.commit();
  }
  
  @override
  Future<List<CategoryModel>> getCachedCategories() async {
    final maps = await database.query('categories');
    return maps.map((map) => CategoryModel.fromJson(map)).toList();
  }
}