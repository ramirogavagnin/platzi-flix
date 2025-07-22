import { describe, it, expect, vi, beforeEach } from 'vitest';
import { render, screen, fireEvent, waitFor } from '@testing-library/react';
import LecturePlayer from '../LecturePlayer';

// Mock the CSS module
vi.mock('../LecturePlayer.module.scss', () => ({
    default: {
        playerContainer: 'playerContainer',
        videoPlayer: 'videoPlayer',
        loadingOverlay: 'loadingOverlay',
        loadingSpinner: 'loadingSpinner',
        errorMessage: 'errorMessage',
    },
}));

describe('LecturePlayer', () => {
    const mockProps = {
        videoUrl: 'https://www.youtube.com/watch?v=dQw4w9WgXcQ',
        title: 'Test Video Title',
    };

    beforeEach(() => {
        vi.clearAllMocks();
    });

    describe('Rendering', () => {
        it('renders video player with correct props', () => {
            render(<LecturePlayer {...mockProps} />);

            const iframe = screen.getByTitle('Test Video Title');
            expect(iframe).toBeInTheDocument();
            expect(iframe).toHaveAttribute('src', 'https://www.youtube.com/embed/dQw4w9WgXcQ');
            expect(iframe).toHaveAttribute('allowfullscreen');
        });

        it('shows loading overlay initially', () => {
            render(<LecturePlayer {...mockProps} />);

            expect(screen.getByText('Cargando video...')).toBeInTheDocument();
            expect(document.querySelector('.loadingOverlay')).toBeInTheDocument();
            expect(document.querySelector('.loadingSpinner')).toBeInTheDocument();
        });

        it('renders with different video URLs', () => {
            const differentUrl = 'https://www.youtube.com/watch?v=abc123';
            render(<LecturePlayer videoUrl={differentUrl} title="Different Video" />);

            const iframe = screen.getByTitle('Different Video');
            expect(iframe).toHaveAttribute('src', 'https://www.youtube.com/embed/abc123');
        });
    });

    describe('YouTube URL parsing', () => {
        it('handles standard youtube.com/watch?v= URLs', () => {
            render(<LecturePlayer videoUrl="https://www.youtube.com/watch?v=abc123" title="Test" />);

            const iframe = screen.getByTitle('Test');
            expect(iframe).toHaveAttribute('src', 'https://www.youtube.com/embed/abc123');
        });

        it('handles youtu.be URLs', () => {
            render(<LecturePlayer videoUrl="https://youtu.be/abc123" title="Test" />);

            const iframe = screen.getByTitle('Test');
            expect(iframe).toHaveAttribute('src', 'https://www.youtube.com/embed/abc123');
        });

        it('handles youtube.com/embed/ URLs', () => {
            render(<LecturePlayer videoUrl="https://www.youtube.com/embed/abc123" title="Test" />);

            const iframe = screen.getByTitle('Test');
            expect(iframe).toHaveAttribute('src', 'https://www.youtube.com/embed/abc123');
        });

        it('handles URLs with additional parameters', () => {
            render(<LecturePlayer videoUrl="https://www.youtube.com/watch?v=abc123&t=10s" title="Test" />);

            const iframe = screen.getByTitle('Test');
            expect(iframe).toHaveAttribute('src', 'https://www.youtube.com/embed/abc123');
        });

        it('handles URLs with playlist parameters', () => {
            render(<LecturePlayer videoUrl="https://www.youtube.com/watch?v=abc123&list=PLxyz" title="Test" />);

            const iframe = screen.getByTitle('Test');
            expect(iframe).toHaveAttribute('src', 'https://www.youtube.com/embed/abc123');
        });
    });

    describe('Error handling', () => {
        it('shows error message for invalid URLs', () => {
            render(<LecturePlayer videoUrl="https://invalid-url.com" title="Test" />);

            expect(screen.getByText('No se pudo cargar el video')).toBeInTheDocument();
            expect(screen.getByText('URL no válida: https://invalid-url.com')).toBeInTheDocument();
            expect(screen.queryByTitle('Test')).not.toBeInTheDocument();
        });

        it('shows error message for empty URLs', () => {
            render(<LecturePlayer videoUrl="" title="Test" />);

            expect(screen.getByText('No se pudo cargar el video')).toBeInTheDocument();
            expect(screen.getByText('URL no válida:')).toBeInTheDocument();
        });

        it('shows error message for non-YouTube URLs', () => {
            render(<LecturePlayer videoUrl="https://vimeo.com/123456" title="Test" />);

            expect(screen.getByText('No se pudo cargar el video')).toBeInTheDocument();
            expect(screen.getByText('URL no válida: https://vimeo.com/123456')).toBeInTheDocument();
        });

        it('shows error message for malformed YouTube URLs', () => {
            render(<LecturePlayer videoUrl="https://www.youtube.com/watch" title="Test" />);

            expect(screen.getByText('No se pudo cargar el video')).toBeInTheDocument();
            expect(screen.getByText('URL no válida: https://www.youtube.com/watch')).toBeInTheDocument();
        });
    });

    describe('Loading state', () => {
        it('hides loading overlay when video loads', async () => {
            render(<LecturePlayer {...mockProps} />);

            const iframe = screen.getByTitle('Test Video Title');

            // Initially loading should be visible
            expect(screen.getByText('Cargando video...')).toBeInTheDocument();

            // Simulate iframe load event
            fireEvent.load(iframe);

            await waitFor(() => {
                expect(screen.queryByText('Cargando video...')).not.toBeInTheDocument();
            });
        });

        it('maintains loading state until onLoad is triggered', () => {
            render(<LecturePlayer {...mockProps} />);

            // Loading should persist until load event
            expect(screen.getByText('Cargando video...')).toBeInTheDocument();

            // Verify the iframe exists but loading is still shown
            expect(screen.getByTitle('Test Video Title')).toBeInTheDocument();
            expect(screen.getByText('Cargando video...')).toBeInTheDocument();
        });
    });

    describe('Iframe attributes', () => {
        it('sets correct iframe attributes', () => {
            render(<LecturePlayer {...mockProps} />);

            const iframe = screen.getByTitle('Test Video Title');

            expect(iframe).toHaveAttribute('allowfullscreen');
            expect(iframe).toHaveAttribute(
                'allow',
                'accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share'
            );
            expect(iframe.tagName).toBe('IFRAME');
        });

        it('uses correct CSS class', () => {
            render(<LecturePlayer {...mockProps} />);

            const iframe = screen.getByTitle('Test Video Title');
            expect(iframe).toHaveClass('videoPlayer');
        });
    });

    describe('Container structure', () => {
        it('renders container with correct class', () => {
            render(<LecturePlayer {...mockProps} />);

            const container = document.querySelector('.playerContainer');
            expect(container).toBeInTheDocument();
        });

        it('renders error container when URL is invalid', () => {
            render(<LecturePlayer videoUrl="invalid-url" title="Test" />);

            const container = document.querySelector('.playerContainer');
            expect(container).toBeInTheDocument();

            const errorMessage = document.querySelector('.errorMessage');
            expect(errorMessage).toBeInTheDocument();
        });
    });

    describe('Edge cases', () => {
        it('handles very long titles', () => {
            const longTitle = 'A'.repeat(200);
            render(<LecturePlayer videoUrl="https://www.youtube.com/watch?v=abc123" title={longTitle} />);

            const iframe = screen.getByTitle(longTitle);
            expect(iframe).toBeInTheDocument();
        });

        it('handles special characters in title', () => {
            const specialTitle = 'Test Video: "Advanced" & <Special> Characters';
            render(<LecturePlayer videoUrl="https://www.youtube.com/watch?v=abc123" title={specialTitle} />);

            const iframe = screen.getByTitle(specialTitle);
            expect(iframe).toBeInTheDocument();
        });

        it('handles URLs with hash fragments', () => {
            render(<LecturePlayer videoUrl="https://www.youtube.com/watch?v=abc123#t=30s" title="Test" />);

            const iframe = screen.getByTitle('Test');
            // The regex extracts just the video ID, ignoring fragments
            expect(iframe).toHaveAttribute('src', 'https://www.youtube.com/embed/abc123');
        });

        it('extracts video ID from complex URLs', () => {
            const complexUrl = 'https://www.youtube.com/watch?v=dQw4w9WgXcQ&feature=youtu.be&t=10';
            render(<LecturePlayer videoUrl={complexUrl} title="Complex URL Test" />);

            const iframe = screen.getByTitle('Complex URL Test');
            expect(iframe).toHaveAttribute('src', 'https://www.youtube.com/embed/dQw4w9WgXcQ');
        });
    });
}); 