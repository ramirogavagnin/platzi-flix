/**
 * Tipos para la entidad Teacher (Profesor)
 */

export interface Teacher {
  id: number;
  name: string;
  email: string;
  created_at: string;
  updated_at: string;
  deleted_at: string | null;
}

export interface TeacherCreate {
  name: string;
  email: string;
}

export interface TeacherUpdate {
  name?: string;
  email?: string;
}

export interface TeacherResponse {
  id: number;
  name: string;
  email: string;
  created_at: string;
  updated_at: string;
}
