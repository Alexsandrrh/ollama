FROM ubuntu:22.04

RUN apt-get update && apt-get install -y \
    curl \
    ca-certificates \
    tar \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /tmp

# Скачиваем архив
RUN curl -L -o ollama.tgz https://github.com/ollama/ollama/releases/download/v0.5.11/ollama-linux-arm64.tgz

# Распаковываем, перемещаем бинарник из подпапки в /usr/local/bin
RUN tar -xzf ollama.tgz \
    && mv ollama/ollama /usr/local/bin/ollama \
    && chmod +x /usr/local/bin/ollama \
    && rm ollama.tgz

EXPOSE 11434

ENV CUDA_VISIBLE_DEVICES=""

CMD ["ollama", "start", "--cpu"]
