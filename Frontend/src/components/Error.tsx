import styles from '@/app/page.module.scss';
import Sidebar from './Sidebar';

interface ErrorProps {
    error: string;
}

export default function Error({ error }: ErrorProps) {
    return (
        <div className={styles.app}>
            <Sidebar />
            <div className={styles.mainContent}>
                <div className={styles.error}>Error: {error}</div>
            </div>
        </div>
    );
} 