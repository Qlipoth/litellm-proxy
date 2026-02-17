# Инструкция по деплою LiteLLM на Fly.io

## Предварительные требования

1. Установите [Fly CLI](https://fly.io/docs/getting-started/installing-flyctl/)
2. Зарегистрируйтесь на [fly.io](https://fly.io) и войдите в аккаунт:
   ```bash
   fly auth login
   ```

## Шаги деплоя

### 1. Инициализация приложения

Если это первый деплой, выполните:
```bash
fly launch
```

Эта команда:
- Определит ваш Dockerfile
- Создаст или обновит `fly.toml`
- Предложит создать новое приложение или использовать существующее

### 2. Настройка секретов (если нужно)

Если в вашем `config.yml` есть чувствительные данные (API ключи), рекомендуется использовать секреты Fly.io:

```bash
# Установка секретов
fly secrets set OPENROUTER_API_KEY=your-api-key-here

# Просмотр секретов
fly secrets list
```

Затем можно использовать переменные окружения в `config.yml`:
```yaml
model_list:
  - model_name: gemini-2.5-pro-preview-06-05
    litellm_params:
      model: openrouter/baidu/ernie-4.5-21b-a3b
      api_key: ${OPENROUTER_API_KEY}
```

### 3. Деплой приложения

```bash
fly deploy
```

Эта команда:
- Соберет Docker образ
- Загрузит его в Fly.io
- Запустит приложение

### 4. Проверка статуса

```bash
# Проверить статус приложения
fly status

# Просмотреть логи
fly logs

# Открыть приложение в браузере
fly open
```

## Настройка ресурсов

По умолчанию в `fly.toml` установлены минимальные требования для продакшена:
- 4 CPU
- 8GB RAM

Для разработки можно уменьшить ресурсы, отредактировав `fly.toml`:
```toml
[vm]
  cpu_kind = "shared"
  cpus = 1
  memory_mb = 2048
```

## Обновление приложения

После внесения изменений в код или конфигурацию:

```bash
fly deploy
```

## Полезные команды

```bash
# SSH подключение к машине
fly ssh console

# Масштабирование (если нужно несколько инстансов)
fly scale count 2

# Просмотр метрик
fly monitor

# Остановка приложения
fly apps suspend

# Удаление приложения
fly apps destroy
```

## Регионы

По умолчанию используется регион `iad` (Вашингтон, США). Чтобы изменить регион:

```bash
fly regions set <region-code>
```

Список доступных регионов: https://fly.io/docs/reference/regions/

## Troubleshooting

### Проблемы с портом
Убедитесь, что в `fly.toml` указан правильный `internal_port` (4000 по умолчанию).

### Проблемы с памятью
Если приложение падает из-за нехватки памяти, увеличьте `memory_mb` в `fly.toml`.

### Просмотр логов
```bash
fly logs
```

### Перезапуск приложения
```bash
fly apps restart
```
