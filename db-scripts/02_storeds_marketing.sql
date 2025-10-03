SET ANSI_NULLS ON;
GO
SET QUOTED_IDENTIFIER ON;
GO

CREATE OR ALTER PROCEDURE procMarketingCampaniasCon
    @pResultado BIT OUTPUT,
    @pMsg VARCHAR(500) OUTPUT
AS
BEGIN
    SET NOCOUNT ON;
    BEGIN TRY
        SELECT CampaniaId, Nombre, Canal, FechaInicio, FechaFin, Presupuesto, MetaROI
        FROM dbo.MarketingCampanias;
        SET @pResultado = 1;
        SET @pMsg = 'OK';
    END TRY
    BEGIN CATCH
        SET @pResultado = 0;
        SET @pMsg = ERROR_MESSAGE();
    END CATCH
END;
GO

CREATE OR ALTER PROCEDURE procMarketingCampaniasIns
    @pNombre VARCHAR(150),
    @pCanal VARCHAR(50),
    @pFechaInicio DATE,
    @pFechaFin DATE = NULL,
    @pPresupuesto DECIMAL(18,4) = NULL,
    @pMetaROI DECIMAL(9,4) = NULL,
    @pResultado BIT OUTPUT,
    @pMsg VARCHAR(500) OUTPUT
AS
BEGIN
    SET NOCOUNT ON;
    BEGIN TRY
        BEGIN TRAN;

        INSERT INTO dbo.MarketingCampanias (Nombre, Canal, FechaInicio, FechaFin, Presupuesto, MetaROI)
        VALUES (@pNombre, @pCanal, @pFechaInicio, @pFechaFin, @pPresupuesto, @pMetaROI);

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
