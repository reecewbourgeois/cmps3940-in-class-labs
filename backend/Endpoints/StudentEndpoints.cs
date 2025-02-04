using backend.DTOs;
using backend.Types;
using Microsoft.AspNetCore.Mvc;

namespace backend.Endpoints;

public static class StudentEndpoints
{
    public static void Map(WebApplication app)
    {
        /// Get all students
        app.MapGet(
            "/students",
            () =>
            {
                return Results.Ok(
                    new List<GetStudentDto>
                    {
                        new(new Guid(), "Bob", StudentClassification.Freshman),
                        new(new Guid(), "Alice", StudentClassification.Sophomore),
                        new(new Guid(), "Charlie", StudentClassification.Junior),
                        new(new Guid(), "David", StudentClassification.Senior),
                    }
                );
            }
        );

        /// Get a specific student by id
        app.MapGet(
            "/student/{id}",
            ([FromRoute] Guid id) =>
            {
                return Results.Ok(new GetStudentDto(id, "Bob", StudentClassification.Freshman));
            }
        );

        /// Upsert a student
        app.MapPost(
            "/student",
            ([FromBody] UpsertStudentDto upsertDto) =>
            {
                return Results.Ok(
                    new GetStudentDto(
                        upsertDto.Id ?? new Guid(),
                        upsertDto.Name,
                        upsertDto.Classification
                    )
                );
            }
        );

        /// Delete a student by id
        app.MapDelete(
            "/student/{id}",
            ([FromRoute] Guid id) =>
            {
                return Results.Ok();
            }
        );

        /// Update a student's classification
        app.MapPut(
            "/student/{id}/{classification}",
            ([FromRoute] Guid id, [FromRoute] StudentClassification classification) =>
            {
                return Results.Ok(new GetStudentDto(id, "Bob", classification));
            }
        );
    }
}
