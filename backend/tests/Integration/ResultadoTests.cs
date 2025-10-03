using FerreteriaPOS.Models;
using Xunit;

namespace FerreteriaPOS.Tests.Integration;

public class ResultadoTests
{
    [Fact]
    public void Ok_ShouldReturnSuccessfulResultado()
    {
        var result = Resultado.Ok(new { Id = 1 }, "Creado");
        Assert.True(result.Value);
        Assert.Equal("Creado", result.Message);
        Assert.NotNull(result.Data);
    }
}
