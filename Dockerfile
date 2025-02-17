# Используем официальный образ Ubuntu 22.04
FROM ubuntu:22.04

# Обновляем пакеты и устанавливаем необходимые утилиты
RUN apt-get update && apt-get install -y \
    curl \
    ca-certificates \
    tar \
    && rm -rf /var/lib/apt/lists/*

# Переходим в рабочую директорию /tmp
WORKDIR /tmp

# Скачиваем архив с бинарником Ollama для ARM64 (версия v0.5.11)
RUN curl -L -o ollama.tgz https://github.com/ollama/ollama/releases/download/v0.5.11/ollama-linux-arm64.tgz

# Распаковываем архив
RUN tar -xzf ollama.tgz

# Предполагаем, что в архиве содержится бинарный файл с именем "ollama"
# Перемещаем его в /usr/local/bin и делаем исполняемым
RUN mv ollama /usr/local/bin/ollama && chmod +x /usr/local/bin/ollama

# Открываем порт, используемый Ollama (по умолчанию 11434)
EXPOSE 11434

# Задаём переменную окружения, чтобы Ollama не использовал GPU (вычисления на CPU)
ENV CUDA_VISIBLE_DEVICES=""

# Запускаем Ollama в режиме CPU
CMD ["ollama", "start", "--cpu"]
