import { describe, it, expect, vi, beforeEach } from "vitest";
import { renderHook, waitFor } from "@testing-library/react";
import { useGetCourses } from "../useGetCourses";

// Mock the fetch function
global.fetch = vi.fn() as unknown as typeof fetch;

describe("useGetCourses", () => {
  beforeEach(() => {
    vi.clearAllMocks();
  });

  it("should fetch courses successfully", async () => {
    const mockCourses = [
      {
        id: "1",
        title: "React Course",
        description: "Learn React",
        teacher: { name: "John Doe" },
        image: "react.jpg",
        duration: "10 hours",
        level: "Beginner",
        rating: 4.5,
        students: 1000,
        price: 29.99,
        slug: "react-course",
      },
    ];

    // Mock successful fetch response
    (fetch as unknown as ReturnType<typeof vi.fn>).mockResolvedValueOnce({
      ok: true,
      json: async () => mockCourses,
    });

    const { result } = renderHook(() => useGetCourses());

    await waitFor(() => {
      expect(result.current.courses).toEqual(mockCourses);
      expect(result.current.loading).toBe(false);
      expect(result.current.error).toBe(null);
    });
  });

  it("should handle fetch error", async () => {
    // Mock failed fetch response
    (fetch as unknown as ReturnType<typeof vi.fn>).mockRejectedValueOnce(
      new Error("Network error")
    );

    const { result } = renderHook(() => useGetCourses());

    await waitFor(() => {
      expect(result.current.error).toBe("Network error");
      expect(result.current.loading).toBe(false);
      expect(result.current.courses).toEqual([]);
    });
  });

  it("should handle non-ok response", async () => {
    // Mock non-ok response
    (fetch as unknown as ReturnType<typeof vi.fn>).mockResolvedValueOnce({
      ok: false,
      status: 500,
      statusText: "Internal Server Error",
    });

    const { result } = renderHook(() => useGetCourses());

    await waitFor(() => {
      expect(result.current.error).toBe("HTTP error! status: 500");
      expect(result.current.loading).toBe(false);
      expect(result.current.courses).toEqual([]);
    });
  });
});
