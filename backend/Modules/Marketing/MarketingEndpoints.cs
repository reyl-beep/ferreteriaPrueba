using Dapper;
using FerreteriaPOS.Models;
using FerreteriaPOS.Services;

namespace FerreteriaPOS.Modules.Marketing;

public static class MarketingEndpoints
{
    public static RouteGroupBuilder MapMarketingEndpoints(this RouteGroupBuilder group)
    {
        group.MapGet("/campanias", async (IStoredProcedureExecutor executor, CancellationToken cancellationToken) =>
        {
            var parameters = new DynamicParameters();
            var data = await executor.QueryAsync<dynamic>("procMarketingCampaniasCon", parameters, cancellationToken);
            return Results.Ok(Resultado.Ok(data));
        });

        group.MapPost("/campanias", async (IStoredProcedureExecutor executor, dynamic payload, CancellationToken cancellationToken) =>
        {
            var parameters = new DynamicParameters();
            parameters.Add("@pNombre", (string)payload.nombre);
            parameters.Add("@pCanal", (string)payload.canal);
            parameters.Add("@pFechaInicio", (DateTime)payload.fechaInicio);
            var result = await executor.ExecuteAsync("procMarketingCampaniasIns", parameters, cancellationToken);
            return Results.Ok(result);
        });

        return group;
    }
}
