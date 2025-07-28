package com.ramarasa.platziflixandroid.presentation.viewmodels

import androidx.lifecycle.ViewModel
import androidx.lifecycle.ViewModelProvider
import androidx.lifecycle.viewModelScope
import com.ramarasa.platziflixandroid.domain.models.Course
import com.ramarasa.platziflixandroid.domain.repositories.CourseRepository
import kotlinx.coroutines.flow.MutableStateFlow
import kotlinx.coroutines.flow.StateFlow
import kotlinx.coroutines.flow.asStateFlow
import kotlinx.coroutines.launch

/**
 * UI State for the course list screen.
 * Represents all possible states the UI can be in.
 */
data class CourseListUiState(
    val isLoading: Boolean = false,
    val courses: List<Course> = emptyList(),
    val error: String? = null
)

/**
 * ViewModel for the course list screen.
 * Manages the UI state and business logic following MVVM pattern.
 */
class CourseListViewModel(
    private val courseRepository: CourseRepository
) : ViewModel() {
    
    private val _uiState = MutableStateFlow(CourseListUiState())
    val uiState: StateFlow<CourseListUiState> = _uiState.asStateFlow()
    
    init {
        loadCourses()
    }
    
    /**
     * Loads the list of courses from the repository.
     */
    fun loadCourses() {
        viewModelScope.launch {
            _uiState.value = _uiState.value.copy(isLoading = true, error = null)
            
            courseRepository.getCourses().collect { result ->
                result.fold(
                    onSuccess = { courses ->
                        _uiState.value = _uiState.value.copy(
                            isLoading = false,
                            courses = courses,
                            error = null
                        )
                    },
                    onFailure = { exception ->
                        _uiState.value = _uiState.value.copy(
                            isLoading = false,
                            error = exception.message ?: "Unknown error occurred"
                        )
                    }
                )
            }
        }
    }
    
    /**
     * Retries loading courses after an error.
     */
    fun retry() {
        loadCourses()
    }
}

/**
 * Factory for creating CourseListViewModel with dependencies.
 */
class CourseListViewModelFactory(
    private val courseRepository: CourseRepository
) : ViewModelProvider.Factory {
    
    @Suppress("UNCHECKED_CAST")
    override fun <T : ViewModel> create(modelClass: Class<T>): T {
        if (modelClass.isAssignableFrom(CourseListViewModel::class.java)) {
            return CourseListViewModel(courseRepository) as T
        }
        throw IllegalArgumentException("Unknown ViewModel class")
    }
} 