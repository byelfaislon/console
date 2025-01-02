FROM golang:1.23.1 AS builder

# Defina a versão do console (pode ser "latest" ou específica)
ARG CONSOLE_VERSION="latest"

# Baixe e instale o Console
RUN go install github.com/minio/console/cmd/console@${CONSOLE_VERSION}

# Use uma imagem mais leve para o runtime
FROM debian:bullseye-slim

# Copie o binário gerado do builder
COPY --from=builder /go/bin/console /usr/local/bin/console

# Exponha a porta padrão do Console
EXPOSE 9001

# Comando para executar o Console
CMD ["console"]
