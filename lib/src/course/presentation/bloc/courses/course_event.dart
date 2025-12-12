part of 'course_bloc.dart';

abstract class CourseEvent extends Equatable {
  const CourseEvent();
}

class LoadCourses extends CourseEvent {
  @override
  List<Object?> get props => [];
}

class LoadCourse extends CourseEvent {
  final int id;
  
  const LoadCourse(this.id);
  
  @override
  List<Object?> get props => [id];
}

class AddCourse extends CourseEvent {
  final Course course;
  
  const AddCourse(this.course);
  
  @override
  List<Object?> get props => [course];
}

class UpdateCourseEvent extends CourseEvent {
  final Course course;
  
  const UpdateCourseEvent(this.course);
  
  @override
  List<Object?> get props => [course];
}

class DeleteCourseEvent extends CourseEvent {
  final int id;
  
  const DeleteCourseEvent(this.id);
  
  @override
  List<Object?> get props => [id];
}

class SearchCourse extends CourseEvent {
  final String query;
  
  const SearchCourse(this.query);
  
  @override
  List<Object?> get props => [query];
}

class FilterCourse extends CourseEvent {
  final String category;
  
  const FilterCourse(this.category);
  
  @override
  List<Object?> get props => [category];
}