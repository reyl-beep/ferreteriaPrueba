SET ANSI_NULLS ON;
GO
SET QUOTED_IDENTIFIER ON;
GO

CREATE OR ALTER TRIGGER trInventarioLogMovimiento
ON dbo.InventarioMovimientos
AFTER INSERT
AS
BEGIN
    SET NOCOUNT ON;
    INSERT INTO dbo.LogActividadUsuario (UsuarioId, Accion, Modulo, Detalle)
    SELECT i.UsuarioId,
           'MovimientoInventario',
           'Inventario',
           CONCAT('Movimiento ', i.Tipo, ' ProductoId: ', i.ProductoId, ' Cantidad: ', i.Cantidad)
    FROM inserted i;
END;
GO
