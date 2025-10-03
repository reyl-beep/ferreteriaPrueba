using Dapper;
using FerreteriaPOS.Models;
using FerreteriaPOS.Services;

namespace FerreteriaPOS.Modules.Ventas;

public static class VentasEndpoints
{
    public static RouteGroupBuilder MapVentasEndpoints(this RouteGroupBuilder group)
    {
        group.MapGet("/", async (IStoredProcedureExecutor executor, CancellationToken cancellationToken) =>
        {
            var parameters = new DynamicParameters();
            var data = await executor.QueryAsync<dynamic>("procVentasListadoCon", parameters, cancellationToken);
            return Results.Ok(Resultado.Ok(data));
        });

        group.MapPost("/", async (IStoredProcedureExecutor executor, dynamic payload, CancellationToken cancellationToken) =>
        {
            var parameters = new DynamicParameters();
            parameters.Add("@pCotizacionId", (int?)payload.cotizacionId);
            parameters.Add("@pClienteId", (int)payload.clienteId);
            parameters.Add("@pTotal", (decimal)payload.total);
            var result = await executor.ExecuteAsync("procVentasCreate", parameters, cancellationToken);
            return Results.Ok(result);
        });

        return group;
    }
}
