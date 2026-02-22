# AI Director (n8n + PostgreSQL)

## Запуск (Windows + Docker Desktop)

1) Создайте .env:
   Copy-Item .env.example .env
2) Заполните в .env:
   - N8N_ENCRYPTION_KEY
   - POSTGRES_PASSWORD
   - TELEGRAM_BOT_TOKEN (новый, после revoke)
   - OPENAI_API_KEY
3) Запуск:
   docker compose up -d
4) Открыть n8n:
   http://localhost:5679

## Проверка базы
docker exec -it ai_postgres psql -U ai_user -d ai_core -c "\dt"

## n8n credentials (создать в UI)
- Postgres: имя POSTGRES_AI_CORE, host=postgres, port=5432, db=ai_core, user=ai_user, password из .env
- Telegram: имя TELEGRAM_BOT, token из .env
- OpenAI: имя OPENAI_API, key из .env

## Workflows
Папка workflows должна содержать Director workflows (Cycle/Daily).
