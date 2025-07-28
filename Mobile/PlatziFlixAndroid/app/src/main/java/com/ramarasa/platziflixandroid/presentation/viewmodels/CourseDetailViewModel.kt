package com.ramarasa.platziflixandroid.presentation.viewmodels

import androidx.lifecycle.ViewModel
import androidx.lifecycle.viewModelScope
import com.ramarasa.platziflixandroid.domain.models.CourseDetail
import com.ramarasa.platziflixandroid.domain.repositories.CourseDetailRepository
import kotlinx.coroutines.flow.MutableStateFlow
import kotlinx.coroutines.flow.StateFlow
import kotlinx.coroutines.flow.asStateFlow
import kotlinx.coroutines.launch

/**
 * ViewModel for course detail screen.
 * Manages the state and business logic for displaying course details.
 */
class CourseDetailViewModel(
    private val repository: CourseDetailRepository
) : ViewModel() {
    
    private val _uiState = MutableStateFlow(CourseDetailUiState())
    val uiState: StateFlow<CourseDetailUiState> = _uiState.asStateFlow()
    
    /**
     * Loads course detail by slug.
     * 
     * @param slug The course slug identifier
     */
    fun loadCourseDetail(slug: String) {
        viewModelScope.launch {
            _uiState.value = _uiState.value.copy(isLoading = true, error = null)
            
            try {
                val courseDetail = repository.getCourseBySlug(slug)
                _uiState.value = _uiState.value.copy(
                    isLoading = false,
                    courseDetail = courseDetail,
                    error = null
                )
            } catch (exception: Exception) {
                _uiState.value = _uiState.value.copy(
                    isLoading = false,
                    error = exception.message ?: "Unknown error occurred"
                )
            }
        }
    }
    
    /**
     * Retries loading the course detail.
     * 
     * @param slug The course slug identifier
     */
    fun retry(slug: String) {
        loadCourseDetail(slug)
    }
}

/**
 * UI state for course detail screen.
 * Represents all possible states of the course detail UI.
 */
data class CourseDetailUiState(
    val isLoading: Boolean = false,
    val courseDetail: CourseDetail? = null,
    val error: String? = null
) 