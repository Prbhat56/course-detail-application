import '../../domain/entities/course.dart';

class CourseModel extends Course {
  const CourseModel({
    int? id,
    required String title,
    required String description,
    required String category,
    required int lessons,
    required int score,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) : super(
    id: id,
    title: title,
    description: description,
    category: category,
    lessons: lessons,
    score: score,
    createdAt: createdAt,
    updatedAt: updatedAt,
  );
  
  factory CourseModel.fromJson(Map<String, dynamic> json) {
    return CourseModel(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      category: json['category'],
      lessons: json['lessons'],
      score: json['score'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }
  
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'category': category,
      'lessons': lessons,
      'score': score,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }
  
  CourseModel copyWith({
    int? id,
    String? title,
    String? description,
    String? category,
    int? lessons,
    int? score,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return CourseModel(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      category: category ?? this.category,
      lessons: lessons ?? this.lessons,
      score: score ?? this.score,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}