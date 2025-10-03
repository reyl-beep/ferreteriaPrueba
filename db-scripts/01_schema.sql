IF NOT EXISTS (SELECT 1 FROM sys.schemas WHERE name = 'dbo')
    EXEC('CREATE SCHEMA dbo');
GO

-- Tablas de catálogo y seguridad
IF OBJECT_ID('dbo.CatRoles', 'U') IS NULL
BEGIN
    CREATE TABLE dbo.CatRoles (
        RolId INT IDENTITY(1,1) PRIMARY KEY,
        Nombre VARCHAR(50) NOT NULL,
        Descripcion VARCHAR(250) NULL,
        FechaAlta DATETIME2 NOT NULL DEFAULT SYSDATETIME(),
        Activo BIT NOT NULL DEFAULT 1
    );
END;
GO

IF OBJECT_ID('dbo.CatUsuarios', 'U') IS NULL
BEGIN
    CREATE TABLE dbo.CatUsuarios (
        UsuarioId INT IDENTITY(1,1) PRIMARY KEY,
        Nombre VARCHAR(100) NOT NULL,
        Correo VARCHAR(150) NOT NULL UNIQUE,
        ContrasenaHash VARBINARY(256) NOT NULL,
        Activo BIT NOT NULL DEFAULT 1,
        RolId INT NOT NULL,
        FechaAlta DATETIME2 NOT NULL DEFAULT SYSDATETIME(),
        CONSTRAINT FK_CatUsuarios_CatRoles FOREIGN KEY (RolId) REFERENCES dbo.CatRoles (RolId)
    );
END;
GO

IF OBJECT_ID('dbo.CatClientes', 'U') IS NULL
BEGIN
    CREATE TABLE dbo.CatClientes (
        ClienteId INT IDENTITY(1,1) PRIMARY KEY,
        Nombre VARCHAR(150) NOT NULL,
        RFC VARCHAR(20) NULL,
        Segmento VARCHAR(50) NULL,
        Telefono VARCHAR(30) NULL,
        Correo VARCHAR(150) NULL,
        Direccion VARCHAR(250) NULL,
        FechaAlta DATETIME2 NOT NULL DEFAULT SYSDATETIME(),
        Activo BIT NOT NULL DEFAULT 1
    );
END;
GO

-- Catálogos específicos de productos
IF OBJECT_ID('dbo.CatCategoriasProductos', 'U') IS NULL
BEGIN
    CREATE TABLE dbo.CatCategoriasProductos (
        CategoriaId INT IDENTITY(1,1) PRIMARY KEY,
        Nombre VARCHAR(80) NOT NULL,
        Descripcion VARCHAR(250) NULL,
        TipoUnidad VARCHAR(30) NOT NULL,
        FechaAlta DATETIME2 NOT NULL DEFAULT SYSDATETIME(),
        Activo BIT NOT NULL DEFAULT 1
    );
END;
GO

IF OBJECT_ID('dbo.CatProductos', 'U') IS NULL
BEGIN
    CREATE TABLE dbo.CatProductos (
        ProductoId INT IDENTITY(1,1) PRIMARY KEY,
        CategoriaId INT NOT NULL,
        Sku VARCHAR(40) NOT NULL,
        Nombre VARCHAR(120) NOT NULL,
        Descripcion VARCHAR(300) NULL,
        UnidadBase VARCHAR(20) NOT NULL,
        CodigoBarras VARCHAR(80) NULL,
        UrlFoto VARCHAR(200) NULL,
        Activo BIT NOT NULL DEFAULT 1,
        FechaAlta DATETIME2 NOT NULL DEFAULT SYSDATETIME(),
        CONSTRAINT FK_CatProductos_CatCategoriasProductos FOREIGN KEY (CategoriaId) REFERENCES dbo.CatCategoriasProductos (CategoriaId)
    );
END;
GO

IF OBJECT_ID('dbo.CatUbicaciones', 'U') IS NULL
BEGIN
    CREATE TABLE dbo.CatUbicaciones (
        UbicacionId INT IDENTITY(1,1) PRIMARY KEY,
        Nombre VARCHAR(80) NOT NULL,
        Tipo VARCHAR(50) NOT NULL,
        Direccion VARCHAR(250) NULL,
        Activo BIT NOT NULL DEFAULT 1
    );
END;
GO

-- Inventario y lotes
IF OBJECT_ID('dbo.InventarioLotes', 'U') IS NULL
BEGIN
    CREATE TABLE dbo.InventarioLotes (
        LoteId INT IDENTITY(1,1) PRIMARY KEY,
        ProductoId INT NOT NULL,
        UbicacionId INT NOT NULL,
        Cantidad DECIMAL(18,4) NOT NULL,
        Unidad VARCHAR(20) NOT NULL,
        Lote VARCHAR(50) NULL,
        Caducidad DATE NULL,
        UltimaActualizacion DATETIME2 NOT NULL DEFAULT SYSDATETIME(),
        CONSTRAINT FK_InventarioLotes_CatProductos FOREIGN KEY (ProductoId) REFERENCES dbo.CatProductos (ProductoId),
        CONSTRAINT FK_InventarioLotes_CatUbicaciones FOREIGN KEY (UbicacionId) REFERENCES dbo.CatUbicaciones (UbicacionId)
    );
END;
GO

IF OBJECT_ID('dbo.InventarioMovimientos', 'U') IS NULL
BEGIN
    CREATE TABLE dbo.InventarioMovimientos (
        MovimientoId INT IDENTITY(1,1) PRIMARY KEY,
        ProductoId INT NOT NULL,
        UbicacionOrigenId INT NULL,
        UbicacionDestinoId INT NULL,
        Tipo VARCHAR(30) NOT NULL,
        Cantidad DECIMAL(18,4) NOT NULL,
        Unidad VARCHAR(20) NOT NULL,
        Motivo VARCHAR(150) NULL,
        FechaRegistro DATETIME2 NOT NULL DEFAULT SYSDATETIME(),
        UsuarioId INT NULL,
        CONSTRAINT FK_InventarioMovimientos_CatProductos FOREIGN KEY (ProductoId) REFERENCES dbo.CatProductos (ProductoId),
        CONSTRAINT FK_InventarioMovimientos_Usuario FOREIGN KEY (UsuarioId) REFERENCES dbo.CatUsuarios (UsuarioId)
    );
END;
GO

-- Precios
IF OBJECT_ID('dbo.CatListasPrecios', 'U') IS NULL
BEGIN
    CREATE TABLE dbo.CatListasPrecios (
        ListaPrecioId INT IDENTITY(1,1) PRIMARY KEY,
        Nombre VARCHAR(80) NOT NULL,
        Segmento VARCHAR(50) NULL,
        AjustePorcentaje DECIMAL(9,4) NOT NULL DEFAULT 0,
        VigenciaInicio DATE NULL,
        VigenciaFin DATE NULL,
        FechaAlta DATETIME2 NOT NULL DEFAULT SYSDATETIME(),
        Activo BIT NOT NULL DEFAULT 1
    );
END;
GO

IF OBJECT_ID('dbo.PreciosProductos', 'U') IS NULL
BEGIN
    CREATE TABLE dbo.PreciosProductos (
        PrecioProductoId INT IDENTITY(1,1) PRIMARY KEY,
        ProductoId INT NOT NULL,
        ListaPrecioId INT NOT NULL,
        PrecioBase DECIMAL(18,4) NOT NULL,
        Unidad VARCHAR(20) NOT NULL,
        FechaInicio DATE NOT NULL,
        FechaFin DATE NULL,
        Activo BIT NOT NULL DEFAULT 1,
        CONSTRAINT FK_PreciosProductos_CatProductos FOREIGN KEY (ProductoId) REFERENCES dbo.CatProductos (ProductoId),
        CONSTRAINT FK_PreciosProductos_CatListasPrecios FOREIGN KEY (ListaPrecioId) REFERENCES dbo.CatListasPrecios (ListaPrecioId)
    );
END;
GO

-- Ventas y cotizaciones
IF OBJECT_ID('dbo.Cotizaciones', 'U') IS NULL
BEGIN
    CREATE TABLE dbo.Cotizaciones (
        CotizacionId INT IDENTITY(1,1) PRIMARY KEY,
        ClienteId INT NOT NULL,
        Fecha DATETIME2 NOT NULL DEFAULT SYSDATETIME(),
        ValidezDias INT NOT NULL,
        Estatus VARCHAR(30) NOT NULL DEFAULT 'Pendiente',
        Total DECIMAL(18,4) NOT NULL DEFAULT 0,
        UsuarioId INT NULL,
        CONSTRAINT FK_Cotizaciones_CatClientes FOREIGN KEY (ClienteId) REFERENCES dbo.CatClientes (ClienteId)
    );
END;
GO

IF OBJECT_ID('dbo.CotizacionesDetalle', 'U') IS NULL
BEGIN
    CREATE TABLE dbo.CotizacionesDetalle (
        CotizacionDetalleId INT IDENTITY(1,1) PRIMARY KEY,
        CotizacionId INT NOT NULL,
        ProductoId INT NOT NULL,
        Cantidad DECIMAL(18,4) NOT NULL,
        Unidad VARCHAR(20) NOT NULL,
        PrecioUnitario DECIMAL(18,4) NOT NULL,
        Descuento DECIMAL(9,4) NOT NULL DEFAULT 0,
        CONSTRAINT FK_CotizacionesDetalle_Cotizaciones FOREIGN KEY (CotizacionId) REFERENCES dbo.Cotizaciones (CotizacionId),
        CONSTRAINT FK_CotizacionesDetalle_CatProductos FOREIGN KEY (ProductoId) REFERENCES dbo.CatProductos (ProductoId)
    );
END;
GO

IF OBJECT_ID('dbo.Ventas', 'U') IS NULL
BEGIN
    CREATE TABLE dbo.Ventas (
        VentaId INT IDENTITY(1,1) PRIMARY KEY,
        CotizacionId INT NULL,
        ClienteId INT NOT NULL,
        Fecha DATETIME2 NOT NULL DEFAULT SYSDATETIME(),
        Total DECIMAL(18,4) NOT NULL,
        UsuarioId INT NULL,
        MetodoPago VARCHAR(30) NULL,
        CONSTRAINT FK_Ventas_Cotizaciones FOREIGN KEY (CotizacionId) REFERENCES dbo.Cotizaciones (CotizacionId),
        CONSTRAINT FK_Ventas_CatClientes FOREIGN KEY (ClienteId) REFERENCES dbo.CatClientes (ClienteId)
    );
END;
GO

IF OBJECT_ID('dbo.VentasDetalle', 'U') IS NULL
BEGIN
    CREATE TABLE dbo.VentasDetalle (
        VentaDetalleId INT IDENTITY(1,1) PRIMARY KEY,
        VentaId INT NOT NULL,
        ProductoId INT NOT NULL,
        Cantidad DECIMAL(18,4) NOT NULL,
        Unidad VARCHAR(20) NOT NULL,
        PrecioUnitario DECIMAL(18,4) NOT NULL,
        Descuento DECIMAL(9,4) NOT NULL DEFAULT 0,
        CONSTRAINT FK_VentasDetalle_Ventas FOREIGN KEY (VentaId) REFERENCES dbo.Ventas (VentaId),
        CONSTRAINT FK_VentasDetalle_CatProductos FOREIGN KEY (ProductoId) REFERENCES dbo.CatProductos (ProductoId)
    );
END;
GO

-- Servicio a domicilio
IF OBJECT_ID('dbo.DomicilioRutas', 'U') IS NULL
BEGIN
    CREATE TABLE dbo.DomicilioRutas (
        RutaId INT IDENTITY(1,1) PRIMARY KEY,
        VentaId INT NOT NULL,
        ChoferId INT NOT NULL,
        FechaSalida DATETIME2 NOT NULL,
        FechaEntrega DATETIME2 NULL,
        FirmaEntrega VARBINARY(MAX) NULL,
        Estatus VARCHAR(30) NOT NULL DEFAULT 'Programado',
        CONSTRAINT FK_DomicilioRutas_Ventas FOREIGN KEY (VentaId) REFERENCES dbo.Ventas (VentaId),
        CONSTRAINT FK_DomicilioRutas_Chofer FOREIGN KEY (ChoferId) REFERENCES dbo.CatUsuarios (UsuarioId)
    );
END;
GO

-- Empleados y tareas
IF OBJECT_ID('dbo.CatEmpleados', 'U') IS NULL
BEGIN
    CREATE TABLE dbo.CatEmpleados (
        EmpleadoId INT IDENTITY(1,1) PRIMARY KEY,
        UsuarioId INT NULL,
        Nombre VARCHAR(120) NOT NULL,
        Rol VARCHAR(50) NOT NULL,
        Activo BIT NOT NULL DEFAULT 1,
        CONSTRAINT FK_CatEmpleados_Usuario FOREIGN KEY (UsuarioId) REFERENCES dbo.CatUsuarios (UsuarioId)
    );
END;
GO

IF OBJECT_ID('dbo.EmpleadosTareas', 'U') IS NULL
BEGIN
    CREATE TABLE dbo.EmpleadosTareas (
        TareaId INT IDENTITY(1,1) PRIMARY KEY,
        EmpleadoId INT NOT NULL,
        Descripcion VARCHAR(200) NOT NULL,
        Estatus VARCHAR(30) NOT NULL DEFAULT 'Pendiente',
        FechaRegistro DATETIME2 NOT NULL DEFAULT SYSDATETIME(),
        CONSTRAINT FK_EmpleadosTareas_CatEmpleados FOREIGN KEY (EmpleadoId) REFERENCES dbo.CatEmpleados (EmpleadoId)
    );
END;
GO

-- Marketing
IF OBJECT_ID('dbo.MarketingCampanias', 'U') IS NULL
BEGIN
    CREATE TABLE dbo.MarketingCampanias (
        CampaniaId INT IDENTITY(1,1) PRIMARY KEY,
        Nombre VARCHAR(150) NOT NULL,
        Canal VARCHAR(50) NOT NULL,
        FechaInicio DATE NOT NULL,
        FechaFin DATE NULL,
        Presupuesto DECIMAL(18,4) NULL,
        MetaROI DECIMAL(9,4) NULL,
        FechaAlta DATETIME2 NOT NULL DEFAULT SYSDATETIME()
    );
END;
GO

IF OBJECT_ID('dbo.MarketingSeguimiento', 'U') IS NULL
BEGIN
    CREATE TABLE dbo.MarketingSeguimiento (
        SeguimientoId INT IDENTITY(1,1) PRIMARY KEY,
        CampaniaId INT NOT NULL,
        Clics INT NOT NULL DEFAULT 0,
        Visitas INT NOT NULL DEFAULT 0,
        Conversiones INT NOT NULL DEFAULT 0,
        FechaCorte DATE NOT NULL,
        CONSTRAINT FK_MarketingSeguimiento_Campanias FOREIGN KEY (CampaniaId) REFERENCES dbo.MarketingCampanias (CampaniaId)
    );
END;
GO

-- Auditoría
IF OBJECT_ID('dbo.LogActividadUsuario', 'U') IS NULL
BEGIN
    CREATE TABLE dbo.LogActividadUsuario (
        LogId INT IDENTITY(1,1) PRIMARY KEY,
        UsuarioId INT NULL,
        Accion VARCHAR(100) NOT NULL,
        Modulo VARCHAR(80) NOT NULL,
        Fecha DATETIME2 NOT NULL DEFAULT SYSDATETIME(),
        Detalle VARCHAR(500) NULL
    );
END;
GO
