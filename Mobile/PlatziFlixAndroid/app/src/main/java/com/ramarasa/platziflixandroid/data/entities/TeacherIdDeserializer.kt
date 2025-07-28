package com.ramarasa.platziflixandroid.data.entities

import com.google.gson.*
import java.lang.reflect.Type

/**
 * Custom deserializer for teacher_id field that can handle both array and object formats.
 * This handles cases where the API might return teacher_id as [1,2,3] or as an object.
 */
class TeacherIdDeserializer : JsonDeserializer<List<Int>> {
    
    override fun deserialize(
        json: JsonElement?,
        typeOfT: Type?,
        context: JsonDeserializationContext?
    ): List<Int> {
        return try {
            when {
                json == null -> {
                    println("TeacherIdDeserializer: json is null")
                    emptyList()
                }
                json.isJsonArray -> {
                    println("TeacherIdDeserializer: json is array: ${json.asJsonArray}")
                    val jsonArray = json.asJsonArray
                    jsonArray.mapNotNull { element ->
                        try {
                            element.asInt
                        } catch (e: Exception) {
                            println("TeacherIdDeserializer: failed to parse array element: $element")
                            null
                        }
                    }
                }
                json.isJsonObject -> {
                    println("TeacherIdDeserializer: json is object: ${json.asJsonObject}")
                    // If it's an object, return empty list for now
                    // This handles the case where teacher_id is an object instead of array
                    emptyList()
                }
                json.isJsonPrimitive -> {
                    println("TeacherIdDeserializer: json is primitive: ${json.asJsonPrimitive}")
                    // If it's a single value, try to parse it as an integer
                    try {
                        listOf(json.asInt)
                    } catch (e: Exception) {
                        println("TeacherIdDeserializer: failed to parse primitive: ${json.asJsonPrimitive}")
                        emptyList()
                    }
                }
                else -> {
                    println("TeacherIdDeserializer: unknown json type: $json")
                    emptyList()
                }
            }
        } catch (e: Exception) {
            println("TeacherIdDeserializer: exception occurred: ${e.message}")
            // If any error occurs, return empty list to prevent crashes
            emptyList()
        }
    }
} 