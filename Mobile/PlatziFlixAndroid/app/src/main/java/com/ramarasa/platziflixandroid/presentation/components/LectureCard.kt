package com.ramarasa.platziflixandroid.presentation.components

import androidx.compose.foundation.layout.*
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.material.icons.Icons
import androidx.compose.material.icons.filled.PlayArrow
import androidx.compose.material3.*
import androidx.compose.runtime.Composable
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.text.style.TextOverflow
import androidx.compose.ui.tooling.preview.Preview
import androidx.compose.ui.unit.dp
import com.ramarasa.platziflixandroid.domain.models.Lecture
import com.ramarasa.platziflixandroid.ui.design.CornerRadius
import com.ramarasa.platziflixandroid.ui.design.Elevation
import com.ramarasa.platziflixandroid.ui.design.Spacing
import com.ramarasa.platziflixandroid.ui.theme.PlatziFlixTheme

/**
 * Lecture card component that displays lecture information.
 * Follows Material Design 3 principles and matches the design reference.
 */
@Composable
fun LectureCard(
    lecture: Lecture,
    onClick: () -> Unit,
    modifier: Modifier = Modifier
) {
    Card(
        onClick = onClick,
        modifier = modifier
            .fillMaxWidth()
            .height(120.dp),
        shape = RoundedCornerShape(CornerRadius.medium),
        elevation = CardDefaults.cardElevation(defaultElevation = Elevation.level1),
        colors = CardDefaults.cardColors(
            containerColor = MaterialTheme.colorScheme.surface
        )
    ) {
        Row(
            modifier = Modifier
                .fillMaxSize()
                .padding(Spacing.medium),
            verticalAlignment = Alignment.CenterVertically
        ) {
            // Play icon
            Icon(
                imageVector = Icons.Default.PlayArrow,
                contentDescription = "Play lecture",
                modifier = Modifier.size(32.dp),
                tint = MaterialTheme.colorScheme.primary
            )
            
            Spacer(modifier = Modifier.width(Spacing.medium))
            
            // Lecture content
            Column(
                modifier = Modifier.weight(1f)
            ) {
                // Lecture title
                Text(
                    text = lecture.name,
                    style = MaterialTheme.typography.titleMedium,
                    color = MaterialTheme.colorScheme.onSurface,
                    maxLines = 1,
                    overflow = TextOverflow.Ellipsis
                )
                
                Spacer(modifier = Modifier.height(Spacing.small))
                
                // Lecture description
                Text(
                    text = lecture.description,
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
fun LectureCardPreview() {
    PlatziFlixTheme {
        LectureCard(
            lecture = Lecture(
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
            onClick = {}
        )
    }
}

@Preview(showBackground = true, uiMode = android.content.res.Configuration.UI_MODE_NIGHT_YES)
@Composable
fun LectureCardDarkPreview() {
    PlatziFlixTheme {
        LectureCard(
            lecture = Lecture(
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
            onClick = {}
        )
    }
} 