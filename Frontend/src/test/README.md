# Testing Setup

This project uses Vitest for unit testing with React Testing Library for component testing.

## Setup

The testing environment is configured with:

- **Vitest**: Fast unit testing framework
- **React Testing Library**: Component testing utilities
- **jsdom**: DOM environment for testing
- **@testing-library/jest-dom**: Custom matchers for DOM testing

## Configuration Files

- `vitest.config.ts`: Main Vitest configuration
- `src/test/setup.ts`: Test environment setup and mocks
- `src/test/vitest.d.ts`: TypeScript declarations for testing

## Available Scripts

```bash
# Run tests in watch mode
npm run test

# Run tests once
npm run test:run

# Run tests with UI (if @vitest/ui is installed)
npm run test:ui

# Run tests with coverage
npm run test:coverage
```

## Writing Tests

### Basic Test Structure

```typescript
import { describe, it, expect } from "vitest";
import { render, screen } from "@testing-library/react";
import YourComponent from "../YourComponent";

describe("YourComponent", () => {
  it("renders correctly", () => {
    render(<YourComponent />);
    expect(screen.getByText("Expected Text")).toBeInTheDocument();
  });
});
```

### Testing Components with CSS Modules

When testing components that use CSS modules, mock the CSS import:

```typescript
import { describe, it, expect } from "vitest";
import { render, screen } from "@testing-library/react";
import ComponentWithCSS from "../ComponentWithCSS";

// Mock the CSS module
vi.mock("@/path/to/styles.module.scss", () => ({
  default: {
    className1: "className1",
    className2: "className2",
  },
}));

describe("ComponentWithCSS", () => {
  it("renders correctly", () => {
    render(<ComponentWithCSS />);
    // Your test assertions
  });
});
```

### Available Testing Utilities

- `render()`: Render React components
- `screen`: Query elements from the rendered component
- `fireEvent`: Simulate user interactions
- `waitFor`: Wait for asynchronous operations
- `vi`: Vitest utilities for mocking and spying

### Common Queries

- `getByText()`: Find element by text content
- `getByRole()`: Find element by ARIA role
- `getByPlaceholderText()`: Find input by placeholder
- `getByTestId()`: Find element by data-testid attribute
- `queryBy*()`: Same as getBy\* but returns null if not found
- `findBy*()`: Async version of getBy\* for elements that appear after async operations

### Testing User Interactions

```typescript
import { fireEvent } from "@testing-library/react";

it("handles user input", () => {
  render(<InputComponent />);
  const input = screen.getByRole("textbox");
  fireEvent.change(input, { target: { value: "new value" } });
  expect(input).toHaveValue("new value");
});
```

## Mocks

### Next.js Router

The Next.js router is automatically mocked in `src/test/setup.ts`:

```typescript
// Available in all tests
const mockRouter = {
  push: vi.fn(),
  replace: vi.fn(),
  prefetch: vi.fn(),
  back: vi.fn(),
  forward: vi.fn(),
  refresh: vi.fn(),
};
```

### Next.js Image Component

The Next.js Image component is mocked to return a regular img element.

### CSS Modules

CSS modules are mocked globally. For specific components, you can override the mock:

```typescript
vi.mock("@/path/to/styles.module.scss", () => ({
  default: {
    // Your specific class names
  },
}));
```

## Best Practices

1. **Test behavior, not implementation**: Focus on what the component does, not how it does it
2. **Use semantic queries**: Prefer `getByRole` and `getByText` over `getByTestId`
3. **Test accessibility**: Use ARIA roles and labels in your tests
4. **Keep tests simple**: Each test should focus on one specific behavior
5. **Use descriptive test names**: Test names should clearly describe what is being tested
6. **Mock external dependencies**: Mock API calls, router, and other external dependencies

## Example Test Files

- `src/test/example.test.ts`: Basic test examples
- `src/components/__tests__/Header.test.tsx`: Component test example

## Troubleshooting

### CSS Module Issues

If you encounter CSS module errors, ensure the module is properly mocked in your test file.

### PostCSS Issues

The test environment disables CSS processing to avoid PostCSS configuration issues. If you need CSS in tests, consider using a CSS-in-JS solution or mocking styles.

### TypeScript Errors

If you see TypeScript errors about missing exports from 'vitest', these are likely false positives. The tests should still run correctly.
