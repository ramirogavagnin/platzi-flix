'use client';

import { useState } from 'react';
import styles from './LecturePlayer.module.scss';

interface LecturePlayerProps {
    videoUrl: string;
    title: string;
}

export default function LecturePlayer({ videoUrl, title }: LecturePlayerProps) {
    const [isLoading, setIsLoading] = useState(true);

    // Extract YouTube video ID from URL
    const getYouTubeVideoId = (url: string): string | null => {
        // Handle different YouTube URL formats
        const patterns = [
            /(?:youtube\.com\/watch\?v=)([a-zA-Z0-9_-]+)(?:[&#\s]|$)/,  // youtube.com/watch?v=ID
            /(?:youtu\.be\/)([a-zA-Z0-9_-]+)(?:[?&#\s]|$)/,           // youtu.be/ID
            /(?:youtube\.com\/embed\/)([a-zA-Z0-9_-]+)(?:[?&#\s]|$)/,  // youtube.com/embed/ID
        ];

        for (const pattern of patterns) {
            const match = url.match(pattern);
            if (match && match[1]) {
                return match[1];
            }
        }

        return null;
    };

    const handleLoad = () => {
        setIsLoading(false);
    };

    const videoId = getYouTubeVideoId(videoUrl);

    if (!videoId) {
        return (
            <div className={styles.playerContainer}>
                <div className={styles.errorMessage}>
                    <p>No se pudo cargar el video</p>
                    <p>URL no válida: {videoUrl}</p>
                </div>
            </div>
        );
    }

    const embedUrl = `https://www.youtube.com/embed/${videoId}`;

    return (
        <div className={styles.playerContainer}>
            {isLoading && (
                <div className={styles.loadingOverlay}>
                    <div className={styles.loadingSpinner}></div>
                    <p>Cargando video...</p>
                </div>
            )}
            <iframe
                className={styles.videoPlayer}
                src={embedUrl}
                title={title}
                allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share"
                allowFullScreen
                onLoad={handleLoad}
            />
        </div>
    );
} 