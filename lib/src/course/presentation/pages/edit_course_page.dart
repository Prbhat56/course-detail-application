import 'package:course_assignment_app/core/utils/input_validator.dart';
import 'package:course_assignment_app/src/course/presentation/bloc/category/category_bloc.dart';
import 'package:course_assignment_app/src/course/presentation/bloc/courses/course_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/course.dart';

class EditCoursePage extends StatefulWidget {
  final Course course;
  
  const EditCoursePage({Key? key, required this.course}) : super(key: key);
  
  @override
  _EditCoursePageState createState() => _EditCoursePageState();
}

class _EditCoursePageState extends State<EditCoursePage> {
  late final _formKey = GlobalKey<FormState>();
  late final _titleController = TextEditingController(
    text: widget.course.title,
  );
  late final _descriptionController = TextEditingController(
    text: widget.course.description,
  );
  late final _lessonsController = TextEditingController(
    text: widget.course.lessons.toString(),
  );
  late String? _selectedCategory = widget.course.category;
  
  @override
  void initState() {
    super.initState();
    context.read<CategoryBloc>().add(LoadCategories());
  }
  
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Edit Course',
          style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: theme.scaffoldBackgroundColor,
        foregroundColor: theme.colorScheme.onSurface,
      ),
      body: Container(
        color: theme.scaffoldBackgroundColor,
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: theme.cardColor,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        _buildHeaderSection(theme),
                        const SizedBox(height: 28),
                        _buildTitleField(theme),
                        const SizedBox(height: 20),
                        _buildDescriptionField(theme),
                        const SizedBox(height: 20),
                        _buildCategoryDropdown(theme),
                        const SizedBox(height: 20),
                        _buildLessonsField(theme),
                        const SizedBox(height: 32),
                        _buildUpdateButton(theme),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              _buildScorePreviewSection(theme),
            ],
          ),
        ),
      ),
    );
  }
  
  Widget _buildHeaderSection(ThemeData theme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: theme.primaryColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: theme.primaryColor,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.edit_note,
                  size: 20,
                  color: Colors.white,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Edit Course Details',
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w700,
                        color: theme.colorScheme.onSurface,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      'Update the course information below',
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: theme.colorScheme.onSurface.withOpacity(0.6),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        Divider(
          height: 1,
          color: theme.colorScheme.outline.withOpacity(0.1),
        ),
      ],
    );
  }
  
  Widget _buildTitleField(ThemeData theme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Course Title',
          style: theme.textTheme.labelLarge?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: _titleController,
          onChanged: (_) => setState(() {}),
          decoration: InputDecoration(
            hintText: 'Enter course title',
            hintStyle: TextStyle(
              color: theme.colorScheme.onSurface.withOpacity(0.4),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                color: theme.colorScheme.outline.withOpacity(0.3),
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                color: theme.primaryColor,
                width: 2,
              ),
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 14,
            ),
            suffixIcon: _titleController.text.isNotEmpty
                ? Icon(
                    Icons.check_circle,
                    color: Colors.green.shade500,
                  )
                : null,
          ),
          style: theme.textTheme.bodyLarge,
          validator: (value) => InputValidator.validateRequired(
            value,
            'Title',
          ),
        ),
      ],
    );
  }
  
  Widget _buildDescriptionField(ThemeData theme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Description',
          style: theme.textTheme.labelLarge?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: _descriptionController,
          onChanged: (_) => setState(() {}),
          decoration: InputDecoration(
            hintText: 'Enter course description',
            hintStyle: TextStyle(
              color: theme.colorScheme.onSurface.withOpacity(0.4),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                color: theme.colorScheme.outline.withOpacity(0.3),
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                color: theme.primaryColor,
                width: 2,
              ),
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 16,
            ),
            suffixIcon: _descriptionController.text.isNotEmpty
                ? Icon(
                    Icons.check_circle,
                    color: Colors.green.shade500,
                  )
                : null,
          ),
          maxLines: 4,
          style: theme.textTheme.bodyLarge,
          validator: (value) => InputValidator.validateRequired(
            value,
            'Description',
          ),
        ),
      ],
    );
  }
  
  Widget _buildCategoryDropdown(ThemeData theme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Category',
          style: theme.textTheme.labelLarge?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),
        BlocBuilder<CategoryBloc, CategoryState>(
          builder: (context, state) {
            if (state is CategoryLoading) {
              return Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: theme.colorScheme.outline.withOpacity(0.3),
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Center(
                  child: CircularProgressIndicator(),
                ),
              );
            }
            
            if (state is CategoryError) {
              return Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.red.shade50,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.red.shade100),
                ),
                child: Text(
                  'Error: ${state.message}',
                  style: TextStyle(
                    color: Colors.red.shade700,
                  ),
                ),
              );
            }
            
            if (state is CategoryLoaded) {
              final categories = state.categories;
              return Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: theme.colorScheme.outline.withOpacity(0.3),
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: DropdownButtonFormField<String>(
                  value: _selectedCategory,
                  decoration: InputDecoration(
                    hintText: 'Select a category',
                    hintStyle: TextStyle(
                      color: theme.colorScheme.onSurface.withOpacity(0.4),
                    ),
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 14,
                    ),
                    suffixIcon: _selectedCategory != null
                        ? Icon(
                            Icons.check_circle,
                            color: Colors.green.shade500,
                          )
                        : null,
                  ),
                  borderRadius: BorderRadius.circular(12),
                  menuMaxHeight: 300,
                  items: [
                    DropdownMenuItem(
                      value: null,
                      child: Text(
                        'Select a category',
                        style: TextStyle(
                          color: theme.colorScheme.onSurface.withOpacity(0.6),
                        ),
                      ),
                    ),
                    ...categories.map((category) {
                      return DropdownMenuItem(
                        value: category.name,
                        child: Text(
                          category.name,
                          style: theme.textTheme.bodyMedium,
                        ),
                      );
                    }).toList(),
                  ],
                  onChanged: (value) {
                    setState(() {
                      _selectedCategory = value;
                    });
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please select a category';
                    }
                    return null;
                  },
                  style: theme.textTheme.bodyLarge,
                ),
              );
            }
            
            return const SizedBox();
          },
        ),
      ],
    );
  }
  
  Widget _buildLessonsField(ThemeData theme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Number of Lessons',
          style: theme.textTheme.labelLarge?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: _lessonsController,
          onChanged: (_) => setState(() {}),
          decoration: InputDecoration(
            hintText: 'Enter number of lessons',
            hintStyle: TextStyle(
              color: theme.colorScheme.onSurface.withOpacity(0.4),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                color: theme.colorScheme.outline.withOpacity(0.3),
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                color: theme.primaryColor,
                width: 2,
              ),
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 14,
            ),
            suffixIcon: _lessonsController.text.isNotEmpty && 
                        int.tryParse(_lessonsController.text) != null &&
                        int.parse(_lessonsController.text) > 0
                ? Icon(
                    Icons.check_circle,
                    color: Colors.green.shade500,
                  )
                : null,
          ),
          keyboardType: TextInputType.number,
          style: theme.textTheme.bodyLarge,
          validator: (value) => InputValidator.validatePositiveNumber(
            value,
            'Number of lessons',
          ),
        ),
      ],
    );
  }
  
  Widget _buildUpdateButton(ThemeData theme) {
    return BlocListener<CourseBloc, CourseState>(
      listener: (context, state) {
        if (state is CourseUpdated) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: const Text('Course updated successfully'),
              backgroundColor: Colors.green,
              behavior: SnackBarBehavior.floating,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          );
        Navigator.pop(context);
Navigator.pop(context);
context.read<CourseBloc>().add(LoadCourses());

        }
        
        if (state is CourseError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Error: ${state.message}'),
              backgroundColor: Colors.red,
              behavior: SnackBarBehavior.floating,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          );
        }
      },
      child: ElevatedButton(
        onPressed: _updateCourse,
        style: ElevatedButton.styleFrom(
          backgroundColor: theme.primaryColor,
          foregroundColor: Colors.white,
          elevation: 2,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: Text(
          'Update Course',
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
  
  Widget _buildScorePreviewSection(ThemeData theme) {
    final titleLength = _titleController.text.length;
    final lessons = int.tryParse(_lessonsController.text) ?? 0;
    final score = titleLength * lessons;
    
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.blue.withOpacity(0.05),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Colors.blue.withOpacity(0.1),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  Icons.calculate,
                  size: 20,
                  color: Colors.white,
                ),
              ),
              const SizedBox(width: 12),
              Text(
                'Updated Score Preview',
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: Colors.blue.shade800,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            'Score = (Title Length) × (Number of Lessons)',
            style: theme.textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: theme.cardColor,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildScoreDetailItem(
                      theme,
                      'Title Length',
                      '$titleLength characters',
                      Colors.blue,
                    ),
                    Text(
                      '×',
                      style: theme.textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                    _buildScoreDetailItem(
                      theme,
                      'Lessons',
                      lessons > 0 ? '$lessons' : 'Enter value',
                      Colors.green,
                    ),
                    Text(
                      '=',
                      style: theme.textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                    _buildScoreDetailItem(
                      theme,
                      'New Score',
                      score > 0 ? '$score' : 'Calculate',
                      Colors.orange,
                      isBold: true,
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                if (score > 0)
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.orange.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.info_outline,
                          size: 16,
                          color: Colors.orange,
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            'New score will be updated automatically',
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: Colors.orange.shade700,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildScoreDetailItem(
    ThemeData theme,
    String label,
    String value,
    Color color, {
    bool isBold = false,
  }) {
    return Column(
      children: [
        Text(
          label,
          style: theme.textTheme.bodySmall?.copyWith(
            color: theme.colorScheme.onSurface.withOpacity(0.6),
          ),
        ),
        const SizedBox(height: 4),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            value,
            style: theme.textTheme.bodyLarge?.copyWith(
              fontWeight: isBold ? FontWeight.w300 : FontWeight.w400,
              color: color,
            ),
          ),
        ),
      ],
    );
  }
  
  void _updateCourse() {
    if (_formKey.currentState!.validate() && _selectedCategory != null) {
      final course = widget.course.copyWith(
        title: _titleController.text,
        description: _descriptionController.text,
        category: _selectedCategory!,
        lessons: int.parse(_lessonsController.text),
        score: _titleController.text.length * int.parse(_lessonsController.text),
        updatedAt: DateTime.now(),
      );
      
      context.read<CourseBloc>().add(UpdateCourseEvent(course));
    }
  }
  
  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _lessonsController.dispose();
    super.dispose();
  }
}