package com.ramarasa.platziflixandroid.presentation.components

import androidx.compose.foundation.background
import androidx.compose.foundation.layout.*
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.material3.*
import androidx.compose.runtime.Composable
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.draw.clip
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.layout.ContentScale
import androidx.compose.ui.res.painterResource
import androidx.compose.ui.text.style.TextOverflow
import androidx.compose.ui.tooling.preview.Preview
import androidx.compose.ui.unit.dp
import coil.compose.AsyncImage
import com.ramarasa.platziflixandroid.R
import com.ramarasa.platziflixandroid.domain.models.Course
import com.ramarasa.platziflixandroid.ui.design.CornerRadius
import com.ramarasa.platziflixandroid.ui.design.Elevation
import com.ramarasa.platziflixandroid.ui.design.Spacing
import com.ramarasa.platziflixandroid.ui.theme.PlatziFlixTheme

/**
 * Course card component that displays course information.
 * Follows Material Design 3 principles and matches the design reference.
 */
@Composable
fun CourseCard(
    course: Course,
    onClick: () -> Unit,
    modifier: Modifier = Modifier
) {
    Card(
        onClick = onClick,
        modifier = modifier
            .fillMaxWidth()
            .height(280.dp),
        shape = RoundedCornerShape(CornerRadius.medium),
        elevation = CardDefaults.cardElevation(defaultElevation = Elevation.level2),
        colors = CardDefaults.cardColors(
            containerColor = MaterialTheme.colorScheme.surface
        )
    ) {
        Column(
            modifier = Modifier.fillMaxSize()
        ) {
            // Image section (60% of card height)
            Box(
                modifier = Modifier
                    .fillMaxWidth()
                    .weight(0.6f)
                    .background(MaterialTheme.colorScheme.surfaceVariant),
                contentAlignment = Alignment.Center
            ) {
                if (course.thumbnail.isNotEmpty()) {
                    AsyncImage(
                        model = course.thumbnail,
                        contentDescription = "Course thumbnail for ${course.name}",
                        modifier = Modifier.fillMaxSize(),
                        contentScale = ContentScale.Crop
                    )
                } else {
                    // Placeholder icon
                    Icon(
                        painter = painterResource(id = R.drawable.ic_launcher_foreground),
                        contentDescription = "Course placeholder",
                        modifier = Modifier.size(48.dp),
                        tint = MaterialTheme.colorScheme.onSurfaceVariant
                    )
                }
            }
            
            // Text content section (40% of card height)
            Column(
                modifier = Modifier
                    .fillMaxWidth()
                    .weight(0.4f)
                    .padding(Spacing.medium)
            ) {
                // Course title
                Text(
                    text = course.name,
                    style = MaterialTheme.typography.titleMedium,
                    color = MaterialTheme.colorScheme.onSurface,
                    maxLines = 1,
                    overflow = TextOverflow.Ellipsis
                )
                
                Spacer(modifier = Modifier.height(Spacing.small))
                
                // Course description
                Text(
                    text = course.description,
                    style = MaterialTheme.typography.bodyMedium,
                    color = MaterialTheme.colorScheme.onSurfaceVariant,
                    maxLines = 2,
                    overflow = TextOverflow.Ellipsis
                )
            }
        }
    }
}

@Preview(showBackground = true)
@Composable
fun CourseCardPreview() {
    PlatziFlixTheme {
        CourseCard(
            course = Course(
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
            onClick = {}
        )
    }
}

@Preview(showBackground = true, uiMode = android.content.res.Configuration.UI_MODE_NIGHT_YES)
@Composable
fun CourseCardDarkPreview() {
    PlatziFlixTheme {
        CourseCard(
            course = Course(
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
            onClick = {}
        )
    }
} 