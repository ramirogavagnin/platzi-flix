import Header from '@/components/Header';
import Sidebar from '@/components/Sidebar';
import styles from '../../page.module.scss';

export default function CourseLayout({
    children,
}: {
    children: React.ReactNode;
}) {
    return (
        <div className={styles.app}>
            <Sidebar />
            <main className={styles.mainContent}>
                <Header />
                <div className={styles.content}>
                    {children}
                </div>
            </main>
        </div>
    );
} 