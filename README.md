# PokéProgress

PokéProgress is a cross-game Pokémon progress tracker built with Ruby on Rails and React. Track your Pokédex completion across multiple games simultaneously — Pokémon GO, mainline titles, and beyond — with per-game catch status, location data powered by PokéAPI, and progress tracking tailored to each game's mechanics. One Pokédex, every game, your way.
 
---
 
## Project Structure
 
```
pokeprogress/
├── docker-compose.yml
├── .env.example
├── .env               ← you create this (never commit)
├── backend/           ← Rails API
└── frontend/          ← React / Vite
```
 
---
 
## CI / Automated Code Review

This project uses two GitHub Actions workflows powered by Claude Code.

### Claude Code Review (`claude-code-review.yml`)

Runs automatically on every pull request (open, push, or reopen). A fleet of specialized agents analyzes the diff in the context of the full codebase and posts inline review comments on the PR. Reviews cover code quality, logic errors, security vulnerabilities, and Rails/React best practices. The workflow does not approve or block PRs — it supplements human review.

### Claude PR Assistant (`claude.yml`)

Enables on-demand AI assistance anywhere in the repo. Mention `@claude` in any PR comment, review, or issue and Claude will respond in context — answering questions about the code, explaining decisions, or suggesting improvements.

### Dependabot (`dependabot.yml`)

Dependabot runs weekly checks for outdated dependencies and opens pull requests automatically. It covers:

- **Ruby gems** — backend dependencies via Bundler (`/backend`)
- **npm packages** — frontend dependencies (`/frontend`)
- **GitHub Actions** — workflow action versions (`/`)
- **Docker base images** — Dockerfiles in both `/backend` and `/frontend`

No setup required — Dependabot is enabled by the config file at `.github/dependabot.yml`.

---
 
## Local Setup
 
> Prerequisites: [Docker Desktop](https://www.docker.com/products/docker-desktop/) and Git.

### 1. Clone the repository
 
```bash
git clone <your-repo-url>
cd pokeprogress
```
 
### 2. Create your `.env` file
 
```bash
cp .env.example .env
```
 
Open `.env` and fill in the following before continuing:
 
| Variable | Where to get it |
|---|---|
| `POSTGRES_USER` | Any username you choose |
| `POSTGRES_PASSWORD` | Any strong password you choose |
| `POSTGRES_DB` | Any database name you choose |
| `RAILS_MASTER_KEY` | Shared separately — never committed to the repo |
| `SECRET_KEY_BASE` | Generated in step 4 below — leave blank for now |
 
### 3. Build and start the containers
 
```bash
docker compose up --build
```
 
Wait until all three services (`db`, `backend`, `frontend`) are running. You'll see Rails and Vite output in the logs.
 
### 4. Generate `SECRET_KEY_BASE`
 
In a second terminal:
 
```bash
docker compose exec backend bin/rails secret
```
 
Copy the output, paste it into `.env` as the value for `SECRET_KEY_BASE`, then restart the backend:
 
```bash
docker compose restart backend
```
 
### 5. Verify everything is running
 
| Service | URL |
|---|---|
| React frontend | http://localhost:5173 |
| Rails API | http://localhost:3000 |
| PostgreSQL | localhost:5432 |
 
---
 
## Common Commands
 
```bash
# Start all services
docker compose up
 
# Start in background
docker compose up -d
 
# Stop all services
docker compose down
 
# View logs
docker compose logs -f
 
# View logs for a single service
docker compose logs -f backend
 
# Open a Rails console
docker compose exec backend bin/rails console
 
# Run database migrations
docker compose exec backend bin/rails db:migrate
 
# Run tests
docker compose exec backend bin/rails test
 
# Install a new gem (after editing Gemfile)
docker compose up --build backend
 
# Install a new npm package (after editing package.json)
docker compose up --build frontend
```
---