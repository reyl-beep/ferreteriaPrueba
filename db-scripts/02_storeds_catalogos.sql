SET ANSI_NULLS ON;
GO
SET QUOTED_IDENTIFIER ON;
GO

CREATE OR ALTER PROCEDURE procCatalogosMaderaCon
    @pResultado BIT OUTPUT,
    @pMsg VARCHAR(500) OUTPUT
AS
BEGIN
    SET NOCOUNT ON;
    BEGIN TRY
        SELECT ProductoId, Sku, Nombre, UnidadBase
        FROM dbo.CatProductos
        WHERE CategoriaId IN (
            SELECT CategoriaId FROM dbo.CatCategoriasProductos WHERE Nombre LIKE 'Madera%'
        );
        SET @pResultado = 1;
        SET @pMsg = 'OK';
    END TRY
    BEGIN CATCH
        SET @pResultado = 0;
        SET @pMsg = ERROR_MESSAGE();
    END CATCH
END;
GO

CREATE OR ALTER PROCEDURE procCatalogosMaderaIns
    @pCategoriaId INT,
    @pSku VARCHAR(40),
    @pNombre VARCHAR(120),
    @pUnidadBase VARCHAR(20),
    @pResultado BIT OUTPUT,
    @pMsg VARCHAR(500) OUTPUT
AS
BEGIN
    SET NOCOUNT ON;
    BEGIN TRY
        BEGIN TRAN;

        INSERT INTO dbo.CatProductos (CategoriaId, Sku, Nombre, UnidadBase)
        VALUES (@pCategoriaId, @pSku, @pNombre, @pUnidadBase);

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

CREATE OR ALTER PROCEDURE procCatalogosPolvosCon
    @pResultado BIT OUTPUT,
    @pMsg VARCHAR(500) OUTPUT
AS
BEGIN
    SET NOCOUNT ON;
    BEGIN TRY
        SELECT ProductoId, Sku, Nombre, UnidadBase, Descripcion
        FROM dbo.CatProductos
        WHERE CategoriaId IN (
            SELECT CategoriaId FROM dbo.CatCategoriasProductos WHERE Nombre LIKE 'Polvos%'
        );
        SET @pResultado = 1;
        SET @pMsg = 'OK';
    END TRY
    BEGIN CATCH
        SET @pResultado = 0;
        SET @pMsg = ERROR_MESSAGE();
    END CATCH
END;
GO

CREATE OR ALTER PROCEDURE procCatalogosPolvosIns
    @pCategoriaId INT,
    @pSku VARCHAR(40),
    @pNombre VARCHAR(120),
    @pUnidadBase VARCHAR(20),
    @pLote VARCHAR(50),
    @pCaducidad DATE,
    @pResultado BIT OUTPUT,
    @pMsg VARCHAR(500) OUTPUT
AS
BEGIN
    SET NOCOUNT ON;
    BEGIN TRY
        BEGIN TRAN;

        INSERT INTO dbo.CatProductos (CategoriaId, Sku, Nombre, UnidadBase)
        VALUES (@pCategoriaId, @pSku, @pNombre, @pUnidadBase);

        DECLARE @pNuevoProductoId INT = SCOPE_IDENTITY();

        INSERT INTO dbo.InventarioLotes (ProductoId, UbicacionId, Cantidad, Unidad, Lote, Caducidad)
        VALUES (@pNuevoProductoId, 1, 0, @pUnidadBase, @pLote, @pCaducidad);

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
