import { test, expect } from "@playwright/test";

test.describe("Reproductor de Video en Cursos", () => {
  test.beforeEach(async ({ page }) => {
    // Configurar viewport para mejor visualización
    await page.setViewportSize({ width: 1280, height: 720 });
  });

  test("Scenario: Navegación al curso de React y verificación del reproductor", async ({
    page,
  }) => {
    // Dado que navego a la página principal
    await page.goto("http://localhost:3000/");
    await expect(page.locator("h1")).toBeVisible();

    // Cuando hago clic en el curso "Curso de React"
    const courseCard = page.locator("text=Curso de React").first();
    await courseCard.click();

    // Verificar que navegamos a la página del curso
    await expect(page).toHaveURL(/\/courses\/curso-de-react/);

    // Y hago clic en la primera lección "Introducción a React"
    const firstLesson = page.locator(".lessonItem").first();
    await firstLesson.click();

    // Verificar que navegamos a la página de la lección
    await expect(page).toHaveURL(/\/lectures\/37/);

    // Entonces debería ver el reproductor de video
    const videoPlayer = page.locator(".playerContainer");
    await expect(videoPlayer).toBeVisible();

    // Y el reproductor debería estar cargando el video de YouTube
    const iframe = page.locator('iframe[src*="youtube.com"]');
    await expect(iframe).toBeVisible();

    // Y debería poder ver el título de la lección "Introducción a React"
    const lectureTitle = page.locator(".lectureTitle");
    await expect(lectureTitle).toContainText("Introducción a React");
  });

  test("Scenario: Verificación del reproductor de video funcional", async ({
    page,
  }) => {
    // Dado que estoy en la página de la lección "Introducción a React"
    await page.goto("http://localhost:3000/lectures/37");
    await expect(page.locator(".lectureTitle")).toContainText(
      "Introducción a React"
    );

    // Cuando el video termina de cargar
    const iframe = page.locator('iframe[src*="youtube.com"]');
    await expect(iframe).toBeVisible();

    // Esperar a que el overlay de carga desaparezca
    const loadingOverlay = page.locator(".loadingOverlay");
    await expect(loadingOverlay).not.toBeVisible();

    // Entonces debería ver el iframe de YouTube embebido
    await expect(iframe).toBeVisible();

    // Verificar que el src contiene youtube.com/embed
    const src = await iframe.getAttribute("src");
    expect(src).toContain("youtube.com/embed");

    // Y el reproductor debería tener controles de reproducción
    const allow = await iframe.getAttribute("allow");
    expect(allow).toContain("autoplay");

    // Y debería poder hacer clic en el botón de pantalla completa
    const allowFullScreen = await iframe.getAttribute("allowfullscreen");
    expect(allowFullScreen).toBeTruthy();

    // Y el video debería tener la URL "https://www.youtube.com/watch?v=dQw4w9WgXcQ"
    const videoId = "dQw4w9WgXcQ";
    expect(src).toContain(videoId);
  });

  test("Scenario: Estados de carga del reproductor", async ({ page }) => {
    // Dado que estoy en la página de una lección válida
    await page.goto("http://localhost:3000/lectures/37");

    // Cuando el reproductor está cargando
    // Verificar que el overlay de carga está visible inicialmente
    const loadingOverlay = page.locator(".loadingOverlay");
    await expect(loadingOverlay).toBeVisible();

    // Entonces debería ver un overlay de carga
    await expect(loadingOverlay).toBeVisible();

    // Y debería ver un spinner de carga
    const loadingSpinner = page.locator(".loadingSpinner");
    await expect(loadingSpinner).toBeVisible();

    // Y debería ver el texto "Cargando video..."
    const loadingText = page.locator("text=Cargando video...");
    await expect(loadingText).toBeVisible();

    // Cuando el video termina de cargar
    const iframe = page.locator('iframe[src*="youtube.com"]');
    await expect(iframe).toBeVisible();

    // Entonces el overlay de carga debería desaparecer
    await expect(loadingOverlay).not.toBeVisible();

    // Y el iframe del video debería ser visible
    await expect(iframe).toBeVisible();
  });

  test("Scenario: Navegación de regreso al curso", async ({ page }) => {
    // Dado que estoy en la página de una lección
    await page.goto("http://localhost:3000/lectures/37");

    // Cuando hago clic en el botón "Volver al curso"
    const backButton = page.locator("text=Volver al curso");
    await backButton.click();

    // Entonces debería regresar a la página del curso
    await expect(page).toHaveURL(/\/courses\/curso-de-react/);

    // Y debería ver la lista de lecciones disponibles
    const lessonsList = page.locator(".lessonsList");
    await expect(lessonsList).toBeVisible();
  });

  test("Scenario: Verificación de múltiples cursos", async ({ page }) => {
    // Dado que navego a la página principal
    await page.goto("http://localhost:3000/");

    // Verificar que se muestran múltiples cursos
    const courseCards = page.locator(".courseCard");
    await expect(courseCards).toHaveCount(4); // Según el código, muestra 4 cursos

    // Verificar que el curso de React está presente
    const reactCourse = page.locator("text=Curso de React");
    await expect(reactCourse).toBeVisible();

    // Verificar que el curso de Python está presente
    const pythonCourse = page.locator("text=Curso de Python");
    await expect(pythonCourse).toBeVisible();
  });

  test("Scenario: Verificación de la estructura de la página de lección", async ({
    page,
  }) => {
    // Dado que estoy en la página de una lección
    await page.goto("http://localhost:3000/lectures/37");

    // Entonces debería ver el header con botón de regreso
    const lectureHeader = page.locator(".lectureHeader");
    await expect(lectureHeader).toBeVisible();

    const backButton = page.locator(".backButton");
    await expect(backButton).toBeVisible();

    // Y debería ver la sección principal
    const lectureMain = page.locator(".lectureMain");
    await expect(lectureMain).toBeVisible();

    // Y debería ver la sección de video
    const videoSection = page.locator(".videoSection");
    await expect(videoSection).toBeVisible();

    // Y debería ver la información de la lección
    const lectureInfo = page.locator(".lectureInfo");
    await expect(lectureInfo).toBeVisible();

    // Y debería ver el título de la lección
    const lectureTitle = page.locator(".lectureTitle");
    await expect(lectureTitle).toContainText("Introducción a React");

    // Y debería ver la descripción de la lección
    const lectureDescription = page.locator(".lectureDescription");
    await expect(lectureDescription).toBeVisible();
  });
});
