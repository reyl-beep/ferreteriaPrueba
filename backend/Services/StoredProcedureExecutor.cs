using Dapper;
using FerreteriaPOS.Data;
using FerreteriaPOS.Models;
using System.Data;
using System.Linq;

namespace FerreteriaPOS.Services;

public interface IStoredProcedureExecutor
{
    Task<Resultado> ExecuteAsync(string procedureName, DynamicParameters parameters, CancellationToken cancellationToken = default);
    Task<IEnumerable<T>> QueryAsync<T>(string procedureName, DynamicParameters parameters, CancellationToken cancellationToken = default);
}

public sealed class StoredProcedureExecutor(ISqlConnectionFactory connectionFactory) : IStoredProcedureExecutor
{
    public async Task<Resultado> ExecuteAsync(string procedureName, DynamicParameters parameters, CancellationToken cancellationToken = default)
    {
        await using var connection = await connectionFactory.CreateConnectionAsync(cancellationToken);
        parameters.Add("@pResultado", dbType: DbType.Boolean, direction: ParameterDirection.Output);
        parameters.Add("@pMsg", dbType: DbType.String, size: 500, direction: ParameterDirection.Output);
        await connection.ExecuteAsync(new CommandDefinition(procedureName, parameters, commandType: CommandType.StoredProcedure, cancellationToken: cancellationToken));

        return new Resultado
        {
            Value = parameters.Get<bool>("@pResultado"),
            Message = parameters.Get<string>("@pMsg") ?? string.Empty,
            Data = parameters.ParameterNames.Contains("@pData") ? parameters.Get<object?>("@pData") : null
        };
    }

    public async Task<IEnumerable<T>> QueryAsync<T>(string procedureName, DynamicParameters parameters, CancellationToken cancellationToken = default)
    {
        await using var connection = await connectionFactory.CreateConnectionAsync(cancellationToken);
        parameters.Add("@pResultado", dbType: DbType.Boolean, direction: ParameterDirection.Output);
        parameters.Add("@pMsg", dbType: DbType.String, size: 500, direction: ParameterDirection.Output);
        var data = await connection.QueryAsync<T>(new CommandDefinition(procedureName, parameters, commandType: CommandType.StoredProcedure, cancellationToken: cancellationToken));
        return data;
    }
}
