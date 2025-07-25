# language: es
Funcionalidad: Reproductor de Video en Cursos
  Como usuario de Platzi Flix
  Quiero poder ver videos de las clases
  Para aprender el contenido del curso

  Contexto:
    Dado que estoy en la página principal de Platzi Flix
    Y que el servidor de desarrollo está ejecutándose en localhost:3000
    Y que el API backend está disponible en localhost:8000

  Esquema del Scenario: Navegación al curso y verificación del reproductor
    Dado que navego a la página principal
    Cuando hago clic en el curso "<nombre_curso>"
    Y hago clic en la primera lección "<nombre_leccion>"
    Entonces debería ver el reproductor de video
    Y el reproductor debería estar cargando el video de YouTube
    Y debería poder ver el título de la lección "<titulo_leccion>"

    Ejemplos:
      | nombre_curso    | nombre_leccion        | titulo_leccion        |
      | Curso de React  | Introducción a React  | Introducción a React  |
      | Curso de Python | Fundamentos de Python | Fundamentos de Python |

  Scenario: Verificación del reproductor de video funcional
    Dado que estoy en la página de la lección "Introducción a React"
    Cuando el video termina de cargar
    Entonces debería ver el iframe de YouTube embebido
    Y el reproductor debería tener controles de reproducción
    Y debería poder hacer clic en el botón de pantalla completa
    Y el video debería tener la URL "https://www.youtube.com/watch?v=dQw4w9WgXcQ"

  Scenario: Manejo de errores en el reproductor
    Dado que estoy en la página de una lección con URL de video inválida
    Cuando intento cargar el reproductor
    Entonces debería ver un mensaje de error
    Y el mensaje debería indicar "No se pudo cargar el video"
    Y debería mostrar la URL inválida

  Scenario: Estados de carga del reproductor
    Dado que estoy en la página de una lección válida
    Cuando el reproductor está cargando
    Entonces debería ver un overlay de carga
    Y debería ver un spinner de carga
    Y debería ver el texto "Cargando video..."
    Cuando el video termina de cargar
    Entonces el overlay de carga debería desaparecer
    Y el iframe del video debería ser visible

  Scenario: Navegación de regreso al curso
    Dado que estoy en la página de una lección
    Cuando hago clic en el botón "Volver al curso"
    Entonces debería regresar a la página del curso
    Y debería ver la lista de lecciones disponibles 