# Локальный запуск LiteLLM Proxy с ngrok

Этот гайд поможет вам запустить LiteLLM Proxy локально на вашем ПК и сделать его доступным через интернет с помощью ngrok.

## Преимущества локального запуска:

- ✅ Бесплатно (только интернет трафик)
- ✅ Полный контроль над сервером
- ✅ Быстрое тестирование и разработка
- ✅ Не нужно настраивать деплой

## Требования:

1. **Python и виртуальное окружение** (уже настроено)
2. **ngrok** - для создания туннеля

## Установка ngrok:

### Вариант 1: Скачать с официального сайта
1. Перейдите на https://ngrok.com/download
2. Скачайте версию для Windows
3. Распакуйте `ngrok.exe` в папку (например, `C:\ngrok\`)
4. Добавьте папку в PATH или используйте полный путь

### Вариант 2: Через Chocolatey (если установлен)
```powershell
choco install ngrok
```

### Вариант 3: Через Scoop (если установлен)
```powershell
scoop install ngrok
```

## Настройка ngrok:

1. Зарегистрируйтесь на https://ngrok.com (бесплатно)
2. Получите authtoken из дашборда
3. Выполните команду:
```bash
ngrok config add-authtoken YOUR_AUTH_TOKEN
```

## Запуск:

### Вариант 1: Автоматический запуск (рекомендуется)

Просто запустите:
```bash
start-with-ngrok.bat
```

Этот скрипт:
- Запустит LiteLLM Proxy на порту 4000
- Запустит ngrok туннель
- Покажет публичный URL

### Вариант 2: Ручной запуск

**Терминал 1** - запуск LiteLLM:
```bash
start-litellm.bat
```

**Терминал 2** - запуск ngrok:
```bash
start-ngrok.bat
```

Или напрямую:
```bash
ngrok http 4000
```

## Использование:

После запуска ngrok покажет что-то вроде:
```
Forwarding  https://abc123.ngrok-free.app -> http://localhost:4000
```

Используйте этот URL (`https://abc123.ngrok-free.app`) как endpoint для ваших запросов к LiteLLM Proxy.

## Пример использования:

```python
import openai

client = openai.OpenAI(
    api_key="anything",  # LiteLLM не требует реальный ключ OpenAI
    base_url="https://abc123.ngrok-free.app"  # Ваш ngrok URL
)

response = client.chat.completions.create(
    model="gemini-2.5-pro-preview-06-05",  # Из вашего config.yml
    messages=[
        {"role": "user", "content": "Привет!"}
    ]
)

print(response.choices[0].message.content)
```

## Настройка постоянного домена (опционально):

В бесплатной версии ngrok URL меняется при каждом перезапуске. Для постоянного домена:

1. Перейдите на https://dashboard.ngrok.com/cloud-edge/domains
2. Зарегистрируйте бесплатный домен (например, `my-litellm.ngrok-free.app`)
3. Используйте команду:
```bash
ngrok http 4000 --domain=my-litellm.ngrok-free.app
```

Или обновите `start-ngrok.bat`:
```batch
ngrok http 4000 --domain=my-litellm.ngrok-free.app
```

## Остановка:

1. Нажмите `Ctrl+C` в окне ngrok
2. Закройте окно с LiteLLM или нажмите `Ctrl+C`

## Troubleshooting:

### Порт 4000 занят
Измените порт в `config.yml`:
```yaml
general_settings:
  port: 4001  # или другой свободный порт
```

И обновите команду ngrok:
```bash
ngrok http 4001
```

### ngrok не найден
Убедитесь, что ngrok добавлен в PATH или используйте полный путь:
```batch
C:\path\to\ngrok.exe http 4000
```

### Ошибка авторизации ngrok
Выполните:
```bash
ngrok config add-authtoken YOUR_TOKEN
```

### Проверка работы LiteLLM
Откройте в браузере: http://localhost:4000/health

## Безопасность:

⚠️ **Важно**: ngrok делает ваш локальный сервер доступным в интернете. 

Рекомендации:
- Используйте аутентификацию в LiteLLM (настройте в `config.yml`)
- Не храните секретные API ключи в открытом виде
- Рассмотрите использование ngrok с аутентификацией:
  ```bash
  ngrok http 4000 --basic-auth="username:password"
  ```

## Сравнение с Fly.io:

| Параметр | Локально + ngrok | Fly.io |
|----------|------------------|--------|
| Стоимость | Бесплатно | Бесплатный тариф доступен |
| Производительность | Зависит от вашего ПК | Высокая |
| Доступность | Только когда ПК включен | 24/7 |
| Настройка | Простая | Требует деплоя |
| Масштабирование | Ограничено | Автоматическое |
