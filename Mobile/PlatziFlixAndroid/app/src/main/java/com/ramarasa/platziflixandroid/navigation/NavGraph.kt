package com.ramarasa.platziflixandroid.navigation

import androidx.compose.runtime.Composable
import androidx.lifecycle.viewmodel.compose.viewModel
import androidx.navigation.NavHostController
import androidx.navigation.NavType
import androidx.navigation.compose.NavHost
import androidx.navigation.compose.composable
import androidx.navigation.navArgument
import com.ramarasa.platziflixandroid.di.NetworkModule
import com.ramarasa.platziflixandroid.domain.models.Lecture
import com.ramarasa.platziflixandroid.presentation.screens.CourseDetailScreen
import com.ramarasa.platziflixandroid.presentation.screens.CourseListScreen
import com.ramarasa.platziflixandroid.presentation.viewmodels.CourseDetailViewModel
import com.ramarasa.platziflixandroid.presentation.viewmodels.CourseDetailViewModelFactory
import com.ramarasa.platziflixandroid.presentation.viewmodels.CourseListViewModel
import com.ramarasa.platziflixandroid.presentation.viewmodels.CourseListViewModelFactory

/**
 * Navigation graph for the application.
 * Defines all navigation destinations and their connections.
 */
@Composable
fun NavGraph(
    navController: NavHostController,
    startDestination: String = NavRoutes.COURSE_LIST
) {
    NavHost(
        navController = navController,
        startDestination = startDestination
    ) {
        // Course List Screen
        composable(NavRoutes.COURSE_LIST) {
            val viewModel: CourseListViewModel = viewModel(
                factory = CourseListViewModelFactory(NetworkModule.courseRepository)
            )
            CourseListScreen(
                viewModel = viewModel,
                onCourseClick = { course ->
                    navController.navigate(NavRoutes.courseDetail(course.slug))
                }
            )
        }
        
        // Course Detail Screen
        composable(
            route = NavRoutes.COURSE_DETAIL,
            arguments = listOf(
                navArgument("slug") {
                    type = NavType.StringType
                }
            )
        ) { backStackEntry ->
            val slug = backStackEntry.arguments?.getString("slug") ?: ""
            val viewModel: CourseDetailViewModel = viewModel(
                factory = CourseDetailViewModelFactory(NetworkModule.courseDetailRepository)
            )
            
            // Load course detail when the screen is created
            viewModel.loadCourseDetail(slug)
            
            CourseDetailScreen(
                viewModel = viewModel,
                onBackClick = {
                    navController.popBackStack()
                },
                onLectureClick = { lecture ->
                    // Handle lecture click - for now just log it
                    println("Lecture clicked: ${lecture.name}")
                }
            )
        }
    }
} 