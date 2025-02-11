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

var localConnectionString = Environment.GetEnvironmentVariable("LocalConnectionString");
var composeConnectionString = Environment.GetEnvironmentVariable("ComposeConnectionString");
var allowedOrigins = Environment.GetEnvironmentVariable("AllowedOrigins");

// Please ensure to have your .env file in the project root or if you are running from compose, ensure the environment variables are set there.

// Ensure at least one of the connection strings has a value
if (string.IsNullOrEmpty(localConnectionString) && string.IsNullOrEmpty(composeConnectionString))
{
    throw new InvalidOperationException("At least one of 'LocalConnectionString' or 'ComposeConnectionString' must have a value.");
}

// Ensure AllowedOrigins is set
if (string.IsNullOrEmpty(allowedOrigins))
{
    throw new InvalidOperationException("AllowedOrigins is required");
}

// Determine the connection string to use
string connectionString = localConnectionString ?? composeConnectionString;

builder.Services.AddDbContext<PostgresDbContext>(options =>
    options.UseNpgsql(connectionString, b => b.MigrationsAssembly("backend"))
);



var app = builder.Build();

// Validate the database connection on startup
using (var scope = app.Services.CreateScope())
{
    var dbContext = scope.ServiceProvider.GetRequiredService<PostgresDbContext>();
    try
    {
        await dbContext.Database.MigrateAsync().ConfigureAwait(false);
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
