SET NOCOUNT ON;

-- Roles base
IF NOT EXISTS (SELECT 1 FROM dbo.CatRoles)
BEGIN
    INSERT INTO dbo.CatRoles (Nombre, Descripcion)
    VALUES ('Admin', 'Administrador del sistema'),
           ('Encargado', 'Supervisor de operaciones'),
           ('Vendedor', 'Vendedor / Cajero'),
           ('Almacenista', 'Control de inventario'),
           ('Chofer', 'Distribución y entregas');
END;

-- Usuario administrador demo
IF NOT EXISTS (SELECT 1 FROM dbo.CatUsuarios WHERE Correo = 'admin@ferre.com')
BEGIN
    DECLARE @pRolAdmin INT = (SELECT TOP 1 RolId FROM dbo.CatRoles WHERE Nombre = 'Admin');
    INSERT INTO dbo.CatUsuarios (Nombre, Correo, ContrasenaHash, RolId)
    VALUES ('Administrador', 'admin@ferre.com', 0x00, @pRolAdmin);
END;

-- Categorías base
IF NOT EXISTS (SELECT 1 FROM dbo.CatCategoriasProductos)
BEGIN
    INSERT INTO dbo.CatCategoriasProductos (Nombre, Descripcion, TipoUnidad)
    VALUES ('Madera de Pino', 'Subfamilia madera', 'pie³'),
           ('Polvos', 'Cemento, morteros y similares', 'saco'),
           ('Mampostería', 'Bloques y tabiques', 'pieza'),
           ('Ferretería y Herramientas', 'Herramientas manuales', 'pieza'),
           ('Plomería', 'Accesorios hidráulicos', 'pieza'),
           ('Agregados', 'Arena, grava, etc.', 'm³'),
           ('Acero', 'Varilla, perfiles y más', 'kg'),
           ('Poliestireno', 'Aislantes', 'm²');
END;

-- Ubicaciones base
IF NOT EXISTS (SELECT 1 FROM dbo.CatUbicaciones)
BEGIN
    INSERT INTO dbo.CatUbicaciones (Nombre, Tipo)
    VALUES ('Almacén Central', 'Bodega'),
           ('Patio Norte', 'Patio'),
           ('Bodega Polvos', 'Bodega');
END;

-- Clientes demo
IF NOT EXISTS (SELECT 1 FROM dbo.CatClientes)
BEGIN
    INSERT INTO dbo.CatClientes (Nombre, RFC, Segmento, Telefono)
    VALUES ('Constructora Alfa', 'AAL123456789', 'Constructoras', '555-000-0001'),
           ('Residencial La Paz', 'RLP456789123', 'Residenciales', '555-000-0002');
END;

-- Campañas demo
IF NOT EXISTS (SELECT 1 FROM dbo.MarketingCampanias)
BEGIN
    INSERT INTO dbo.MarketingCampanias (Nombre, Canal, FechaInicio, Presupuesto)
    VALUES ('Promo cemento primavera', 'WhatsApp', GETDATE(), 5000),
           ('Fidelización puntos PRO', 'Email', DATEADD(DAY, -10, GETDATE()), 2500);
END;
