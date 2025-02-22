## Pre-requisites

1. I removed the Postgres docker config to simplify the project. You will need to have a Postgres instance running on your machine.

## Running Locally (.NET and Node.js)

1. Follow the README instructions for both the frontend and backend folders.

## Running Locally (Docker)

1. Install Docker
2. Create a `.env` file at root using the `.env.sample` file as a template
3. Run the following compose command
    - `docker compose up -d`

Note: By default, a PostgreSQL database will be created and stored in a docker volume. If you want to use a local database,
modify the root `.env` file to use your machine's PostgreSQL port.