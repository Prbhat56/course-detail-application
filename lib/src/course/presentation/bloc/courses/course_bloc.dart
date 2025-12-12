import 'package:course_assignment_app/src/course/domain/usecase/course_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../domain/entities/course.dart';

part 'course_event.dart';
part 'course_state.dart';

class CourseBloc extends Bloc<CourseEvent, CourseState> {
  final CourseUseCases useCases;

  CourseBloc({required this.useCases}) : super(CourseInitial()) {
    on<LoadCourses>(_onLoadCourses);
    on<LoadCourse>(_onLoadCourse);
    on<AddCourse>(_onAddCourse);
    on<UpdateCourseEvent>(_onUpdateCourse);
    on<DeleteCourseEvent>(_onDeleteCourse);
    on<SearchCourse>(_onSearchCourse);
    on<FilterCourse>(_onFilterCourse);
  }

  Future<void> _onLoadCourses(
    LoadCourses event,
    Emitter<CourseState> emit,
  ) async {
    emit(CourseLoading());
    final result = await useCases.getAllCourses();
    result.fold(
      (failure) => emit(CourseError(failure.message)),
      (courses) => emit(CourseLoaded(courses)),
    );
  }

  Future<void> _onLoadCourse(
    LoadCourse event,
    Emitter<CourseState> emit,
  ) async {
    emit(CourseLoading());
    final result = await useCases.getCourse(event.id);
    result.fold(
      (failure) => emit(CourseError(failure.message)),
      (course) => emit(CourseLoaded([course])),
    );
  }

  Future<void> _onAddCourse(
    AddCourse event,
    Emitter<CourseState> emit,
  ) async {
    final result = await useCases.createCourse(event.course);
    result.fold(
      (failure) => emit(CourseError(failure.message)),
      (course) => emit(CourseAdded(course)),
    );
  }

  Future<void> _onUpdateCourse(
    UpdateCourseEvent event,
    Emitter<CourseState> emit,
  ) async {
    final result = await useCases.updateCourse(event.course);
    result.fold(
      (failure) => emit(CourseError(failure.message)),
      (course) => emit(CourseUpdated(course)),
    );
  }

  Future<void> _onDeleteCourse(
    DeleteCourseEvent event,
    Emitter<CourseState> emit,
  ) async {
    final result = await useCases.deleteCourse(event.id);
    result.fold(
      (failure) => emit(CourseError(failure.message)),
      (_) => emit(CourseDeleted(event.id)),
    );
  }

  Future<void> _onSearchCourse(
    SearchCourse event,
    Emitter<CourseState> emit,
  ) async {
    if (event.query.isEmpty) {
      add(LoadCourses());
      return;
    }

    emit(CourseLoading());
    final result = await useCases.searchCourses(event.query);
    result.fold(
      (failure) => emit(CourseError(failure.message)),
      (courses) => emit(CourseLoaded(courses)),
    );
  }

  Future<void> _onFilterCourse(
    FilterCourse event,
    Emitter<CourseState> emit,
  ) async {
    emit(CourseLoading());
    final result = await useCases.filterByCategory(event.category);
    result.fold(
      (failure) => emit(CourseError(failure.message)),
      (courses) => emit(CourseLoaded(courses)),
    );
  }
}
