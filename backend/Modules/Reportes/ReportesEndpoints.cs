using Dapper;
using FerreteriaPOS.Models;
using FerreteriaPOS.Services;

namespace FerreteriaPOS.Modules.Reportes;

public static class ReportesEndpoints
{
    public static RouteGroupBuilder MapReportesEndpoints(this RouteGroupBuilder group)
    {
        group.MapGet("/ventas", async (IStoredProcedureExecutor executor, DateTime? fechaInicio, DateTime? fechaFin, CancellationToken cancellationToken) =>
        {
            var parameters = new DynamicParameters();
            parameters.Add("@pFechaInicio", fechaInicio);
            parameters.Add("@pFechaFin", fechaFin);
            var data = await executor.QueryAsync<dynamic>("procReportesVentasCon", parameters, cancellationToken);
            return Results.Ok(Resultado.Ok(data));
        });

        group.MapGet("/roi", async (IStoredProcedureExecutor executor, CancellationToken cancellationToken) =>
        {
            var parameters = new DynamicParameters();
            var data = await executor.QueryAsync<dynamic>("procReportesROICon", parameters, cancellationToken);
            return Results.Ok(Resultado.Ok(data));
        });

        return group;
    }
}
