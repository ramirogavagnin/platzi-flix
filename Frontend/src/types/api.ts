/**
 * Tipos para las respuestas de la API
 */

import { CourseDetail, CourseResponse } from "./course";
import { LectureResponse } from "./lecture";

// Endpoints de cursos
export type GetCoursesResponse = CourseResponse[];

export type GetCourseResponse = CourseDetail;

// Endpoints de lectures
export type GetLectureResponse = LectureResponse;

// Tipos para parámetros de URL
export interface CourseParams {
  slug: string;
}

export interface LectureParams {
  slug: string;
  id: string;
}

// Tipos para filtros y paginación
export interface PaginationParams {
  page?: number;
  limit?: number;
}

export interface CourseFilters extends PaginationParams {
  search?: string;
  teacher_id?: number;
}

// Tipos para formularios
export interface CourseFormData {
  name: string;
  description: string;
  thumbnail: string;
  slug: string;
  teacher_id: number[];
}

export interface LectureFormData {
  course_id: number;
  name: string;
  description: string;
  slug: string;
  video_url: string;
}

export interface TeacherFormData {
  name: string;
  email: string;
}
