using AspNetCoreRateLimit;
using Dapper;
using FerreteriaPOS.Data;
using FerreteriaPOS.Models;
using FerreteriaPOS.Modules.Catalogos;
using FerreteriaPOS.Modules.Precios;
using FerreteriaPOS.Modules.Inventario;
using FerreteriaPOS.Modules.Ventas;
using FerreteriaPOS.Modules.Domicilio;
using FerreteriaPOS.Modules.Empleados;
using FerreteriaPOS.Modules.Reportes;
using FerreteriaPOS.Modules.Marketing;
using FerreteriaPOS.Modules.Seguridad;
using FerreteriaPOS.Services;
using Microsoft.AspNetCore.HttpOverrides;
using Microsoft.OpenApi.Models;
using Serilog;

var builder = WebApplication.CreateBuilder(args);

builder.Host.UseSerilog((context, services, configuration) =>
{
    configuration
        .ReadFrom.Configuration(context.Configuration)
        .ReadFrom.Services(services)
        .Enrich.FromLogContext();
});

builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen(options =>
{
    options.SwaggerDoc("v1", new OpenApiInfo
    {
        Title = "Ferretería POS API",
        Version = "v1",
        Description = "API Minimal para sistema POS de ferretería"
    });
    options.MapType<Resultado>(() => new OpenApiSchema
    {
        Type = "object",
        Properties = new Dictionary<string, OpenApiSchema>
        {
            ["value"] = new OpenApiSchema { Type = "boolean", Description = "Indica si la operación fue exitosa" },
            ["message"] = new OpenApiSchema { Type = "string", Description = "Mensaje amigable" },
            ["data"] = new OpenApiSchema { Type = "object", Description = "Carga útil opcional" }
        }
    });
    options.AddSecurityDefinition("Bearer", new OpenApiSecurityScheme
    {
        Description = "JWT Authorization header using the Bearer scheme",
        Name = "Authorization",
        In = ParameterLocation.Header,
        Type = SecuritySchemeType.Http,
        Scheme = "bearer"
    });
    options.AddSecurityRequirement(new OpenApiSecurityRequirement
    {
        [
            new OpenApiSecurityScheme
            {
                Reference = new OpenApiReference
                {
                    Type = ReferenceType.SecurityScheme,
                    Id = "Bearer"
                }
            }
        ] = new string[] { }
    });
});

builder.Services.Configure<ClientRateLimitOptions>(builder.Configuration.GetSection("RateLimiting"));
builder.Services.Configure<ClientRateLimitPolicies>(builder.Configuration.GetSection("RateLimitingPolicies"));
builder.Services.AddMemoryCache();
builder.Services.AddInMemoryRateLimiting();
builder.Services.AddSingleton<IRateLimitConfiguration, RateLimitConfiguration>();

builder.Services.AddSingleton<ISqlConnectionFactory, SqlConnectionFactory>();
builder.Services.AddScoped<IStoredProcedureExecutor, StoredProcedureExecutor>();

var allowedOrigins = builder.Configuration.GetSection("Cors:AllowedOrigins").Get<string[]>() ?? new[] { "http://localhost:5173" };
builder.Services.AddCors(options =>
{
    options.AddPolicy("AllowSpecificOrigins", policy =>
    {
        policy.WithOrigins(allowedOrigins)
              .AllowAnyHeader()
              .AllowAnyMethod()
              .AllowCredentials();
    });
});

builder.Services.AddProblemDetails();

var app = builder.Build();

app.UseSerilogRequestLogging();

app.UseForwardedHeaders(new ForwardedHeadersOptions
{
    ForwardedHeaders = ForwardedHeaders.XForwardedFor | ForwardedHeaders.XForwardedProto
});

// app.UseHttpsRedirection(); // Habilitar en producción para forzar HTTPS

app.UseCors("AllowSpecificOrigins");

app.UseClientRateLimiting();

app.UseSwagger();
app.UseSwaggerUI();

app.MapGet("/", (HttpContext context) => Results.Redirect("/swagger"));

app.MapGroup("/api/catalogos").WithTags("Catálogos").MapCatalogosEndpoints();
app.MapGroup("/api/precios").WithTags("Precios").MapPreciosEndpoints();
app.MapGroup("/api/inventario").WithTags("Inventario").MapInventarioEndpoints();
app.MapGroup("/api/ventas").WithTags("Ventas").MapVentasEndpoints();
app.MapGroup("/api/cotizaciones").WithTags("Cotizaciones").MapCotizacionesEndpoints();
app.MapGroup("/api/domicilio").WithTags("Servicio a domicilio").MapDomicilioEndpoints();
app.MapGroup("/api/empleados").WithTags("Empleados").MapEmpleadosEndpoints();
app.MapGroup("/api/reportes").WithTags("Reportes").MapReportesEndpoints();
app.MapGroup("/api/marketing").WithTags("Marketing").MapMarketingEndpoints();
app.MapGroup("/api/seguridad").WithTags("Seguridad").MapSeguridadEndpoints();

app.UseExceptionHandler();

app.Run();
