'use client';

import { useRouter, useSearchParams } from 'next/navigation';
import { useGetLecture } from '@/hooks/useGetLecture';
import LecturePlayer from '@/components/LecturePlayer';
import Loader from '@/components/Loader';
import Error from '@/components/Error';
import styles from './page.module.scss';

interface LecturePageProps {
    params: {
        lectureId: string;
    };
}

export default function LecturePage({ params }: LecturePageProps) {
    const router = useRouter();
    const searchParams = useSearchParams();
    const { lectureId } = params;

    // Get course slug from URL parameters - required for API call
    const courseSlug = searchParams.get('courseSlug') || '';

    const { lecture, loading, error } = useGetLecture(courseSlug, lectureId);

    const handleBackToCourse = () => {
        router.push(`/courses/${courseSlug}`);
    };

    if (loading) {
        return (
            <div className={styles.pageContainer}>
                <Loader />
            </div>
        );
    }

    if (error) {
        return (
            <div className={styles.pageContainer}>
                <Error error={error} />
            </div>
        );
    }

    if (!lecture) {
        return (
            <div className={styles.pageContainer}>
                <Error error="No se encontró la clase" />
            </div>
        );
    }

    return (
        <div className={styles.pageContainer}>
            <header className={styles.lectureHeader}>
                <button
                    className={styles.backButton}
                    onClick={handleBackToCourse}
                    type="button"
                >
                    <span className={styles.backIcon}>←</span>
                    <span>Volver al curso</span>
                </button>
            </header>

            <main className={styles.lectureMain}>
                <div className={styles.videoSection}>
                    <LecturePlayer
                        videoUrl={lecture.video_url}
                        title={lecture.name}
                    />
                </div>

                <div className={styles.lectureInfo}>
                    <h1 className={styles.lectureTitle}>
                        {lecture.name}
                    </h1>

                    <div className={styles.lectureDescription}>
                        <p>{lecture.description}</p>
                    </div>
                </div>
            </main>
        </div>
    );
} 