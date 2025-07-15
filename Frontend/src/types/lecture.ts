/**
 * Tipos para la entidad Lecture (Clase)
 */

export interface Lecture {
  id: number;
  course_id: number;
  name: string;
  description: string;
  slug: string;
  video_url: string;
  created_at: string;
  updated_at: string;
  deleted_at: string | null;
}

export interface LectureCreate {
  course_id: number;
  name: string;
  description: string;
  slug: string;
  video_url: string;
}

export interface LectureUpdate {
  name?: string;
  description?: string;
  slug?: string;
  video_url?: string;
}

export interface LectureResponse {
  id: number;
  name: string;
  description: string;
  slug: string;
  video_url: string;
  created_at: string;
  updated_at: string;
}

export interface LectureListItem {
  id: number;
  name: string;
  description: string;
  slug: string;
}
