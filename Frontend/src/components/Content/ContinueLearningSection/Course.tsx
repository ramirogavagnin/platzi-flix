import { CourseResponse } from '@/types';
import styles from '@/app/page.module.scss';

interface CourseProps {
    course: CourseResponse;
    index: number;
}

export default function Course({ course, index }: CourseProps) {
    return (
        <div key={course.id} className={styles.courseCard}>
            <div className={styles.cardThumbnail}>
                <img
                    src="https://kinsta.com/es/wp-content/uploads/sites/8/2023/04/react-must-be-in-scope-when-using-jsx-2048x1024.jpg"
                    alt={course.name}
                    className={styles.thumbnail}
                />
                <div className={styles.playButton}>▶️</div>
            </div>
            <div className={styles.cardContent}>
                <h3 className={styles.cardTitle}>
                    Clase {index + 1} de {Math.floor(Math.random() * 50) + 10}
                </h3>
                <p className={styles.cardDescription}>
                    {course.description.length > 30
                        ? `${course.description.substring(0, 30)}...`
                        : course.description}
                </p>
                <div className={styles.courseIcon}>
                    {index === 0 && <span className={styles.iconGreen}>🔷</span>}
                    {index === 1 && <span className={styles.iconPurple}>⭐</span>}
                    {index === 2 && <span className={styles.iconGreen}>☁️</span>}
                    {index === 3 && <span className={styles.iconBlue}>▶️</span>}
                </div>
            </div>
            {index === 1 && <button className={styles.dismissButton}>✕</button>}
        </div>
    );
} 