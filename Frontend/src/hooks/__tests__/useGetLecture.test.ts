import { describe, it, expect, vi, beforeEach } from "vitest";
import { renderHook, waitFor } from "@testing-library/react";
import { useGetLecture } from "../useGetLecture";

// Mock the fetch function
global.fetch = vi.fn() as unknown as typeof fetch;

describe("useGetLecture", () => {
  beforeEach(() => {
    vi.clearAllMocks();
  });

  it("should fetch lecture data successfully", async () => {
    const mockLecture = {
      id: 40,
      name: "Introducción a Python",
      description: "Primeros pasos con Python, instalación y configuración.",
      slug: "introduccion-a-python",
      video_url: "https://www.youtube.com/watch?v=dQw4w9WgXcQ",
    };

    // Mock successful fetch response
    (fetch as unknown as ReturnType<typeof vi.fn>).mockResolvedValueOnce({
      ok: true,
      json: async () => mockLecture,
    });

    const { result } = renderHook(() => useGetLecture("curso-de-python", "40"));

    await waitFor(() => {
      expect(result.current.lecture).toEqual(mockLecture);
      expect(result.current.loading).toBe(false);
      expect(result.current.error).toBe(null);
    });

    expect(fetch).toHaveBeenCalledWith(
      "http://localhost:8000/courses/curso-de-python/lectures/40"
    );
  });

  it("should handle fetch error", async () => {
    // Mock failed fetch response
    (fetch as unknown as ReturnType<typeof vi.fn>).mockRejectedValueOnce(
      new Error("Network error")
    );

    const { result } = renderHook(() => useGetLecture("curso-de-python", "40"));

    await waitFor(() => {
      expect(result.current.error).toBe("Network error");
      expect(result.current.loading).toBe(false);
      expect(result.current.lecture).toBe(null);
    });
  });

  it("should handle non-ok response", async () => {
    // Mock non-ok response
    (fetch as unknown as ReturnType<typeof vi.fn>).mockResolvedValueOnce({
      ok: false,
      status: 404,
      statusText: "Not Found",
    });

    const { result } = renderHook(() =>
      useGetLecture("curso-de-python", "999")
    );

    await waitFor(() => {
      expect(result.current.error).toBe("HTTP error! status: 404");
      expect(result.current.loading).toBe(false);
      expect(result.current.lecture).toBe(null);
    });
  });

  it("should handle response without id", async () => {
    const mockLectureWithoutId = {
      name: "Test Lecture",
      description: "Test description",
    };

    // Mock response without required id field
    (fetch as unknown as ReturnType<typeof vi.fn>).mockResolvedValueOnce({
      ok: true,
      json: async () => mockLectureWithoutId,
    });

    const { result } = renderHook(() => useGetLecture("curso-de-python", "40"));

    await waitFor(() => {
      expect(result.current.error).toBe("Error al obtener la clase");
      expect(result.current.loading).toBe(false);
      expect(result.current.lecture).toBe(null);
    });
  });

  it("should not fetch when courseSlug is empty", () => {
    const { result } = renderHook(() => useGetLecture("", "40"));

    expect(result.current.loading).toBe(true);
    expect(result.current.lecture).toBe(null);
    expect(result.current.error).toBe(null);
    expect(fetch).not.toHaveBeenCalled();
  });

  it("should not fetch when lectureId is empty", () => {
    const { result } = renderHook(() => useGetLecture("curso-de-python", ""));

    expect(result.current.loading).toBe(true);
    expect(result.current.lecture).toBe(null);
    expect(result.current.error).toBe(null);
    expect(fetch).not.toHaveBeenCalled();
  });

  it("should refetch when courseSlug or lectureId changes", async () => {
    const mockLecture1 = {
      id: 40,
      name: "Lecture 1",
      description: "Description 1",
      slug: "lecture-1",
      video_url: "https://www.youtube.com/watch?v=test1",
    };

    const mockLecture2 = {
      id: 41,
      name: "Lecture 2",
      description: "Description 2",
      slug: "lecture-2",
      video_url: "https://www.youtube.com/watch?v=test2",
    };

    // Mock first response
    (fetch as unknown as ReturnType<typeof vi.fn>).mockResolvedValueOnce({
      ok: true,
      json: async () => mockLecture1,
    });

    const { result, rerender } = renderHook(
      ({ courseSlug, lectureId }) => useGetLecture(courseSlug, lectureId),
      {
        initialProps: { courseSlug: "curso-de-python", lectureId: "40" },
      }
    );

    await waitFor(() => {
      expect(result.current.lecture).toEqual(mockLecture1);
    });

    // Mock second response
    (fetch as unknown as ReturnType<typeof vi.fn>).mockResolvedValueOnce({
      ok: true,
      json: async () => mockLecture2,
    });

    // Change lectureId
    rerender({ courseSlug: "curso-de-python", lectureId: "41" });

    await waitFor(() => {
      expect(result.current.lecture).toEqual(mockLecture2);
    });

    expect(fetch).toHaveBeenCalledTimes(2);
    expect(fetch).toHaveBeenNthCalledWith(
      1,
      "http://localhost:8000/courses/curso-de-python/lectures/40"
    );
    expect(fetch).toHaveBeenNthCalledWith(
      2,
      "http://localhost:8000/courses/curso-de-python/lectures/41"
    );
  });

  it("should handle unknown errors", async () => {
    // Mock non-Error object rejection
    (fetch as unknown as ReturnType<typeof vi.fn>).mockRejectedValueOnce(
      "Unknown string error"
    );

    const { result } = renderHook(() => useGetLecture("curso-de-python", "40"));

    await waitFor(() => {
      expect(result.current.error).toBe("Error desconocido");
      expect(result.current.loading).toBe(false);
      expect(result.current.lecture).toBe(null);
    });
  });

  it("should maintain initial loading state before fetch", () => {
    // Mock a never-resolving promise to keep loading state
    (fetch as unknown as ReturnType<typeof vi.fn>).mockImplementation(
      () => new Promise(() => {})
    );

    const { result } = renderHook(() => useGetLecture("curso-de-python", "40"));

    expect(result.current.loading).toBe(true);
    expect(result.current.lecture).toBe(null);
    expect(result.current.error).toBe(null);
  });

  it("should handle 500 server error", async () => {
    // Mock server error response
    (fetch as unknown as ReturnType<typeof vi.fn>).mockResolvedValueOnce({
      ok: false,
      status: 500,
      statusText: "Internal Server Error",
    });

    const { result } = renderHook(() => useGetLecture("curso-de-python", "40"));

    await waitFor(() => {
      expect(result.current.error).toBe("HTTP error! status: 500");
      expect(result.current.loading).toBe(false);
      expect(result.current.lecture).toBe(null);
    });
  });

  it("should handle invalid JSON response", async () => {
    // Mock response with invalid JSON
    (fetch as unknown as ReturnType<typeof vi.fn>).mockResolvedValueOnce({
      ok: true,
      json: async () => {
        throw new Error("Invalid JSON");
      },
    });

    const { result } = renderHook(() => useGetLecture("curso-de-python", "40"));

    await waitFor(() => {
      expect(result.current.error).toBe("Invalid JSON");
      expect(result.current.loading).toBe(false);
      expect(result.current.lecture).toBe(null);
    });
  });
});
