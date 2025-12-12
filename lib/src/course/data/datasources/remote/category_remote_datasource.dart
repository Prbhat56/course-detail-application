import 'package:course_assignment_app/core/constants/app_constant.dart';
import 'package:dio/dio.dart';
import '../../models/category_model.dart';

abstract class CategoryRemoteDataSource {
  Future<List<CategoryModel>> getCategories();
}

class CategoryRemoteDataSourceImpl implements CategoryRemoteDataSource {
  final Dio dio;
  
  CategoryRemoteDataSourceImpl(this.dio);
  
  @override
  Future<List<CategoryModel>> getCategories() async {
    final response = await dio.get(
      '${AppConstants.mockApiBaseUrl}${AppConstants.categoriesEndpoint}',
    );
    
    final List<dynamic> data = response.data;
    return data.map((json) => CategoryModel.fromJson(json)).toList();
  }
}