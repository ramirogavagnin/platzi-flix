import { describe, it, expect } from 'vitest'
import { render, screen } from '@testing-library/react'
import Header from '../Header'

// Mock the CSS module
vi.mock('@/app/page.module.scss', () => ({
    default: {
        header: 'header',
        headerLeft: 'headerLeft',
        logo: 'logo',
        searchBar: 'searchBar',
        searchInput: 'searchInput',
        searchIcon: 'searchIcon',
        headerRight: 'headerRight',
        userStats: 'userStats',
        rocketIcon: 'rocketIcon',
        streak: 'streak',
        userProfile: 'userProfile',
        avatar: 'avatar',
        points: 'points',
        dropdown: 'dropdown',
        languageSelector: 'languageSelector',
    },
}))

describe('Header', () => {
    it('renders the header element', () => {
        render(<Header />)
        const headerElement = screen.getByRole('banner')
        expect(headerElement).toBeInTheDocument()
    })

    it('renders the Platzi logo', () => {
        render(<Header />)
        const logoElement = screen.getByText('Platzi')
        expect(logoElement).toBeInTheDocument()
    })

    it('renders the search input', () => {
        render(<Header />)
        const searchInput = screen.getByPlaceholderText('¿Qué quieres aprender?')
        expect(searchInput).toBeInTheDocument()
    })

    it('renders the search icon', () => {
        render(<Header />)
        const searchIcon = screen.getByText('🔍')
        expect(searchIcon).toBeInTheDocument()
    })

    it('renders user stats', () => {
        render(<Header />)
        const rocketIcon = screen.getByText('🚀')
        const streak = screen.getByText('9')
        expect(rocketIcon).toBeInTheDocument()
        expect(streak).toBeInTheDocument()
    })

    it('renders user profile elements', () => {
        render(<Header />)
        const avatar = screen.getByText('👤')
        const points = screen.getByText('5.475 pts')
        const dropdown = screen.getByText('▼')
        expect(avatar).toBeInTheDocument()
        expect(points).toBeInTheDocument()
        expect(dropdown).toBeInTheDocument()
    })

    it('renders language selector', () => {
        render(<Header />)
        const languageSelector = screen.getByText('A')
        expect(languageSelector).toBeInTheDocument()
    })
}) 