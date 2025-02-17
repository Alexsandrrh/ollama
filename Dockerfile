FROM ollama/ollama

RUN /bin/ollama serve

EXPOSE 11434
