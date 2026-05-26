# ServeRest API Automation - Karate DSL Professional Framework

Este proyecto implementa una suite de pruebas automatizadas de alto nivel para la API de [ServeRest](https://serverest.dev/), enfocada en la gestión de usuarios. La arquitectura ha sido diseñada siguiendo estándares de ingeniería de software para garantizar pruebas robustas, independientes y mantenibles.

## 🚀 Características Principales

* **Patrón de Diseño Caller-Callee:** Centralización de la lógica de negocio en `user-service.feature`. Los tests de usuario no repiten lógica de creación o borrado, sino que invocan servicios reutilizables.
* **Gestión Dinámica de Datos:** Implementación de generadores de datos aleatorios (UUID y Math.random) para evitar colisiones de emails y asegurar que cada ejecución sea única e independiente.
* **Validación de Contratos (Schema Testing):** Uso de `user-schema.json` con *Fuzzy Matchers* y *Regex* para asegurar que la API cumpla con los tipos de datos y formatos esperados (Emails, IDs, etc.).
* **Cobertura Dual:** Cada funcionalidad incluye escenarios **Positivos** (Happy Path) y **Negativos** (Manejo de errores 400), fusionados en archivos `.feature` cohesivos.
* **Zero-Conflict Execution:** Diseñado para correr en entornos compartidos mediante la creación y limpieza dinámica de usuarios.

## 🛠️ Requisitos Técnicos

* **Java JDK 11+**
* **Apache Maven**
* **Karate DSL Engine**

## 📁 Estructura del Framework

```text
src/test/java/users/
├── post_user.feature        # Registro con validación de duplicados
├── get_users.feature        # Listado masivo con validación de contrato
├── get_user_by_id.feature   # Búsqueda dinámica por ID
├── put_user.feature         # Actualización con persistencia de identidad
├── delete_user.feature      # Flujo completo de creación y borrado
├── user-service.feature     # CAPA DE SERVICIO (Reutilizable)
└── user-schema.json         # ESQUEMAS DE DATOS (Centralizados)