using Dapper;
using FerreteriaPOS.Models;
using FerreteriaPOS.Services;

namespace FerreteriaPOS.Modules.Inventario;

public static class InventarioEndpoints
{
    public static RouteGroupBuilder MapInventarioEndpoints(this RouteGroupBuilder group)
    {
        group.MapGet("/existencias", async (IStoredProcedureExecutor executor, CancellationToken cancellationToken) =>
        {
            var parameters = new DynamicParameters();
            var data = await executor.QueryAsync<dynamic>("procInventarioExistenciasCon", parameters, cancellationToken);
            return Results.Ok(Resultado.Ok(data));
        });

        group.MapPost("/entradas", async (IStoredProcedureExecutor executor, dynamic payload, CancellationToken cancellationToken) =>
        {
            var parameters = new DynamicParameters();
            parameters.Add("@pProductoId", (int)payload.productoId);
            parameters.Add("@pCantidad", (decimal)payload.cantidad);
            parameters.Add("@pUnidad", (string)payload.unidad);
            var result = await executor.ExecuteAsync("procInventarioEntradasIns", parameters, cancellationToken);
            return Results.Ok(result);
        });

        group.MapPost("/salidas", async (IStoredProcedureExecutor executor, dynamic payload, CancellationToken cancellationToken) =>
        {
            var parameters = new DynamicParameters();
            parameters.Add("@pProductoId", (int)payload.productoId);
            parameters.Add("@pCantidad", (decimal)payload.cantidad);
            parameters.Add("@pMotivo", (string)payload.motivo);
            var result = await executor.ExecuteAsync("procInventarioSalidasIns", parameters, cancellationToken);
            return Results.Ok(result);
        });

        return group;
    }
}
