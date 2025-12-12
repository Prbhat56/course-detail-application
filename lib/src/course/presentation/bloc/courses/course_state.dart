part of 'course_bloc.dart';

abstract class CourseState extends Equatable {
  const CourseState();
}

class CourseInitial extends CourseState {
  @override
  List<Object?> get props => [];
}

class CourseLoading extends CourseState {
  @override
  List<Object?> get props => [];
}

class CourseLoaded extends CourseState {
  final List<Course> courses;
  
  const CourseLoaded(this.courses);
  
  @override
  List<Object?> get props => [courses];
}

class CourseAdded extends CourseState {
  final Course course;
  
  const CourseAdded(this.course);
  
  @override
  List<Object?> get props => [course];
}

class CourseUpdated extends CourseState {
  final Course course;
  
  const CourseUpdated(this.course);
  
  @override
  List<Object?> get props => [course];
}

class CourseDeleted extends CourseState {
  final int id;
  
  const CourseDeleted(this.id);
  
  @override
  List<Object?> get props => [id];
}

class CourseError extends CourseState {
  final String message;
  
  const CourseError(this.message);
  
  @override
  List<Object?> get props => [message];
}