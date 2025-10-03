SET ANSI_NULLS ON;
GO
SET QUOTED_IDENTIFIER ON;
GO

CREATE OR ALTER PROCEDURE procInventarioExistenciasCon
    @pResultado BIT OUTPUT,
    @pMsg VARCHAR(500) OUTPUT
AS
BEGIN
    SET NOCOUNT ON;
    BEGIN TRY
        SELECT p.ProductoId,
               p.Nombre,
               l.UbicacionId,
               u.Nombre AS Ubicacion,
               SUM(l.Cantidad) AS Cantidad,
               l.Unidad
        FROM dbo.InventarioLotes l
        INNER JOIN dbo.CatProductos p ON p.ProductoId = l.ProductoId
        INNER JOIN dbo.CatUbicaciones u ON u.UbicacionId = l.UbicacionId
        GROUP BY p.ProductoId, p.Nombre, l.UbicacionId, u.Nombre, l.Unidad;
        SET @pResultado = 1;
        SET @pMsg = 'OK';
    END TRY
    BEGIN CATCH
        SET @pResultado = 0;
        SET @pMsg = ERROR_MESSAGE();
    END CATCH
END;
GO

CREATE OR ALTER PROCEDURE procInventarioEntradasIns
    @pProductoId INT,
    @pUbicacionId INT,
    @pCantidad DECIMAL(18,4),
    @pUnidad VARCHAR(20),
    @pUsuarioId INT,
    @pResultado BIT OUTPUT,
    @pMsg VARCHAR(500) OUTPUT
AS
BEGIN
    SET NOCOUNT ON;
    BEGIN TRY
        BEGIN TRAN;

        INSERT INTO dbo.InventarioMovimientos (ProductoId, UbicacionDestinoId, Tipo, Cantidad, Unidad, Motivo, UsuarioId)
        VALUES (@pProductoId, @pUbicacionId, 'Entrada', @pCantidad, @pUnidad, 'Alta de inventario', @pUsuarioId);

        MERGE dbo.InventarioLotes AS target
        USING (SELECT @pProductoId AS ProductoId, @pUbicacionId AS UbicacionId) AS source
        ON target.ProductoId = source.ProductoId AND target.UbicacionId = source.UbicacionId
        WHEN MATCHED THEN
            UPDATE SET Cantidad = Cantidad + @pCantidad, UltimaActualizacion = SYSDATETIME()
        WHEN NOT MATCHED THEN
            INSERT (ProductoId, UbicacionId, Cantidad, Unidad)
            VALUES (@pProductoId, @pUbicacionId, @pCantidad, @pUnidad);

        COMMIT;
        SET @pResultado = 1;
        SET @pMsg = 'OK';
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0 ROLLBACK;
        SET @pResultado = 0;
        SET @pMsg = ERROR_MESSAGE();
    END CATCH
END;
GO

CREATE OR ALTER PROCEDURE procInventarioSalidasIns
    @pProductoId INT,
    @pUbicacionId INT,
    @pCantidad DECIMAL(18,4),
    @pUnidad VARCHAR(20),
    @pMotivo VARCHAR(150),
    @pUsuarioId INT,
    @pResultado BIT OUTPUT,
    @pMsg VARCHAR(500) OUTPUT
AS
BEGIN
    SET NOCOUNT ON;
    BEGIN TRY
        BEGIN TRAN;

        INSERT INTO dbo.InventarioMovimientos (ProductoId, UbicacionOrigenId, Tipo, Cantidad, Unidad, Motivo, UsuarioId)
        VALUES (@pProductoId, @pUbicacionId, 'Salida', @pCantidad, @pUnidad, @pMotivo, @pUsuarioId);

        UPDATE dbo.InventarioLotes
        SET Cantidad = Cantidad - @pCantidad,
            UltimaActualizacion = SYSDATETIME()
        WHERE ProductoId = @pProductoId AND UbicacionId = @pUbicacionId;

        COMMIT;
        SET @pResultado = 1;
        SET @pMsg = 'OK';
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0 ROLLBACK;
        SET @pResultado = 0;
        SET @pMsg = ERROR_MESSAGE();
    END CATCH
END;
GO
