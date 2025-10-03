using Dapper;
using FerreteriaPOS.Models;
using FerreteriaPOS.Services;

namespace FerreteriaPOS.Modules.Domicilio;

public static class DomicilioEndpoints
{
    public static RouteGroupBuilder MapDomicilioEndpoints(this RouteGroupBuilder group)
    {
        group.MapGet("/rutas", async (IStoredProcedureExecutor executor, CancellationToken cancellationToken) =>
        {
            var parameters = new DynamicParameters();
            var data = await executor.QueryAsync<dynamic>("procDomicilioRutasCon", parameters, cancellationToken);
            return Results.Ok(Resultado.Ok(data));
        });

        group.MapPost("/asignaciones", async (IStoredProcedureExecutor executor, dynamic payload, CancellationToken cancellationToken) =>
        {
            var parameters = new DynamicParameters();
            parameters.Add("@pPedidoId", (int)payload.pedidoId);
            parameters.Add("@pChoferId", (int)payload.choferId);
            var result = await executor.ExecuteAsync("procDomicilioAsignacionIns", parameters, cancellationToken);
            return Results.Ok(result);
        });

        return group;
    }
}
