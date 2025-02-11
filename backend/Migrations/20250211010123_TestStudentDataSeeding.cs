using System;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

#pragma warning disable CA1814 // Prefer jagged arrays over multidimensional

namespace backend.Migrations
{
    /// <inheritdoc />
    public partial class TestStudentDataSeeding : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.InsertData(
                table: "Student",
                columns: new[] { "Id", "Classification", "Name" },
                values: new object[,]
                {
                    { new Guid("5b477117-c502-45f5-b167-7d9be43c8a9a"), 3, "David" },
                    { new Guid("79f2b705-43b0-4de3-b92c-5e630acdb059"), 1, "Bob" },
                    { new Guid("bf9d0fb1-7210-4b75-9dcf-45ab1608a331"), 0, "Alice" },
                    { new Guid("f2daf9d2-e89d-40f1-be40-100ae86a0c3f"), 2, "Charlie" }
                });
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DeleteData(
                table: "Student",
                keyColumn: "Id",
                keyValue: new Guid("5b477117-c502-45f5-b167-7d9be43c8a9a"));

            migrationBuilder.DeleteData(
                table: "Student",
                keyColumn: "Id",
                keyValue: new Guid("79f2b705-43b0-4de3-b92c-5e630acdb059"));

            migrationBuilder.DeleteData(
                table: "Student",
                keyColumn: "Id",
                keyValue: new Guid("bf9d0fb1-7210-4b75-9dcf-45ab1608a331"));

            migrationBuilder.DeleteData(
                table: "Student",
                keyColumn: "Id",
                keyValue: new Guid("f2daf9d2-e89d-40f1-be40-100ae86a0c3f"));
        }
    }
}
