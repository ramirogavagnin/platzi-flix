import { CourseResponse } from '@/types';
import styles from '@/app/page.module.scss';
import Course from './Course';

interface ContinueLearningSectionProps {
    courses: CourseResponse[];
}

export default function ContinueLearningSection({ courses }: ContinueLearningSectionProps) {
    return (
        <section className={styles.continueLearning}>
            <div className={styles.coursesCarousel}>
                {courses.slice(0, 4).map((course, index) => (
                    <Course key={course.id} course={course} index={index} />
                ))}
            </div>
        </section>
    );
} 