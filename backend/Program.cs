using backend;
using backend.Endpoints;
using Microsoft.EntityFrameworkCore;

var builder = WebApplication.CreateBuilder(args);

DotNetEnv.Env.Load();

// Add services to the container.
// Learn more about configuring Swagger/OpenAPI at https://aka.ms/aspnetcore/swashbuckle
builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen();
builder.Services.AddCors();
builder.Services.AddHealthChecks();

var defaultConnectionString = Environment.GetEnvironmentVariable("DefaultConnectionString");
var allowedOrigins = Environment.GetEnvironmentVariable("AllowedOrigins");

if (string.IsNullOrEmpty(defaultConnectionString))
{
    throw new InvalidOperationException("DefaultConnectionString is required");
}
if (string.IsNullOrEmpty(allowedOrigins))
{
    throw new InvalidOperationException("AllowedOrigins is required");
}

builder.Services.AddDbContext<PostgresDbContext>(options =>
    options.UseNpgsql(defaultConnectionString)
);

var app = builder.Build();

// Validate the database connection on startup
using (var scope = app.Services.CreateScope())
{
    var dbContext = scope.ServiceProvider.GetRequiredService<PostgresDbContext>();
    try
    {
        dbContext.Database.OpenConnection(); // Test if the connection is valid
        dbContext.Database.CloseConnection();
        Console.WriteLine("[CUSTOM LOG] Database connection successful.");
    }
    catch (Exception ex)
    {
        Console.WriteLine(
            $"[CUSTOM LOG] Database connection failed. Make sure you have the proper host in your .env file."
        );
        Console.WriteLine(ex.Message);
        throw;
    }
}

app.UseCors(options =>
{
    options.WithOrigins(allowedOrigins.Split(',')).AllowAnyHeader().AllowAnyMethod();
});

// Configure the HTTP request pipeline.
if (app.Environment.IsDevelopment())
{
    app.UseSwagger();
    app.UseSwaggerUI();
}

app.MapHealthChecks("/health");
StudentEndpoints.Map(app);

app.Run();
