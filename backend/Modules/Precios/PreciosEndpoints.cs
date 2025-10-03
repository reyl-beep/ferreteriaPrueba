using Dapper;
using FerreteriaPOS.Models;
using FerreteriaPOS.Services;

namespace FerreteriaPOS.Modules.Precios;

public static class PreciosEndpoints
{
    public static RouteGroupBuilder MapPreciosEndpoints(this RouteGroupBuilder group)
    {
        group.MapGet("/listas", async (IStoredProcedureExecutor executor, CancellationToken cancellationToken) =>
        {
            var parameters = new DynamicParameters();
            var data = await executor.QueryAsync<dynamic>("procPreciosListasCon", parameters, cancellationToken);
            return Results.Ok(Resultado.Ok(data));
        });

        group.MapPost("/listas", async (IStoredProcedureExecutor executor, dynamic payload, CancellationToken cancellationToken) =>
        {
            var parameters = new DynamicParameters();
            parameters.Add("@pNombre", (string)payload.nombre);
            parameters.Add("@pSegmento", (string)payload.segmento);
            parameters.Add("@pAjuste", (decimal)payload.ajuste);
            var result = await executor.ExecuteAsync("procPreciosListasIns", parameters, cancellationToken);
            return Results.Ok(result);
        });

        return group;
    }
}
