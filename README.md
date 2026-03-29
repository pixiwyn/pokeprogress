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
 
## CI / CD

This project uses GitHub Actions (free for public repos) to automate testing, linting, security scanning, and code review on every push and pull request.

### CI Pipeline (`ci.yml`)

Runs five parallel jobs on every PR and push to `main`:

- **scan_ruby** — Brakeman static analysis + bundler-audit for known gem vulnerabilities
- **lint_ruby** — RuboCop with Rails Omakase style (cached for speed)
- **test_ruby** — Full Rails test suite against a live PostgreSQL service
- **lint_frontend** — ESLint across all React/JSX source files
- **build_frontend** — Vite production build to catch broken imports and build errors

### AI Code Review (`claude-code-review.yml`)

Runs automatically on every pull request. Claude Code analyzes the diff in the context of the full codebase and posts inline review comments covering code quality, logic errors, security vulnerabilities, and Rails/React best practices. Supplements human review — does not approve or block PRs.

### AI PR Assistant (`claude.yml`)

Mention `@claude` in any PR comment, review, or issue and Claude will respond in context — answering questions about the code, explaining decisions, or suggesting improvements.

### Dependabot (`dependabot.yml`)

Weekly automated dependency updates for Ruby gems, npm packages, GitHub Actions versions, and Docker base images across both frontend and backend.

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