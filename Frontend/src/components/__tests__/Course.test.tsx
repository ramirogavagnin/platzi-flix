import { describe, it, expect, vi } from 'vitest'
import { render, screen, fireEvent } from '@testing-library/react'
import Course from '../Content/ContinueLearningSection/Course'

// Mock the CSS module
vi.mock('@/app/page.module.scss', () => ({
    default: {
        courseCardLink: 'courseCardLink',
        courseCard: 'courseCard',
        cardThumbnail: 'cardThumbnail',
        thumbnail: 'thumbnail',
        playButton: 'playButton',
        cardContent: 'cardContent',
        cardTitle: 'cardTitle',
        cardDescription: 'cardDescription',
        courseIcon: 'courseIcon',
        iconGreen: 'iconGreen',
        iconPurple: 'iconPurple',
        iconBlue: 'iconBlue',
        dismissButton: 'dismissButton',
    },
}))

// Mock Next.js Link component
vi.mock('next/link', () => ({
    default: ({ children, href, className }: { children: React.ReactNode; href: string; className: string }) => (
        <a href={href} className={className}>
            {children}
        </a>
    ),
}))

const mockCourse = {
    id: 1,
    name: 'React Fundamentals',
    description: 'Learn the basics of React including components, props, state, and hooks. This comprehensive course covers everything you need to know to get started with React development.',
    slug: 'react-fundamentals',
    thumbnail: 'https://example.com/react-thumbnail.jpg',
}

describe('Course', () => {
    beforeEach(() => {
        vi.clearAllMocks()
    })

    describe('Rendering', () => {
        it('renders course information correctly', () => {
            render(<Course course={mockCourse} index={0} />)

            expect(screen.getByText('React Fundamentals')).toBeInTheDocument()
            expect(screen.getByText(/Learn the basics of React/)).toBeInTheDocument()
            expect(screen.getByAltText('React Fundamentals')).toBeInTheDocument()
        })

        it('renders course with fallback thumbnail when thumbnail is not provided', () => {
            const courseWithoutThumbnail = { ...mockCourse, thumbnail: '' }
            render(<Course course={courseWithoutThumbnail} index={0} />)

            const img = screen.getByAltText('React Fundamentals')
            expect(img).toHaveAttribute('src', 'https://kinsta.com/es/wp-content/uploads/sites/8/2023/04/react-must-be-in-scope-when-using-jsx-2048x1024.jpg')
        })

        it('renders course with provided thumbnail', () => {
            render(<Course course={mockCourse} index={0} />)

            const img = screen.getByAltText('React Fundamentals')
            expect(img).toHaveAttribute('src', 'https://example.com/react-thumbnail.jpg')
        })

        it('renders play button in thumbnail', () => {
            render(<Course course={mockCourse} index={0} />)

            const playButton = screen.getByText('▶️')
            expect(playButton).toBeInTheDocument()
        })

        it('renders link with correct href', () => {
            render(<Course course={mockCourse} index={0} />)

            const link = screen.getByRole('link')
            expect(link).toHaveAttribute('href', '/courses/react-fundamentals')
        })
    })

    describe('Description truncation', () => {
        it('truncates long description', () => {
            const longDescriptionCourse = {
                ...mockCourse,
                description: 'This is a very long description that should be truncated because it exceeds the 80 character limit that is set in the component logic.'
            }

            render(<Course course={longDescriptionCourse} index={0} />)

            const description = screen.getByText(/This is a very long description that should be truncated/)
            expect(description.textContent).toContain('...')
            expect(description.textContent?.length).toBeLessThanOrEqual(83) // 80 + '...'
        })

        it('does not truncate short description', () => {
            const shortDescriptionCourse = {
                ...mockCourse,
                description: 'Short description'
            }

            render(<Course course={shortDescriptionCourse} index={0} />)

            expect(screen.getByText('Short description')).toBeInTheDocument()
            expect(screen.queryByText(/\.\.\./)).not.toBeInTheDocument()
        })

        it('handles exact 80 character description', () => {
            const exactDescriptionCourse = {
                ...mockCourse,
                description: 'A'.repeat(80)
            }

            render(<Course course={exactDescriptionCourse} index={0} />)

            expect(screen.getByText('A'.repeat(80))).toBeInTheDocument()
            expect(screen.queryByText(/\.\.\./)).not.toBeInTheDocument()
        })
    })

    describe('Course icons based on index', () => {
        it('renders green diamond icon for index 0', () => {
            render(<Course course={mockCourse} index={0} />)

            // Find the icon within the courseIcon div
            const courseIcon = screen.getByText('🔷')
            expect(courseIcon).toBeInTheDocument()
            expect(courseIcon.closest('.courseIcon')).toBeInTheDocument()
        })

        it('renders purple star icon for index 1', () => {
            render(<Course course={mockCourse} index={1} />)

            const courseIcon = screen.getByText('⭐')
            expect(courseIcon).toBeInTheDocument()
            expect(courseIcon.closest('.courseIcon')).toBeInTheDocument()
        })

        it('renders green cloud icon for index 2', () => {
            render(<Course course={mockCourse} index={2} />)

            const courseIcon = screen.getByText('☁️')
            expect(courseIcon).toBeInTheDocument()
            expect(courseIcon.closest('.courseIcon')).toBeInTheDocument()
        })

        it('renders blue play icon for index 3', () => {
            render(<Course course={mockCourse} index={3} />)

            // There are two ▶️ elements - one in playButton and one in courseIcon
            const courseIcons = screen.getAllByText('▶️')
            expect(courseIcons).toHaveLength(2)

            // Check that one is in the courseIcon
            const courseIcon = courseIcons.find(icon => icon.closest('.courseIcon'))
            expect(courseIcon).toBeInTheDocument()
        })

        it('renders no course icon for other indices', () => {
            render(<Course course={mockCourse} index={4} />)

            // Only the play button should be present, no course icon
            const playButtons = screen.getAllByText('▶️')
            expect(playButtons).toHaveLength(1)
            expect(playButtons[0].closest('.playButton')).toBeInTheDocument()
        })
    })

    describe('Dismiss button', () => {
        it('renders dismiss button only for index 1', () => {
            render(<Course course={mockCourse} index={1} />)

            const dismissButton = screen.getByTitle('Descartar curso')
            expect(dismissButton).toBeInTheDocument()
            expect(dismissButton).toHaveTextContent('✕')
        })

        it('does not render dismiss button for other indices', () => {
            render(<Course course={mockCourse} index={0} />)

            expect(screen.queryByTitle('Descartar curso')).not.toBeInTheDocument()
        })

        it('handles dismiss button click', () => {
            const consoleSpy = vi.spyOn(console, 'log').mockImplementation(() => { })

            render(<Course course={mockCourse} index={1} />)

            const dismissButton = screen.getByTitle('Descartar curso')
            fireEvent.click(dismissButton)

            expect(consoleSpy).toHaveBeenCalledWith('Course dismissed:', 1)

            consoleSpy.mockRestore()
        })

        it('prevents event propagation on dismiss button click', () => {
            const consoleSpy = vi.spyOn(console, 'log').mockImplementation(() => { })

            render(<Course course={mockCourse} index={1} />)

            const dismissButton = screen.getByTitle('Descartar curso')

            // Simulate click event
            fireEvent.click(dismissButton)

            expect(consoleSpy).toHaveBeenCalledWith('Course dismissed:', 1)

            consoleSpy.mockRestore()
        })
    })

    describe('Accessibility', () => {
        it('has proper alt text for image', () => {
            render(<Course course={mockCourse} index={0} />)

            const img = screen.getByAltText('React Fundamentals')
            expect(img).toBeInTheDocument()
        })

        it('has proper title for dismiss button', () => {
            render(<Course course={mockCourse} index={1} />)

            const dismissButton = screen.getByTitle('Descartar curso')
            expect(dismissButton).toBeInTheDocument()
        })

        it('has proper link role', () => {
            render(<Course course={mockCourse} index={0} />)

            const link = screen.getByRole('link')
            expect(link).toBeInTheDocument()
        })
    })

    describe('Edge cases', () => {
        it('handles empty description', () => {
            const emptyDescriptionCourse = {
                ...mockCourse,
                description: ''
            }

            render(<Course course={emptyDescriptionCourse} index={0} />)

            // Find the description element specifically by class
            const descriptionElement = screen.getByText('', { selector: '.cardDescription' })
            expect(descriptionElement).toBeInTheDocument()
            expect(descriptionElement.tagName).toBe('P')
        })

        it('handles course with special characters in name', () => {
            const specialCharCourse = {
                ...mockCourse,
                name: 'React & TypeScript: Advanced Patterns 🚀'
            }

            render(<Course course={specialCharCourse} index={0} />)

            expect(screen.getByText('React & TypeScript: Advanced Patterns 🚀')).toBeInTheDocument()
            expect(screen.getByAltText('React & TypeScript: Advanced Patterns 🚀')).toBeInTheDocument()
        })

        it('handles course with very long name', () => {
            const longNameCourse = {
                ...mockCourse,
                name: 'A'.repeat(200)
            }

            render(<Course course={longNameCourse} index={0} />)

            expect(screen.getByText('A'.repeat(200))).toBeInTheDocument()
        })
    })
}) 