import "@testing-library/jest-dom";
import { vi } from "vitest";

// Mock CSS modules
vi.mock("*.module.scss", () => ({
  default: {
    container: "container",
    header: "header",
    main: "main",
    sidebar: "sidebar",
    content: "content",
    card: "card",
    button: "button",
    input: "input",
    searchBar: "searchBar",
    searchInput: "searchInput",
    searchIcon: "searchIcon",
    navItem: "navItem",
    navItemActive: "navItem--active",
    courseCard: "courseCard",
    courseCardFeatured: "courseCard--featured",
    cardTitle: "cardTitle",
    userProfile: "userProfile",
    mainContent: "mainContent",
  },
}));

// Mock Next.js router
vi.mock("next/navigation", () => ({
  useRouter() {
    return {
      push: vi.fn(),
      replace: vi.fn(),
      prefetch: vi.fn(),
      back: vi.fn(),
      forward: vi.fn(),
      refresh: vi.fn(),
    };
  },
  useSearchParams() {
    return new URLSearchParams();
  },
  usePathname() {
    return "/";
  },
}));

// Mock Next.js image component
vi.mock("next/image", () => ({
  __esModule: true,
  default: function MockImage(props: Record<string, unknown>) {
    return {
      type: "img",
      props: props,
    };
  },
}));

// Global test utilities
global.ResizeObserver = vi.fn().mockImplementation(() => ({
  observe: vi.fn(),
  unobserve: vi.fn(),
  disconnect: vi.fn(),
}));
