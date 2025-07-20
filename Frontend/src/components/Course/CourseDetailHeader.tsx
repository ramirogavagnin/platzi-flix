import { CourseDetail } from '@/types/course';
import { Teacher } from '@/types/teacher';
import styles from './CourseDetailHeader.module.scss';

interface CourseDetailHeaderProps {
    course: CourseDetail;
    teachers: Teacher[];
}

export default function CourseDetailHeader({ course, teachers }: CourseDetailHeaderProps) {
    return (
        <header className={styles.header}>
            <div className={styles.container}>
                <div className={styles.thumbnailContainer}>
                    <img
                        src={course.thumbnail}
                        alt={course.name}
                        className={styles.thumbnail}
                    />
                    <div className={styles.overlay}>
                        <button className={styles.playButton}>
                            <span className={styles.playIcon}>▶</span>
                        </button>
                    </div>
                </div>

                <div className={styles.content}>
                    <div className={styles.breadcrumb}>
                        <span className={styles.breadcrumbItem}>Cursos</span>
                        <span className={styles.separator}>›</span>
                        <span className={styles.breadcrumbItem}>{course.name}</span>
                    </div>

                    <h1 className={styles.title}>{course.name}</h1>

                    {teachers.length > 0 && (
                        <div className={styles.instructors}>
                            <span className={styles.instructorsLabel}>Instructores:</span>
                            <div className={styles.instructorsList}>
                                {teachers.map((teacher, index) => (
                                    <span key={teacher.id} className={styles.instructor}>
                                        {teacher.name}
                                        {index < teachers.length - 1 && ', '}
                                    </span>
                                ))}
                            </div>
                        </div>
                    )}

                    <div className={styles.stats}>
                        <div className={styles.stat}>
                            <span className={styles.statValue}>{course.lectures.length}</span>
                            <span className={styles.statLabel}>Clases</span>
                        </div>
                        <div className={styles.stat}>
                            <span className={styles.statValue}>Intermedio</span>
                            <span className={styles.statLabel}>Nivel</span>
                        </div>
                    </div>

                    <button className={styles.startButton}>
                        <span className={styles.buttonIcon}>▶</span>
                        Comenzar curso
                    </button>
                </div>
            </div>
        </header>
    );
} 