using Dapper;
using FerreteriaPOS.Models;
using FerreteriaPOS.Services;

namespace FerreteriaPOS.Modules.Empleados;

public static class EmpleadosEndpoints
{
    public static RouteGroupBuilder MapEmpleadosEndpoints(this RouteGroupBuilder group)
    {
        group.MapGet("/", async (IStoredProcedureExecutor executor, CancellationToken cancellationToken) =>
        {
            var parameters = new DynamicParameters();
            var data = await executor.QueryAsync<dynamic>("procEmpleadosListadoCon", parameters, cancellationToken);
            return Results.Ok(Resultado.Ok(data));
        });

        group.MapPost("/", async (IStoredProcedureExecutor executor, dynamic payload, CancellationToken cancellationToken) =>
        {
            var parameters = new DynamicParameters();
            parameters.Add("@pNombre", (string)payload.nombre);
            parameters.Add("@pRol", (string)payload.rol);
            var result = await executor.ExecuteAsync("procEmpleadosAlta", parameters, cancellationToken);
            return Results.Ok(result);
        });

        group.MapPost("/tareas", async (IStoredProcedureExecutor executor, dynamic payload, CancellationToken cancellationToken) =>
        {
            var parameters = new DynamicParameters();
            parameters.Add("@pEmpleadoId", (int)payload.empleadoId);
            parameters.Add("@pDescripcion", (string)payload.descripcion);
            parameters.Add("@pEstatus", (string)payload.estatus);
            var result = await executor.ExecuteAsync("procEmpleadosTareaIns", parameters, cancellationToken);
            return Results.Ok(result);
        });

        return group;
    }
}
