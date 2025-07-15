import styles from '@/app/page.module.scss';
import Sidebar from './Sidebar';

export default function Loader() {
    return (
        <div className={styles.app}>
            <Sidebar />
            <div className={styles.mainContent}>
                <div className={styles.loading}>Cargando cursos...</div>
            </div>
        </div>
    );
} 