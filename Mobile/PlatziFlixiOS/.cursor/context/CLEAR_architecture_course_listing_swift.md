# Arquitectura CLEAR en Swift/SwiftUI para la feature de listado de cursos

Este documento describe cómo se aplica la arquitectura **CLEAR** en una aplicación móvil desarrollada con **Swift** y **SwiftUI**, que actualmente cuenta con una única funcionalidad: **listar cursos**.

---

## 📁 Estructura del Proyecto

```plaintext
CourseLister/
│
├── Data/
│   ├── Entities/
│   │   └── CourseDTO.swift
│   ├── Mappers/
│   │   └── CourseMapper.swift
│   └── Repositories/
│       └── RemoteCourseRepository.swift
│
├── Domain/
│   ├── Models/
│   │   └── Course.swift
│   └── Repositories/
│       └── CourseRepositoryProtocol.swift (protocolo)
│
├── Presentation/
│   ├── ViewModels/
│   │   └── CourseListViewModel.swift
│   └── Views/
│       └── CourseListView.swift
```
