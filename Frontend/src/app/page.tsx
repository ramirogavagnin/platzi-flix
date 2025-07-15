'use client';

import styles from './page.module.scss';
import Loader from '@/components/Loader';
import Error from '@/components/Error';
import Sidebar from '@/components/Sidebar';
import Header from '@/components/Header';
import Content from '@/components/Content';
import { useGetCourses } from '@/hooks/useGetCourses';

export default function Home() {
  const { courses, loading, error } = useGetCourses();

  if (loading)
    return <Loader />;


  if (error)
    return <Error error={error} />;


  return (
    <div className={styles.app}>
      {/* Sidebar */}
      <Sidebar />

      {/* Main Content */}
      <div className={styles.mainContent}>
        {/* Header */}
        <Header />

        {/* Content */}
        <Content courses={courses} />
      </div>
    </div>
  );
}
