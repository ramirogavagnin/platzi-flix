/// <reference types="vitest" />

declare module "vitest" {
  interface Assertion<T = unknown> {
    toBeInTheDocument(): T;
    toHaveClass(className: string): T;
    toHaveTextContent(text: string): T;
    toBeVisible(): T;
    toBeDisabled(): T;
    toBeEnabled(): T;
    toHaveAttribute(attr: string, value?: string): T;
    toHaveValue(value: string | number | string[]): T;
    toBeChecked(): T;
    toBePartiallyChecked(): T;
    toHaveFocus(): T;
    toHaveFormValues(expectedValues: Record<string, unknown>): T;
    toHaveDisplayValue(value: string | RegExp | (string | RegExp)[]): T;
    toBeRequired(): T;
    toBeInvalid(): T;
    toBeValid(): T;
    toHaveAccessibleDescription(
      expectedAccessibleDescription?: string | RegExp
    ): T;
    toHaveAccessibleName(expectedAccessibleName?: string | RegExp): T;
    toHaveErrorMessage(expectedErrorMessage?: string | RegExp): T;
  }
}
