# Sistema POS Empresarial - Ferretería

Este repositorio contiene el scaffolding inicial para un sistema de Punto de Venta empresarial orientado a ferreterías y materiales de construcción. El proyecto se divide en tres carpetas principales:

- `frontend`: Aplicación web PWA construida con Vue 3 + TypeScript.
- `backend`: API minimalista en .NET preparada para SQL Server 2014 mediante stored procedures.
- `db-scripts`: Scripts SQL que definen el esquema, procedimientos almacenados, disparadores y datos semilla.

## Requisitos previos

- Node.js 18+
- npm o pnpm
- .NET 7 SDK (compatible con Visual Studio 2022)
- SQL Server 2014 o superior

## Configuración rápida

1. **Backend**
   ```bash
   cd backend
   dotnet restore
   dotnet user-secrets init
   dotnet user-secrets set "ConnectionStrings:Default" "Server=localhost;Database=FerreteriaPOS;Trusted_Connection=True;"
   dotnet run
   ```
   La API redirige automáticamente a `/swagger`. Para pruebas locales el redireccionamiento HTTPS está comentado en `Program.cs` y puede habilitarse fácilmente cuando se requiera.

2. **Frontend**
   ```bash
   cd frontend
   npm install
   npm run dev
   ```
   El cliente está configurado como PWA (modo `autoUpdate`) y emplea un modo demo offline cuando no hay conexión con la API.

3. **Base de datos**
   ```bash
   cd db-scripts
   sqlcmd -S localhost -i 01_schema.sql
   sqlcmd -S localhost -i 02_storeds_catalogos.sql
   sqlcmd -S localhost -i 02_storeds_inventario.sql
   sqlcmd -S localhost -i 02_storeds_ventas.sql
   sqlcmd -S localhost -i 02_storeds_marketing.sql
   sqlcmd -S localhost -i 02_storeds_seguridad.sql
   sqlcmd -S localhost -i 03_triggers_inventario.sql
   sqlcmd -S localhost -i 99_seed.sql
   ```

## Scripts útiles

- `frontend`
  - `npm run dev`: Servidor de desarrollo.
  - `npm run build`: Compilación de producción.
  - `npm run preview`: Vista previa local.
  - `npm run lint`: Linter con ESLint.
  - `npm run test`: Pruebas unitarias con Vitest.

- `backend`
  - `dotnet restore`
  - `dotnet build`
  - `dotnet run`
  - `dotnet watch run`
  - Pruebas: `dotnet test`.

## Colección de requests

Dentro de `backend/requests.http` se incluye una colección de ejemplos para probar endpoints críticos usando VS Code REST Client.

## Buenas prácticas

- Todo acceso a datos en backend utiliza stored procedures respetando la convención `proc(Modulo)(Accion)`.
- Cada stored procedure define y gestiona `@pResultado` y `@pMsg`.
- El frontend centraliza el manejo de respuestas y notificaciones.

## Próximos pasos

- Implementar lógica de negocio detallada en los endpoints.
- Completar los tests de integración y unitarios.
- Ajustar los scripts SQL según el modelo definitivo.
- Configurar CI/CD y despliegues automatizados.

