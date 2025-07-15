import styles from '@/app/page.module.scss';

export default function Header() {
    return (
        <header className={styles.header}>
            <div className={styles.headerLeft}>
                <div className={styles.logo}>Platzi</div>
            </div>
            <div className={styles.searchBar}>
                <input
                    type="text"
                    placeholder="¿Qué quieres aprender?"
                    className={styles.searchInput}
                />
                <span className={styles.searchIcon}>🔍</span>
            </div>
            <div className={styles.headerRight}>
                <div className={styles.userStats}>
                    <span className={styles.rocketIcon}>🚀</span>
                    <span className={styles.streak}>9</span>
                </div>
                <div className={styles.userProfile}>
                    <div className={styles.avatar}>👤</div>
                    <span className={styles.points}>5.475 pts</span>
                    <span className={styles.dropdown}>▼</span>
                </div>
                <div className={styles.languageSelector}>A</div>
            </div>
        </header>
    );
} 