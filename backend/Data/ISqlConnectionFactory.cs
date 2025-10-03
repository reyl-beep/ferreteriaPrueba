using System.Data;

namespace FerreteriaPOS.Data;

public interface ISqlConnectionFactory
{
    Task<IDbConnection> CreateConnectionAsync(CancellationToken cancellationToken = default);
}
