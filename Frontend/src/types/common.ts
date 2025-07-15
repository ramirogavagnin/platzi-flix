/**
 * Tipos comunes y utilidades
 */

import { PaginationParams } from "./api";

// Estados de carga
export type LoadingState = "idle" | "loading" | "success" | "error";

// Estados de formularios
export type FormState = "idle" | "submitting" | "success" | "error";

// Tipos para componentes
export interface BaseComponentProps {
  className?: string;
  children?: React.ReactNode;
}

// Tipos para eventos
export interface FormEvent {
  preventDefault: () => void;
  target: {
    value: string;
    name: string;
  };
}

// Tipos para navegación
export interface NavigationItem {
  id: string;
  label: string;
  href: string;
  icon?: React.ComponentType<{ className?: string }>;
  children?: NavigationItem[];
}

// Tipos para breadcrumbs
export interface BreadcrumbItem {
  label: string;
  href?: string;
  current?: boolean;
}

// Tipos para modales
export interface ModalProps {
  isOpen: boolean;
  onClose: () => void;
  title?: string;
  children: React.ReactNode;
}

// Tipos para notificaciones
export type NotificationType = "success" | "error" | "warning" | "info";

export interface Notification {
  id: string;
  type: NotificationType;
  title: string;
  message: string;
  duration?: number;
}

// Tipos para filtros
export interface FilterOption {
  value: string | number;
  label: string;
  disabled?: boolean;
}

export interface SortOption {
  field: string;
  direction: "asc" | "desc";
  label: string;
}

// Tipos para paginación
export interface PaginationInfo {
  currentPage: number;
  totalPages: number;
  totalItems: number;
  itemsPerPage: number;
  hasNextPage: boolean;
  hasPreviousPage: boolean;
}

// Tipos para búsqueda
export interface SearchParams {
  query: string;
  filters?: Record<string, string | number | boolean>;
  sort?: SortOption;
  pagination?: PaginationParams;
}

// Tipos para archivos
export interface FileUpload {
  file: File;
  preview?: string;
  progress?: number;
  error?: string;
}

// Tipos para validación
export interface ValidationError {
  field: string;
  message: string;
}

export interface ValidationResult {
  isValid: boolean;
  errors: ValidationError[];
}
