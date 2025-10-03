using Dapper;
using FerreteriaPOS.Models;
using FerreteriaPOS.Services;

namespace FerreteriaPOS.Modules.Catalogos;

public static class CatalogosEndpoints
{
    public static RouteGroupBuilder MapCatalogosEndpoints(this RouteGroupBuilder group)
    {
        group.MapGet("/madera", async (IStoredProcedureExecutor executor, CancellationToken cancellationToken) =>
        {
            var parameters = new DynamicParameters();
            var data = await executor.QueryAsync<dynamic>("procCatalogosMaderaCon", parameters, cancellationToken);
            return Results.Ok(Resultado.Ok(data));
        });

        group.MapPost("/madera", async (IStoredProcedureExecutor executor, dynamic payload, CancellationToken cancellationToken) =>
        {
            var parameters = new DynamicParameters();
            parameters.Add("@pDescripcion", (string)payload.descripcion);
            var result = await executor.ExecuteAsync("procCatalogosMaderaIns", parameters, cancellationToken);
            return Results.Ok(result);
        });

        group.MapGet("/polvos", async (IStoredProcedureExecutor executor, CancellationToken cancellationToken) =>
        {
            var parameters = new DynamicParameters();
            var data = await executor.QueryAsync<dynamic>("procCatalogosPolvosCon", parameters, cancellationToken);
            return Results.Ok(Resultado.Ok(data));
        });

        group.MapPost("/polvos", async (IStoredProcedureExecutor executor, dynamic payload, CancellationToken cancellationToken) =>
        {
            var parameters = new DynamicParameters();
            parameters.Add("@pProducto", (string)payload.producto);
            parameters.Add("@pLote", (string)payload.lote);
            parameters.Add("@pCaducidad", (DateTime)payload.caducidad);
            var result = await executor.ExecuteAsync("procCatalogosPolvosIns", parameters, cancellationToken);
            return Results.Ok(result);
        });

        return group;
    }
}
