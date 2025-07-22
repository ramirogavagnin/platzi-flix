import { useEffect, useState } from "react";
import { LectureResponse } from "@/types";

export const useGetLecture = (courseSlug: string, lectureId: string) => {
  const [lecture, setLecture] = useState<LectureResponse | null>(null);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState<string | null>(null);

  useEffect(() => {
    const fetchLecture = async () => {
      try {
        setLoading(true);
        const response = await fetch(
          `http://localhost:8000/courses/${courseSlug}/lectures/${lectureId}`
        );

        if (!response.ok) {
          throw new Error(`HTTP error! status: ${response.status}`);
        }

        const data: LectureResponse = await response.json();

        if (data?.id) {
          setLecture(data);
        } else {
          throw new Error("Error al obtener la clase");
        }
      } catch (err) {
        setError(err instanceof Error ? err.message : "Error desconocido");
      } finally {
        setLoading(false);
      }
    };

    if (courseSlug && lectureId) {
      fetchLecture();
    }
  }, [courseSlug, lectureId]);

  return { lecture, loading, error };
};
