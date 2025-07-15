'use client';

import { useEffect, useState } from 'react';
import { CourseResponse, GetCoursesResponse } from '@/types';
import styles from './page.module.scss';

export default function Home() {
  const [courses, setCourses] = useState<CourseResponse[]>([]);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState<string | null>(null);

  useEffect(() => {
    const fetchCourses = async () => {
      try {
        setLoading(true);
        const response = await fetch('http://localhost:8000/courses');

        if (!response.ok) {
          throw new Error(`HTTP error! status: ${response.status}`);
        }

        const data: GetCoursesResponse = await response.json();

        console.log(data);

        if (data?.length) {
          setCourses(data);
        } else {
          throw new Error('Error al obtener los cursos');
        }
      } catch (err) {
        setError(err instanceof Error ? err.message : 'Error desconocido');
      } finally {
        setLoading(false);
      }
    };

    fetchCourses();
  }, []);

  if (loading) {
    return (
      <div className={styles.container}>
        <main className={styles.main}>
          <h1 className={styles.title}>Platzi Flix</h1>
          <div className={styles.loading}>Cargando cursos...</div>
        </main>
      </div>
    );
  }

  if (error) {
    return (
      <div className={styles.container}>
        <main className={styles.main}>
          <h1 className={styles.title}>Platzi Flix</h1>
          <div className={styles.error}>Error: {error}</div>
        </main>
      </div>
    );
  }

  return (
    <div className={styles.container}>
      <main className={styles.main}>
        <h1 className={styles.title}>Platzi Flix</h1>

        <div className={styles.coursesGrid}>
          {courses.map((course) => (
            <div key={course.id} className={styles.courseCard}>
              <div className={styles.cardImage}>
                <img
                  // TODO: Cambiar a la URL's de thumbnail de los cursos en la DB
                  src="https://kinsta.com/es/wp-content/uploads/sites/8/2023/04/react-must-be-in-scope-when-using-jsx-2048x1024.jpg"
                  alt={course.name}
                  className={styles.thumbnail}
                />
              </div>
              <div className={styles.cardContent}>
                <h3 className={styles.courseTitle}>{course.name}</h3>
                <p className={styles.courseDescription}>{course.description}</p>
                <div className={styles.courseSlug}>{course.slug}</div>
              </div>
            </div>
          ))}
        </div>

        {courses.length === 0 && (
          <div className={styles.emptyState}>
            <p>No hay cursos disponibles</p>
          </div>
        )}
      </main>
    </div>
  );
}
