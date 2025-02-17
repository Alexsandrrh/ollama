# Используем базовый образ Ubuntu 20.04
FROM ubuntu:20.04

# Устанавливаем необходимые зависимости
RUN apt-get update && apt-get install -y \
    wget \
    tar \
    ca-certificates \
    libglib2.0-0 \
    libsm6 \
    libxext6 \
    libxrender1 \
    && rm -rf /var/lib/apt/lists/*

# Скачиваем и устанавливаем Ollama (замените URL на актуальный, если необходимо)
RUN wget -O /tmp/ollama.tar.gz "https://example.com/ollama-linux-cpu.tar.gz" && \
    tar -xzvf /tmp/ollama.tar.gz -C /usr/local/bin && \
    rm /tmp/ollama.tar.gz && \
    chmod +x /usr/local/bin/ollama

# (Опционально) Скачиваем модель llama3.1:latest, если она не загружается динамически.
# Здесь предполагается, что модель будет скачана при первом запуске или уже установлена.
# RUN wget -O /models/llama3.1.tar.gz "https://example.com/llama3.1.tar.gz" && \
#     mkdir -p /models/llama3.1 && \
#     tar -xzvf /models/llama3.1.tar.gz -C /models/llama3.1 && \
#     rm /models/llama3.1.tar.gz

# Открываем порт, если Ollama предоставляет API или веб-интерфейс (при необходимости)
EXPOSE 8080

# Задаем переменные окружения (если требуется)
ENV MODEL=llama3.1:latest

# Запускаем Ollama в режиме сервера, используя CPU (флаг --cpu-only, если предусмотрен)
CMD ["/usr/local/bin/ollama", "serve", "--model", "llama3.1:latest", "--cpu-only"]
