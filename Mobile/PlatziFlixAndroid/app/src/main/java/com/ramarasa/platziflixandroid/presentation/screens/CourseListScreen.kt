package com.ramarasa.platziflixandroid.presentation.screens

import androidx.compose.foundation.layout.*
import androidx.compose.foundation.lazy.LazyColumn
import androidx.compose.foundation.lazy.items
import androidx.compose.material3.*
import androidx.compose.runtime.Composable
import androidx.compose.runtime.collectAsState
import androidx.compose.runtime.getValue
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.res.stringResource
import androidx.compose.ui.text.style.TextAlign
import androidx.compose.ui.tooling.preview.Preview
import androidx.compose.ui.unit.dp
import com.ramarasa.platziflixandroid.R
import com.ramarasa.platziflixandroid.domain.models.Course
import com.ramarasa.platziflixandroid.presentation.components.CourseCard
import com.ramarasa.platziflixandroid.presentation.viewmodels.CourseListUiState
import com.ramarasa.platziflixandroid.presentation.viewmodels.CourseListViewModel
import com.ramarasa.platziflixandroid.ui.design.Spacing
import com.ramarasa.platziflixandroid.ui.theme.PlatziFlixTheme

/**
 * Screen that displays a list of courses.
 * Follows Material Design 3 principles and matches the design reference.
 */
@Composable
fun CourseListScreen(
    viewModel: CourseListViewModel,
    onCourseClick: (Course) -> Unit,
    modifier: Modifier = Modifier
) {
    val uiState by viewModel.uiState.collectAsState()
    
    CourseListContent(
        uiState = uiState,
        onCourseClick = onCourseClick,
        onRetry = viewModel::retry,
        modifier = modifier
    )
}

@Composable
private fun CourseListContent(
    uiState: CourseListUiState,
    onCourseClick: (Course) -> Unit,
    onRetry: () -> Unit,
    modifier: Modifier = Modifier
) {
    Column(
        modifier = modifier.fillMaxSize()
    ) {
        // Header
        Text(
            text = stringResource(R.string.latest_courses_title),
            style = MaterialTheme.typography.headlineMedium,
            color = MaterialTheme.colorScheme.onSurface,
            modifier = Modifier.padding(
                horizontal = Spacing.medium,
                vertical = Spacing.large
            )
        )
        
        // Content
        when {
            uiState.isLoading -> {
                Box(
                    modifier = Modifier.fillMaxSize(),
                    contentAlignment = Alignment.Center
                ) {
                    CircularProgressIndicator()
                }
            }
            
            uiState.error != null -> {
                ErrorContent(
                    error = uiState.error,
                    onRetry = onRetry
                )
            }
            
            uiState.courses.isEmpty() -> {
                EmptyContent()
            }
            
            else -> {
                CourseList(
                    courses = uiState.courses,
                    onCourseClick = onCourseClick
                )
            }
        }
    }
}

@Composable
private fun CourseList(
    courses: List<Course>,
    onCourseClick: (Course) -> Unit,
    modifier: Modifier = Modifier
) {
    LazyColumn(
        modifier = modifier.fillMaxSize(),
        contentPadding = PaddingValues(
            horizontal = Spacing.medium,
            vertical = Spacing.small
        ),
        verticalArrangement = Arrangement.spacedBy(Spacing.medium)
    ) {
        items(
            items = courses,
            key = { it.id }
        ) { course ->
            CourseCard(
                course = course,
                onClick = { onCourseClick(course) }
            )
        }
    }
}

@Composable
private fun ErrorContent(
    error: String,
    onRetry: () -> Unit,
    modifier: Modifier = Modifier
) {
    Column(
        modifier = modifier.fillMaxSize(),
        horizontalAlignment = Alignment.CenterHorizontally,
        verticalArrangement = Arrangement.Center
    ) {
        Text(
            text = error,
            style = MaterialTheme.typography.bodyLarge,
            color = MaterialTheme.colorScheme.error,
            textAlign = TextAlign.Center,
            modifier = Modifier.padding(Spacing.medium)
        )
        
        Spacer(modifier = Modifier.height(Spacing.medium))
        
        Button(onClick = onRetry) {
            Text(text = stringResource(R.string.retry))
        }
    }
}

@Composable
private fun EmptyContent(
    modifier: Modifier = Modifier
) {
    Column(
        modifier = modifier.fillMaxSize(),
        horizontalAlignment = Alignment.CenterHorizontally,
        verticalArrangement = Arrangement.Center
    ) {
        Text(
            text = stringResource(R.string.no_courses_available),
            style = MaterialTheme.typography.bodyLarge,
            color = MaterialTheme.colorScheme.onSurfaceVariant,
            textAlign = TextAlign.Center,
            modifier = Modifier.padding(Spacing.medium)
        )
    }
}

@Preview(showBackground = true)
@Composable
fun CourseListScreenPreview() {
    PlatziFlixTheme {
        CourseListContent(
            uiState = CourseListUiState(
                courses = listOf(
                    Course(
                        id = 1,
                        name = "Curso de Cursor",
                        description = "Cursor es un entorno de desarrollo integrado impulsado por IA para Windows, macOS y Linux que te ayuda a escribir código más rápido y mejor.",
                        thumbnail = "",
                        slug = "curso-de-cursor",
                        createdAt = "2021-01-01",
                        updatedAt = "2021-01-01",
                        deletedAt = null,
                        teacherIds = listOf(1, 2, 3)
                    ),
                    Course(
                        id = 2,
                        name = "Curso de React",
                        description = "Aprende React desde cero con este curso completo que cubre todos los conceptos fundamentales.",
                        thumbnail = "",
                        slug = "curso-de-react",
                        createdAt = "2021-01-01",
                        updatedAt = "2021-01-01",
                        deletedAt = null,
                        teacherIds = listOf(1)
                    )
                )
            ),
            onCourseClick = {},
            onRetry = {}
        )
    }
} 