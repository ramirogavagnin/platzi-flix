package com.ramarasa.platziflixandroid

import android.os.Bundle
import androidx.activity.ComponentActivity
import androidx.activity.compose.setContent
import androidx.activity.viewModels
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.Surface
import androidx.compose.ui.Modifier
import com.ramarasa.platziflixandroid.di.NetworkModule
import com.ramarasa.platziflixandroid.domain.models.Course
import com.ramarasa.platziflixandroid.presentation.screens.CourseListScreen
import com.ramarasa.platziflixandroid.presentation.viewmodels.CourseListViewModel
import com.ramarasa.platziflixandroid.presentation.viewmodels.CourseListViewModelFactory
import com.ramarasa.platziflixandroid.ui.theme.PlatziFlixTheme

class MainActivity : ComponentActivity() {
    
    private val viewModel: CourseListViewModel by viewModels {
        CourseListViewModelFactory(NetworkModule.courseRepository)
    }
    
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContent {
            PlatziFlixTheme {
                Surface(
                    modifier = Modifier.fillMaxSize(),
                    color = MaterialTheme.colorScheme.background
                ) {
                    CourseListScreen(
                        viewModel = viewModel,
                        onCourseClick = { course ->
                            // Handle course click - navigate to course details
                            // For now, just log the course
                            println("Course clicked: ${course.name}")
                        }
                    )
                }
            }
        }
    }
}