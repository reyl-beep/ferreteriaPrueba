namespace FerreteriaPOS.Models;

public sealed class Resultado
{
    public bool Value { get; set; }
    public string Message { get; set; } = string.Empty;
    public object? Data { get; set; }
    public static Resultado Ok(object? data = null, string message = "OK") => new() { Value = true, Message = message, Data = data };
    public static Resultado Fail(string message) => new() { Value = false, Message = message };
}
