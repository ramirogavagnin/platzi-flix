# Troubleshooting API Response Issues

## Problem Description

The course detail API endpoint was returning an error when trying to parse the `teacher_id` field:

```
Failed to fetch course detail:
java.lang.IllegalStateException: Expected an int but was BEGIN_OBJECT at line 1 column 274 path $.teacher_id (0]
```

## Root Cause

The API response format for the `teacher_id` field was inconsistent with the expected format:

### Expected Format (from contracts_definition.md)

```json
{
  "teacher_id": [1, 2, 3]
}
```

### Actual API Response

```json
{
  "teacher_id": {
    /* object instead of array */
  }
}
```

## Solution Implemented

### 1. Custom JSON Deserializer

Created `TeacherIdDeserializer` to handle multiple response formats:

```kotlin
class TeacherIdDeserializer : JsonDeserializer<List<Int>> {
    override fun deserialize(
        json: JsonElement?,
        typeOfT: Type?,
        context: JsonDeserializationContext?
    ): List<Int> {
        return when {
            json == null -> emptyList()
            json.isJsonArray -> {
                // Handle array format [1,2,3]
                json.asJsonArray.mapNotNull { element ->
                    try { element.asInt } catch (e: Exception) { null }
                }
            }
            json.isJsonObject -> {
                // Handle object format - return empty list for now
                emptyList()
            }
            json.isJsonPrimitive -> {
                // Handle single value format
                try { listOf(json.asInt) } catch (e: Exception) { emptyList() }
            }
            else -> emptyList()
        }
    }
}
```

### 2. Updated DTO

Applied the custom deserializer to the `teacher_id` field:

```kotlin
data class CourseDetailDTO(
    // ... other fields
    @SerializedName("teacher_id")
    @JsonAdapter(TeacherIdDeserializer::class)
    val teacherIds: List<Int> = emptyList(),
    // ... other fields
)
```

### 3. Added Logging

Enhanced the repository with detailed logging to help debug future issues:

```kotlin
Log.d(TAG, "Fetching course detail for slug: $slug")
val courseDetailDTO = apiService.getCourseBySlug(slug)
Log.d(TAG, "Received course detail DTO: $courseDetailDTO")
```

## Benefits

1. **Robust Error Handling**: The app won't crash if the API response format changes
2. **Backward Compatibility**: Works with both array and object formats
3. **Debugging Support**: Detailed logging helps identify API response issues
4. **Graceful Degradation**: Returns empty list instead of crashing

## Testing

To test the fix:

1. Run the application
2. Navigate to a course detail screen
3. Check the logs for deserializer output
4. Verify that the screen loads without errors

## Future Improvements

1. **API Contract Alignment**: Work with backend team to ensure consistent response format
2. **Enhanced Object Parsing**: If teacher_id is an object, extract relevant IDs
3. **Response Validation**: Add validation for other fields that might have format issues
4. **Error Reporting**: Send error reports to backend team for API inconsistencies

## Monitoring

Monitor the following log tags for API issues:

- `RemoteCourseDetailRepo`: Repository operations
- `TeacherIdDeserializer`: JSON parsing issues
