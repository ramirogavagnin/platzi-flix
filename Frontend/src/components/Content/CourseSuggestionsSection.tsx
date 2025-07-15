import styles from '@/app/page.module.scss';

export default function CourseSuggestionsSection() {
    return (
        <section className={styles.courseSuggestions}>
            <h2 className={styles.sectionTitle}>
                ¿Qué cursos quieres que Platzi cree para ti?
            </h2>
            <div className={styles.suggestionInput}>
                <input
                    type="text"
                    placeholder="Escribe el curso que quieres"
                    className={styles.suggestionField}
                />
                <button className={styles.sendButton}>📤</button>
            </div>
        </section>
    );
} 