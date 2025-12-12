# Course Manager

A Flutter mobile application for managing courses with offline support, built using Clean Architecture and BLoC state management.

## Features

-  Course List Screen with search and category filter
-  Add/Edit Course with form validation
-  Delete Course with confirmation dialog
-  Course Details Screen
-  Offline-first architecture (SQLite)
-  Mock API integration for categories
-  Clean Architecture with clear separation of concerns
-  BLoC state management
-  Proper error handling and loading states
-  Responsive UI design

## Architecture

The app follows Clean Architecture with these layers:

### Domain Layer
- Entities (Course, Category)
- Repository interfaces
- Use cases

### Data Layer
- Data sources (Local SQLite, Remote API)
- Repository implementations
- Models

### Presentation Layer
- BLoC for state management
- Pages and Widgets

## Setup Instructions

### Prerequisites
- Flutter SDK (>=3.0.0)
- Dart (>=3.0.0)

### Steps
1. Clone the repository:
   ```bash
   git clone <repository-url>
   cd course_manager