import styles from '@/app/page.module.scss';

export default function Sidebar() {
    return (
        <div className={styles.sidebar}>
            <div className={styles.logo}>Platzi</div>
            <nav className={styles.nav}>
                <a href="#" className={styles.navItem}>
                    <span className={styles.navIcon}>🏠</span>
                    Inicio
                </a>
                <a href="#" className={styles.navItem}>
                    <span className={styles.navIcon}>💬</span>
                    Comentarios
                </a>
                <a href="#" className={styles.navItem}>
                    <span className={styles.navIcon}>📁</span>
                    Mis Rutas
                </a>
                <a href="#" className={styles.navItem}>
                    <span className={styles.navIcon}>📊</span>
                    Mi progreso
                </a>
                <a href="#" className={styles.navItem}>
                    <span className={styles.navIcon}>⭐</span>
                    Mis certificados
                </a>
                <a href="#" className={styles.navItem}>
                    <span className={styles.navIcon}>🔔</span>
                    Notificaciones
                </a>
            </nav>
        </div>
    );
} 