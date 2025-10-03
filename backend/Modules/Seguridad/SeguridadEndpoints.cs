using Dapper;
using FerreteriaPOS.Models;
using FerreteriaPOS.Requests;
using FerreteriaPOS.Services;

namespace FerreteriaPOS.Modules.Seguridad;

public static class SeguridadEndpoints
{
    public static RouteGroupBuilder MapSeguridadEndpoints(this RouteGroupBuilder group)
    {
        group.MapPost("/login", async (LoginRequest request, IStoredProcedureExecutor executor, CancellationToken cancellationToken) =>
        {
            if (request is null)
            {
                return Results.BadRequest(Resultado.Fail("Datos inválidos"));
            }

            var parameters = new DynamicParameters();
            parameters.Add("@pCorreo", request.Email);
            parameters.Add("@pContrasena", request.Password);
            var result = await executor.ExecuteAsync("procSeguridadLogin", parameters, cancellationToken);
            return Results.Ok(result);
        }).Produces<Resultado>();

        group.MapGet("/roles", async (IStoredProcedureExecutor executor, CancellationToken cancellationToken) =>
        {
            var parameters = new DynamicParameters();
            var data = await executor.QueryAsync<dynamic>("procSeguridadRolesCon", parameters, cancellationToken);
            return Results.Ok(Resultado.Ok(data));
        });

        return group;
    }
}
