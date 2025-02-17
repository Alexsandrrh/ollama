# Используем официальный образ Ubuntu 22.04 в качестве базового
FROM ubuntu:22.04

# Обновляем пакеты и устанавливаем необходимые утилиты
RUN apt-get update && apt-get install -y \
    curl \
    wget \
    unzip \
    ca-certificates \
    && rm -rf /var/lib/apt/lists/*

# Скачиваем архив с бинарным файлом Ollama и распаковываем его
RUN curl -L -o /tmp/ollama.zip https://ollama.com/downloads/ollama-linux.zip && \
    unzip /tmp/ollama.zip -d /usr/local/bin && \
    chmod +x /usr/local/bin/ollama && \
    rm /tmp/ollama.zip

# Открываем порт, который использует Ollama (при необходимости измените номер порта)
EXPOSE 11434

# Определяем команду для запуска Ollama
CMD ["ollama", "start"]
