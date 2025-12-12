import 'package:course_assignment_app/in_it.dart' as di;
import 'package:course_assignment_app/src/course/domain/entities/course.dart';
import 'package:course_assignment_app/src/course/presentation/bloc/category/category_bloc.dart';
import 'package:course_assignment_app/src/course/presentation/bloc/courses/course_bloc.dart';
import 'package:course_assignment_app/src/course/presentation/pages/add_course_page.dart';
import 'package:course_assignment_app/src/course/presentation/pages/course_details_page.dart';
import 'package:course_assignment_app/src/course/presentation/pages/course_list_page.dart';
import 'package:course_assignment_app/src/course/presentation/pages/edit_course_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<CourseBloc>(
          create: (context) => di.sl<CourseBloc>(),
        ),
        BlocProvider<CategoryBloc>(
          create: (context) => di.sl<CategoryBloc>(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Course Manager',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        initialRoute: '/',
        routes: {
          '/': (context) => const CourseListPage(),
          '/add_course': (context) => const AddCoursePage(),
        },
        onGenerateRoute: (settings) {
          if (settings.name == '/edit_course') {
            final course = settings.arguments as Course;
            return MaterialPageRoute(
              builder: (context) => EditCoursePage(course: course),
            );
          }
          
          if (settings.name == '/course_details') {
            final courseId = settings.arguments as int;
            return MaterialPageRoute(
              builder: (context) => CourseDetailsPage(courseId: courseId),
            );
          }
          
          return null;
        },
      ),
    );
  }
}