import { CourseDetail } from '@/types/course';
import { Teacher } from '@/types/teacher';
import CourseDetailHeader from '@/components/Course/CourseDetailHeader';
import LessonsList from '@/components/Course/LessonsList';
import styles from './page.module.scss';

interface CoursePageProps {
    params: Promise<{
        slug: string;
    }>;
}

async function getCourseDetails(slug: string): Promise<CourseDetail | null> {
    try {
        const response = await fetch(`http://localhost:8000/courses/${slug}`, {
            cache: 'no-store', // Ensure fresh data for SSR
        });

        if (!response.ok) {
            throw new Error('Failed to fetch course details');
        }

        return await response.json();
    } catch (error) {
        console.error('Error fetching course details:', error);
        return null;
    }
}

async function getTeachers(teacherIds: (number | { id: number })[]): Promise<Teacher[]> {
    try {
        const teachersPromises = teacherIds.map(async (id) => {
            // Handle case where API might return teacher objects instead of IDs
            let teacherId: number;

            if (typeof id === 'object' && id !== null && 'id' in id) {
                teacherId = (id as { id: number }).id;
            } else if (typeof id === 'number') {
                teacherId = id;
            } else {
                console.error('Invalid teacher ID:', id);
                throw new Error(`Invalid teacher ID: ${JSON.stringify(id)}`);
            }

            const response = await fetch(`http://localhost:8000/teachers/${teacherId}`, {
                cache: 'no-store',
            });

            if (!response.ok) {
                throw new Error(`Failed to fetch teacher with ID: ${teacherId}`);
            }

            return await response.json();
        });

        return await Promise.all(teachersPromises);
    } catch (error) {
        console.error('Error fetching teachers:', error);
        return [];
    }
}

export default async function CoursePage({ params }: CoursePageProps) {
    const { slug } = await params;
    const course = await getCourseDetails(slug);

    if (!course) {
        return (
            <div className={styles.errorState}>
                <h1>Curso no encontrado</h1>
                <p>El curso que buscas no existe o ha sido eliminado.</p>
            </div>
        );
    }

    const teachers = course.teacher_id ? await getTeachers(course.teacher_id as (number | { id: number })[]) : [];

    return (
        <>
            <CourseDetailHeader
                course={course}
                teachers={teachers}
            />

            <div className={styles.content}>
                <div className={styles.mainContent}>
                    <section className={styles.description}>
                        <h2>Descripción del curso</h2>
                        <p>{course.description}</p>
                    </section>

                    <LessonsList lessons={course.lectures} courseSlug={course.slug} />
                </div>

                <aside className={styles.sidebar}>
                    <div className={styles.courseInfo}>
                        <h3>Información del curso</h3>
                        <div className={styles.infoItem}>
                            <span className={styles.label}>Clases:</span>
                            <span className={styles.value}>{course.lectures.length}</span>
                        </div>
                        {teachers.length > 0 && (
                            <div className={styles.infoItem}>
                                <span className={styles.label}>Instructores:</span>
                                <div className={styles.teachers}>
                                    {teachers.map((teacher) => (
                                        <div key={teacher.id} className={styles.teacher}>
                                            <span className={styles.teacherName}>{teacher.name}</span>
                                        </div>
                                    ))}
                                </div>
                            </div>
                        )}
                    </div>
                </aside>
            </div>
        </>
    );
}

export async function generateMetadata({ params }: CoursePageProps) {
    const { slug } = await params;
    const course = await getCourseDetails(slug);

    if (!course) {
        return {
            title: 'Curso no encontrado - Platzi Flix',
            description: 'El curso que buscas no existe.',
        };
    }

    return {
        title: `${course.name} - Platzi Flix`,
        description: course.description,
        openGraph: {
            title: course.name,
            description: course.description,
            images: [course.thumbnail],
        },
    };
} 