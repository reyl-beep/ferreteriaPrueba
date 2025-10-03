SET ANSI_NULLS ON;
GO
SET QUOTED_IDENTIFIER ON;
GO

CREATE OR ALTER PROCEDURE procCotizacionesListadoCon
    @pResultado BIT OUTPUT,
    @pMsg VARCHAR(500) OUTPUT
AS
BEGIN
    SET NOCOUNT ON;
    BEGIN TRY
        SELECT c.CotizacionId,
               cli.Nombre AS Cliente,
               c.Fecha,
               c.ValidezDias,
               c.Estatus,
               c.Total
        FROM dbo.Cotizaciones c
        INNER JOIN dbo.CatClientes cli ON cli.ClienteId = c.ClienteId;
        SET @pResultado = 1;
        SET @pMsg = 'OK';
    END TRY
    BEGIN CATCH
        SET @pResultado = 0;
        SET @pMsg = ERROR_MESSAGE();
    END CATCH
END;
GO

CREATE OR ALTER PROCEDURE procCotizacionesCreate
    @pClienteId INT,
    @pValidez INT,
    @pResultado BIT OUTPUT,
    @pMsg VARCHAR(500) OUTPUT
AS
BEGIN
    SET NOCOUNT ON;
    BEGIN TRY
        BEGIN TRAN;

        INSERT INTO dbo.Cotizaciones (ClienteId, ValidezDias)
        VALUES (@pClienteId, @pValidez);

        DECLARE @pNuevaCotizacionId INT = SCOPE_IDENTITY();

        SET @pResultado = 1;
        SET @pMsg = 'OK';

        COMMIT;

        SELECT @pNuevaCotizacionId AS CotizacionId;
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0 ROLLBACK;
        SET @pResultado = 0;
        SET @pMsg = ERROR_MESSAGE();
    END CATCH
END;
GO

CREATE OR ALTER PROCEDURE procVentasListadoCon
    @pResultado BIT OUTPUT,
    @pMsg VARCHAR(500) OUTPUT
AS
BEGIN
    SET NOCOUNT ON;
    BEGIN TRY
        SELECT v.VentaId,
               v.Fecha,
               cli.Nombre AS Cliente,
               v.Total,
               v.MetodoPago
        FROM dbo.Ventas v
        INNER JOIN dbo.CatClientes cli ON cli.ClienteId = v.ClienteId;
        SET @pResultado = 1;
        SET @pMsg = 'OK';
    END TRY
    BEGIN CATCH
        SET @pResultado = 0;
        SET @pMsg = ERROR_MESSAGE();
    END CATCH
END;
GO

CREATE OR ALTER PROCEDURE procVentasCreate
    @pCotizacionId INT = NULL,
    @pClienteId INT,
    @pTotal DECIMAL(18,4),
    @pMetodoPago VARCHAR(30) = NULL,
    @pResultado BIT OUTPUT,
    @pMsg VARCHAR(500) OUTPUT
AS
BEGIN
    SET NOCOUNT ON;
    BEGIN TRY
        BEGIN TRAN;

        INSERT INTO dbo.Ventas (CotizacionId, ClienteId, Total, MetodoPago)
        VALUES (@pCotizacionId, @pClienteId, @pTotal, @pMetodoPago);

        DECLARE @pNuevaVentaId INT = SCOPE_IDENTITY();

        IF @pCotizacionId IS NOT NULL
        BEGIN
            UPDATE dbo.Cotizaciones
            SET Estatus = 'Convertida'
            WHERE CotizacionId = @pCotizacionId;
        END;

        COMMIT;
        SET @pResultado = 1;
        SET @pMsg = 'OK';

        SELECT @pNuevaVentaId AS VentaId;
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0 ROLLBACK;
        SET @pResultado = 0;
        SET @pMsg = ERROR_MESSAGE();
    END CATCH
END;
GO
