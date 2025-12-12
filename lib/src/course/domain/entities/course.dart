import 'package:equatable/equatable.dart';

class Course extends Equatable {
  final int? id;
  final String title;
  final String description;
  final String category;
  final int lessons;
  final int score;
  final DateTime createdAt;
  final DateTime updatedAt;
  
  const Course({
    this.id,
    required this.title,
    required this.description,
    required this.category,
    required this.lessons,
    required this.score,
    required this.createdAt,
    required this.updatedAt,
  });
  
  Course copyWith({
    int? id,
    String? title,
    String? description,
    String? category,
    int? lessons,
    int? score,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Course(
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
  
  @override
  List<Object?> get props => [
    id,
    title,
    description,
    category,
    lessons,
    score,
    createdAt,
    updatedAt,
  ];
}