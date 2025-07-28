package com.ramarasa.platziflixandroid.di

import com.ramarasa.platziflixandroid.data.api.CourseApiService
import com.ramarasa.platziflixandroid.data.repositories.RemoteCourseRepository
import com.ramarasa.platziflixandroid.data.repositories.RemoteCourseDetailRepository
import com.ramarasa.platziflixandroid.domain.repositories.CourseRepository
import com.ramarasa.platziflixandroid.domain.repositories.CourseDetailRepository
import okhttp3.OkHttpClient
import okhttp3.logging.HttpLoggingInterceptor
import retrofit2.Retrofit
import retrofit2.converter.gson.GsonConverterFactory
import java.util.concurrent.TimeUnit

/**
 * Simple dependency injection module for network components.
 * Provides Retrofit, API services, and repositories.
 */
object NetworkModule {
    
    // Usar la configuración centralizada de red
    
    private val okHttpClient = OkHttpClient.Builder()
        .addInterceptor(HttpLoggingInterceptor().apply {
            level = HttpLoggingInterceptor.Level.BODY
        })
        .connectTimeout(30, TimeUnit.SECONDS)
        .readTimeout(30, TimeUnit.SECONDS)
        .writeTimeout(30, TimeUnit.SECONDS)
        .retryOnConnectionFailure(true)
        .build()
    
    private val retrofit = Retrofit.Builder()
        .baseUrl(NetworkConfig.getBaseUrl())
        .client(okHttpClient)
        .addConverterFactory(GsonConverterFactory.create())
        .build()
    
    val courseApiService: CourseApiService = retrofit.create(CourseApiService::class.java)
    
    val courseRepository: CourseRepository = RemoteCourseRepository(courseApiService)
    
    val courseDetailRepository: CourseDetailRepository = RemoteCourseDetailRepository(courseApiService)
} 