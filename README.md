Full Cycle Rocks!!

Desafio da formação Full Cycle para criação de uma imagem Docker com uma aplicação desenvolvida em Go.

Objetivo

O objetivo do desafio foi criar e publicar uma imagem Docker que execute uma aplicação Go e imprima a mensagem:

Full Cycle Rocks!!

A imagem final deveria ter menos de 2 MB.

Solução

A aplicação foi desenvolvida em Go e colocada em um container utilizando multi-stage build.

Na primeira etapa é utilizada a imagem golang:1.26 para compilar a aplicação. Depois, somente o binário gerado é copiado para uma imagem scratch, deixando a imagem final bem menor.

Também foram utilizadas algumas otimizações na compilação, como CGO_ENABLED=0, -trimpath e -ldflags="-s -w", para reduzir o tamanho do binário.

Estrutura do projeto

docker-desafio/
Dockerfile
go.mod
main.go
README.md

Dockerfile

FROM golang:1.26 AS builder

WORKDIR /app

COPY . .

RUN CGO_ENABLED=0 go build -trimpath -ldflags="-s -w" -o app .

FROM scratch

COPY --from=builder /app/app /app

ENTRYPOINT ["/app"]

Resultado

A imagem final ficou com 1.772.297 bytes no teste local, ficando abaixo do limite de 2 MB definido pelo desafio.

Para testar localmente:

docker run --rm fullcycle:optimized

Resultado:

Full Cycle Rocks!!

Docker Hub

A imagem também foi publicada no Docker Hub:

https://hub.docker.com/r/alansiloliveir/fullcycle
Para executar a imagem publicada:

docker run alansiloliveir/fullcycle

O resultado esperado é:

Full Cycle Rocks!!

Build local

Para gerar a imagem localmente:

docker build -t fullcycle .

Tecnologias utilizadas

Go
Docker
Docker Hub
Multi-stage Build
