# Course Detail Feature

## Overview

This feature implements the course detail screen that displays comprehensive information about a specific course, including its lectures. The implementation follows the CLEAR architecture principles and Material Design 3 guidelines.

## Features

### Course Detail Screen

- **Course Information**: Displays course name, description, and thumbnail
- **Lectures List**: Shows all lectures associated with the course
- **Navigation**: Seamless navigation from course list to detail view
- **Error Handling**: Proper error states with retry functionality
- **Loading States**: Loading indicators during data fetching

### Lecture Cards

- **Lecture Information**: Displays lecture name and description
- **Play Icon**: Visual indicator for video content
- **Interactive**: Clickable cards for future video player integration

## Architecture

### Domain Layer

- `CourseDetail`: Domain model representing a course with its lectures
- `Lecture`: Domain model representing individual lectures
- `CourseDetailRepository`: Interface for course detail data operations

### Data Layer

- `CourseDetailDTO`: Data transfer object for API responses
- `LectureDTO`: Data transfer object for lecture API responses
- `CourseDetailMapper`: Mapper for DTO to domain model conversion
- `LectureMapper`: Mapper for lecture DTO to domain model conversion
- `RemoteCourseDetailRepository`: Implementation of course detail repository

### Presentation Layer

- `CourseDetailScreen`: Main screen for displaying course details
- `CourseDetailViewModel`: ViewModel managing course detail state
- `LectureCard`: Reusable component for displaying lectures
- `CourseDetailUiState`: UI state representation

### Navigation

- `NavRoutes`: Navigation route definitions
- `NavGraph`: Navigation graph configuration
- Integration with Compose Navigation

## API Integration

### Endpoints

- `GET /courses/{slug}`: Retrieves course detail with lectures

### Response Format

```json
{
  "id": 1,
  "name": "Curso de React",
  "description": "Curso de React",
  "thumbnail": "https://via.placeholder.com/150",
  "slug": "curso-de-react",
  "teacher_id": [1, 2, 3],
  "classes": [
    {
      "id": 1,
      "name": "Clase 1",
      "description": "Clase 1",
      "slug": "clase-1"
    }
  ]
}
```

## Usage

### Navigation

To navigate to the course detail screen:

```kotlin
// From CourseListScreen
onCourseClick = { course ->
    navController.navigate(NavRoutes.courseDetail(course.slug))
}
```

### ViewModel Usage

```kotlin
val viewModel: CourseDetailViewModel = viewModel(
    factory = CourseDetailViewModelFactory(repository)
)

// Load course detail
viewModel.loadCourseDetail(slug)

// Observe UI state
val uiState by viewModel.uiState.collectAsState()
```

## UI Components

### CourseDetailScreen

- **Scaffold**: Material 3 scaffold with top app bar
- **TopAppBar**: Navigation back button and title
- **LazyColumn**: Scrollable content with course header and lectures list
- **Error Handling**: Error state with retry button
- **Loading State**: Circular progress indicator

### LectureCard

- **Card Design**: Material 3 card with elevation
- **Layout**: Row layout with play icon and text content
- **Typography**: Proper text hierarchy with title and description
- **Interactive**: Clickable with ripple effect

## Design System Integration

The feature uses the established design system:

- **Colors**: Material 3 color scheme
- **Typography**: Material 3 typography scale
- **Spacing**: Consistent spacing using `Spacing` constants
- **Elevation**: Proper elevation levels using `Elevation` constants
- **Corner Radius**: Consistent corner radius using `CornerRadius` constants

## Testing

### Preview Components

- `CourseDetailScreenPreview`: Preview for course detail screen
- `LectureCardPreview`: Preview for lecture card component
- Dark mode support for all previews

### Unit Tests

- Repository tests for data layer
- ViewModel tests for business logic
- Mapper tests for data transformations

## Future Enhancements

1. **Video Player Integration**: Implement video playback for lectures
2. **Offline Support**: Cache course details for offline viewing
3. **Progress Tracking**: Track user progress through lectures
4. **Bookmarking**: Allow users to bookmark lectures
5. **Search**: Add search functionality within course content
6. **Comments**: Add commenting system for lectures

## Dependencies

- **Navigation**: `androidx.navigation.compose`
- **ViewModel**: `androidx.lifecycle.viewmodel.compose`
- **Image Loading**: `coil-compose`
- **Networking**: Retrofit, OkHttp
- **UI**: Material 3, Compose UI

## File Structure

```
app/src/main/java/com/ramarasa/platziflixandroid/
├── data/
│   ├── api/
│   │   └── CourseApiService.kt (updated)
│   ├── entities/
│   │   ├── CourseDetailDTO.kt
│   │   └── LectureDTO.kt
│   ├── mappers/
│   │   ├── CourseDetailMapper.kt
│   │   └── LectureMapper.kt
│   └── repositories/
│       └── RemoteCourseDetailRepository.kt
├── domain/
│   ├── models/
│   │   ├── CourseDetail.kt
│   │   └── Lecture.kt
│   └── repositories/
│       └── CourseDetailRepository.kt
├── presentation/
│   ├── components/
│   │   └── LectureCard.kt
│   ├── screens/
│   │   └── CourseDetailScreen.kt
│   └── viewmodels/
│       ├── CourseDetailViewModel.kt
│       └── CourseDetailViewModelFactory.kt
├── navigation/
│   ├── NavRoutes.kt
│   └── NavGraph.kt
└── di/
    └── NetworkModule.kt (updated)
```
