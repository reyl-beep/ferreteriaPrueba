using Dapper;
using FerreteriaPOS.Models;
using FerreteriaPOS.Services;

namespace FerreteriaPOS.Modules.Ventas;

public static class CotizacionesEndpoints
{
    public static RouteGroupBuilder MapCotizacionesEndpoints(this RouteGroupBuilder group)
    {
        group.MapGet("/", async (IStoredProcedureExecutor executor, CancellationToken cancellationToken) =>
        {
            var parameters = new DynamicParameters();
            var data = await executor.QueryAsync<dynamic>("procCotizacionesListadoCon", parameters, cancellationToken);
            return Results.Ok(Resultado.Ok(data));
        });

        group.MapPost("/", async (IStoredProcedureExecutor executor, dynamic payload, CancellationToken cancellationToken) =>
        {
            var parameters = new DynamicParameters();
            parameters.Add("@pClienteId", (int)payload.clienteId);
            parameters.Add("@pValidez", (int)payload.validez);
            var result = await executor.ExecuteAsync("procCotizacionesCreate", parameters, cancellationToken);
            return Results.Ok(result);
        });

        return group;
    }
}
