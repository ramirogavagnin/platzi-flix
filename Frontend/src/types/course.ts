/**
 * Tipos para la entidad Course (Curso)
 */

export interface Course {
  id: number;
  name: string;
  description: string;
  thumbnail: string;
  slug: string;
  created_at: string;
  updated_at: string;
  deleted_at: string | null;
  teacher_id: number[];
}

export interface CourseCreate {
  name: string;
  description: string;
  thumbnail: string;
  slug: string;
  teacher_id: number[];
}

export interface CourseUpdate {
  name?: string;
  description?: string;
  thumbnail?: string;
  slug?: string;
  teacher_id?: number[];
}

export interface CourseResponse {
  id: number;
  name: string;
  description: string;
  thumbnail: string;
  slug: string;
}

export interface CourseDetail extends CourseResponse {
  teacher_id: number[];
  lectures: LectureListItem[];
}

// Import para evitar dependencias circulares
import { LectureListItem } from "./lecture";
