FROM docker.litellm.ai/berriai/litellm:main-stable

WORKDIR /app

# Копируем конфигурационный файл
COPY config.yml /app/config.yml

# Открываем порт (по умолчанию litellm использует 4000)
EXPOSE 4000

# Запускаем litellm с конфигурационным файлом
CMD ["--port", "4000", "--config", "/app/config.yml"]
