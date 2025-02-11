## Running Locally (.NET)

1. Install .NET 8 SDK
2. Create a `.env` file at root using the `.env.sample` file as a template
    - **Make sure your database host is `localhost`**
3. Run the server
    - `dotnet run`

## Running Locally (Docker)

1. Install Docker
2. Create a `.env` file at root using the `.env.sample` file as a template
    - **Note: If you want to use a local PostgreSQL database, make sure your host is `host.docker.internal` instead of `localhost`**
3. Use the rebuild script
    - `./rebuild.bat`

**OR**

3. Build the image
    - `docker build -t <image-name> .`
4. Run the container
    - `docker run -d -p 5000:5000 -e ASPNETCORE_HTTP_PORTS=5000 --name <container-name> <image-name>`