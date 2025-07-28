package com.ramarasa.platziflixandroid.presentation.screens

import androidx.compose.foundation.layout.*
import androidx.compose.foundation.lazy.LazyColumn
import androidx.compose.foundation.lazy.items
import androidx.compose.material.icons.Icons
import androidx.compose.material.icons.automirrored.filled.ArrowBack
import androidx.compose.material3.*
import androidx.compose.runtime.Composable
import androidx.compose.runtime.collectAsState
import androidx.compose.runtime.getValue
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.layout.ContentScale
import androidx.compose.ui.res.stringResource
import androidx.compose.ui.text.style.TextAlign
import androidx.compose.ui.tooling.preview.Preview
import androidx.compose.ui.unit.dp
import coil.compose.AsyncImage
import com.ramarasa.platziflixandroid.R
import com.ramarasa.platziflixandroid.domain.models.CourseDetail
import com.ramarasa.platziflixandroid.domain.models.Lecture
import com.ramarasa.platziflixandroid.presentation.components.LectureCard
import com.ramarasa.platziflixandroid.presentation.viewmodels.CourseDetailUiState
import com.ramarasa.platziflixandroid.presentation.viewmodels.CourseDetailViewModel
import com.ramarasa.platziflixandroid.ui.design.Spacing
import com.ramarasa.platziflixandroid.ui.theme.PlatziFlixTheme

/**
 * Screen that displays course details and lectures.
 * Follows Material Design 3 principles and matches the design reference.
 */
@OptIn(ExperimentalMaterial3Api::class)
@Composable
fun CourseDetailScreen(
    viewModel: CourseDetailViewModel,
    onBackClick: () -> Unit,
    onLectureClick: (Lecture) -> Unit,
    modifier: Modifier = Modifier
) {
    val uiState by viewModel.uiState.collectAsState()
    
    Scaffold(
        topBar = {
            TopAppBar(
                title = { Text(text = stringResource(R.string.course_detail_title)) },
                navigationIcon = {
                    IconButton(onClick = onBackClick) {
                        Icon(
                            imageVector = Icons.AutoMirrored.Filled.ArrowBack,
                            contentDescription = "Back"
                        )
                    }
                }
            )
        }
    ) { paddingValues ->
        CourseDetailContent(
            uiState = uiState,
            onLectureClick = onLectureClick,
            onRetry = { viewModel.retry("") },
            modifier = modifier.padding(paddingValues)
        )
    }
}

@Composable
private fun CourseDetailContent(
    uiState: CourseDetailUiState,
    onLectureClick: (Lecture) -> Unit,
    onRetry: () -> Unit,
    modifier: Modifier = Modifier
) {
    when {
        uiState.isLoading -> {
            Box(
                modifier = modifier.fillMaxSize(),
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
        
        uiState.courseDetail != null -> {
            CourseDetailContent(
                courseDetail = uiState.courseDetail,
                onLectureClick = onLectureClick,
                modifier = modifier
            )
        }
    }
}

@Composable
private fun CourseDetailContent(
    courseDetail: CourseDetail,
    onLectureClick: (Lecture) -> Unit,
    modifier: Modifier = Modifier
) {
    LazyColumn(
        modifier = modifier.fillMaxSize(),
        contentPadding = PaddingValues(Spacing.medium)
    ) {
        // Course header
        item {
            CourseHeader(courseDetail = courseDetail)
        }
        
        // Lectures section
        item {
            Spacer(modifier = Modifier.height(Spacing.large))
            Text(
                text = stringResource(R.string.lectures_title),
                style = MaterialTheme.typography.headlineSmall,
                color = MaterialTheme.colorScheme.onSurface,
                modifier = Modifier.padding(bottom = Spacing.medium)
            )
        }
        
        // Lectures list
        items(
            items = courseDetail.lectures,
            key = { it.id }
        ) { lecture ->
            LectureCard(
                lecture = lecture,
                onClick = { onLectureClick(lecture) },
                modifier = Modifier.padding(bottom = Spacing.medium)
            )
        }
    }
}

@Composable
private fun CourseHeader(
    courseDetail: CourseDetail,
    modifier: Modifier = Modifier
) {
    Column(modifier = modifier) {
        // Course thumbnail
        if (courseDetail.thumbnail.isNotEmpty()) {
            AsyncImage(
                model = courseDetail.thumbnail,
                contentDescription = "Course thumbnail for ${courseDetail.name}",
                modifier = Modifier
                    .fillMaxWidth()
                    .height(200.dp),
                contentScale = ContentScale.Crop
            )
        }
        
        Spacer(modifier = Modifier.height(Spacing.medium))
        
        // Course title
        Text(
            text = courseDetail.name,
            style = MaterialTheme.typography.headlineMedium,
            color = MaterialTheme.colorScheme.onSurface
        )
        
        Spacer(modifier = Modifier.height(Spacing.small))
        
        // Course description
        Text(
            text = courseDetail.description,
            style = MaterialTheme.typography.bodyLarge,
            color = MaterialTheme.colorScheme.onSurfaceVariant
        )
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

@Preview(showBackground = true)
@Composable
fun CourseDetailScreenPreview() {
    PlatziFlixTheme {
        CourseDetailContent(
            courseDetail = CourseDetail(
                id = 1,
                name = "Curso de Cursor",
                description = "Cursor es un entorno de desarrollo integrado impulsado por IA para Windows, macOS y Linux que te ayuda a escribir código más rápido y mejor.",
                thumbnail = "",
                slug = "curso-de-cursor",
                teacherIds = listOf(1, 2, 3),
                lectures = listOf(
                    Lecture(
                        id = 1,
                        courseId = 1,
                        name = "Introducción al curso",
                        description = "En esta clase aprenderás los conceptos básicos y fundamentales del curso.",
                        slug = "introduccion-al-curso",
                        videoUrl = "https://www.youtube.com/watch?v=dQw4w9WgXcQ",
                        createdAt = "2021-01-01",
                        updatedAt = "2021-01-01",
                        deletedAt = null
                    ),
                    Lecture(
                        id = 2,
                        courseId = 1,
                        name = "Configuración del entorno",
                        description = "Aprende a configurar tu entorno de desarrollo para trabajar con Cursor.",
                        slug = "configuracion-del-entorno",
                        videoUrl = "https://www.youtube.com/watch?v=dQw4w9WgXcQ",
                        createdAt = "2021-01-01",
                        updatedAt = "2021-01-01",
                        deletedAt = null
                    )
                )
            ),
            onLectureClick = {}
        )
    }
} 