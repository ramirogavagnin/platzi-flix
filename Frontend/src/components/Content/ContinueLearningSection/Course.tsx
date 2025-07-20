import { CourseResponse } from '@/types';
import Link from 'next/link';
import styles from '@/app/page.module.scss';

interface CourseProps {
    course: CourseResponse;
    index: number;
}

export default function Course({ course, index }: CourseProps) {
    const handleDismiss = (e: React.MouseEvent) => {
        e.preventDefault();
        e.stopPropagation();
        // Handle dismiss logic here
        console.log('Course dismissed:', course.id);
    };

    return (
        <Link href={`/courses/${course.slug}`} className={styles.courseCardLink}>
            <div key={course.id} className={styles.courseCard}>
                <div className={styles.cardThumbnail}>
                    <img
                        src={course.thumbnail || "https://kinsta.com/es/wp-content/uploads/sites/8/2023/04/react-must-be-in-scope-when-using-jsx-2048x1024.jpg"}
                        alt={course.name}
                        className={styles.thumbnail}
                    />
                    <div className={styles.playButton}>▶️</div>
                </div>
                <div className={styles.cardContent}>
                    <h3 className={styles.cardTitle}>
                        {course.name}
                    </h3>
                    <p className={styles.cardDescription}>
                        {course.description.length > 80
                            ? `${course.description.substring(0, 80)}...`
                            : course.description}
                    </p>
                    <div className={styles.courseIcon}>
                        {index === 0 && <span className={styles.iconGreen}>🔷</span>}
                        {index === 1 && <span className={styles.iconPurple}>⭐</span>}
                        {index === 2 && <span className={styles.iconGreen}>☁️</span>}
                        {index === 3 && <span className={styles.iconBlue}>▶️</span>}
                    </div>
                </div>
                {index === 1 && (
                    <button
                        className={styles.dismissButton}
                        onClick={handleDismiss}
                        title="Descartar curso"
                    >
                        ✕
                    </button>
                )}
            </div>
        </Link>
    );
} 