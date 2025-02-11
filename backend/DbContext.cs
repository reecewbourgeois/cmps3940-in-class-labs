using backend.Entities;
using backend.Types;
using Microsoft.EntityFrameworkCore;


namespace backend;

public class PostgresDbContext(DbContextOptions<PostgresDbContext> options) : DbContext(options)
{
    public DbSet<Student> Student { get; set; }

    protected override void OnModelCreating(ModelBuilder modelBuilder)
    {
        base.OnModelCreating(modelBuilder);

        modelBuilder.Entity<Student>(entity =>
        {
            entity.HasKey(e => e.Id);
            entity.Property(e => e.Name).IsRequired();
            entity.Property(e => e.Classification).IsRequired();
        });

        modelBuilder.Entity<Student>().HasData(
            new Student("Alice", StudentClassification.Freshman),
            new Student("Bob", StudentClassification.Sophomore),
            new Student("Charlie", StudentClassification.Junior),
            new Student("David", StudentClassification.Senior));
    }
}
