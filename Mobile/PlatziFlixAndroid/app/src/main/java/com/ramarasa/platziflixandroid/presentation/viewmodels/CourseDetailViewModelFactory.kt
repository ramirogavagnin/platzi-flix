package com.ramarasa.platziflixandroid.presentation.viewmodels

import androidx.lifecycle.ViewModel
import androidx.lifecycle.ViewModelProvider
import com.ramarasa.platziflixandroid.domain.repositories.CourseDetailRepository

/**
 * Factory for creating CourseDetailViewModel instances.
 * Provides the necessary dependencies to the ViewModel.
 */
class CourseDetailViewModelFactory(
    private val repository: CourseDetailRepository
) : ViewModelProvider.Factory {
    
    @Suppress("UNCHECKED_CAST")
    override fun <T : ViewModel> create(modelClass: Class<T>): T {
        if (modelClass.isAssignableFrom(CourseDetailViewModel::class.java)) {
            return CourseDetailViewModel(repository) as T
        }
        throw IllegalArgumentException("Unknown ViewModel class")
    }
} 