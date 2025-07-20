import { LectureListItem } from '@/types/lecture';
import styles from './LessonsList.module.scss';

interface LessonsListProps {
    lessons: LectureListItem[];
    courseSlug: string;
}

export default function LessonsList({ lessons, courseSlug }: LessonsListProps) {
    if (lessons.length === 0) {
        return (
            <section className={styles.container}>
                <h2 className={styles.title}>Contenido del curso</h2>
                <div className={styles.emptyState}>
                    <p>Este curso aún no tiene clases disponibles.</p>
                </div>
            </section>
        );
    }

    return (
        <section className={styles.container}>
            <div className={styles.header}>
                <h2 className={styles.title}>Contenido del curso</h2>
                <span className={styles.count}>{lessons.length} clases</span>
            </div>

            <div className={styles.lessonsList}>
                {lessons.map((lesson, index) => (
                    <div key={lesson.id} className={styles.lessonItem}>
                        <div className={styles.lessonNumber}>
                            {String(index + 1).padStart(2, '0')}
                        </div>

                        <div className={styles.lessonContent}>
                            <h3 className={styles.lessonTitle}>{lesson.name}</h3>
                            <p className={styles.lessonDescription}>{lesson.description}</p>
                        </div>

                        <div className={styles.lessonActions}>
                            <button className={styles.playButton} title="Reproducir clase">
                                <span className={styles.playIcon}>▶</span>
                            </button>
                        </div>
                    </div>
                ))}
            </div>
        </section>
    );
} 