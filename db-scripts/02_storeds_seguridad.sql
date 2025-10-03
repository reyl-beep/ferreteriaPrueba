SET ANSI_NULLS ON;
GO
SET QUOTED_IDENTIFIER ON;
GO

CREATE OR ALTER PROCEDURE procSeguridadLogin
    @pCorreo VARCHAR(150),
    @pContrasena VARCHAR(200),
    @pResultado BIT OUTPUT,
    @pMsg VARCHAR(500) OUTPUT
AS
BEGIN
    SET NOCOUNT ON;
    BEGIN TRY
        DECLARE @pUsuarioId INT;
        SELECT @pUsuarioId = UsuarioId FROM dbo.CatUsuarios WHERE Correo = @pCorreo AND Activo = 1;

        IF @pUsuarioId IS NULL
        BEGIN
            SET @pResultado = 0;
            SET @pMsg = 'Usuario no encontrado';
            RETURN;
        END;

        -- Validación simulada
        IF @pContrasena <> 'Admin123!'
        BEGIN
            SET @pResultado = 0;
            SET @pMsg = 'Contraseña incorrecta';
            RETURN;
        END;

        SET @pResultado = 1;
        SET @pMsg = 'OK';

        SELECT TOP 1
            u.UsuarioId,
            u.Nombre,
            u.Correo,
            r.Nombre AS Rol
        FROM dbo.CatUsuarios u
        INNER JOIN dbo.CatRoles r ON r.RolId = u.RolId
        WHERE u.UsuarioId = @pUsuarioId;
    END TRY
    BEGIN CATCH
        SET @pResultado = 0;
        SET @pMsg = ERROR_MESSAGE();
    END CATCH
END;
GO

CREATE OR ALTER PROCEDURE procSeguridadRolesCon
    @pResultado BIT OUTPUT,
    @pMsg VARCHAR(500) OUTPUT
AS
BEGIN
    SET NOCOUNT ON;
    BEGIN TRY
        SELECT RolId, Nombre, Descripcion, Activo
        FROM dbo.CatRoles;
        SET @pResultado = 1;
        SET @pMsg = 'OK';
    END TRY
    BEGIN CATCH
        SET @pResultado = 0;
        SET @pMsg = ERROR_MESSAGE();
    END CATCH
END;
GO
