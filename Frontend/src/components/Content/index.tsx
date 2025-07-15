import { CourseResponse } from '@/types';
import styles from '@/app/page.module.scss';
import ContinueLearningSection from './ContinueLearningSection';
import CourseSuggestionsSection from './CourseSuggestionsSection';

interface ContentProps {
    courses: CourseResponse[];
}

export default function Content({ courses }: ContentProps) {
    return (
        <div className={styles.content}>
            {/* Continue Learning Section */}
            <ContinueLearningSection courses={courses} />
            {/* Course Suggestions Section */}
            <CourseSuggestionsSection />
        </div>
    );
} 