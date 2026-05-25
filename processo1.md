## build da imagem

docker build -t meu-postgres .

### rodar container

docker run -d \
  --name postgres-db \
  -p 5432:5432 \
  -v postgres_data:/var/lib/postgresql/data \
  meu-postgres

### string conexao
DATABASE_URL="postgresql://postgres:postgres@localhost:5432/meubanco?schema=public"

### entrar no banco

docker exec -it postgres-db psql -U postgres -d meubanco

###  fastify com prisma

npm install @prisma/client
npm install -D prisma

### iniciando prisma

npx prisma init

### testando conexao

npx prisma db pull 
ou
npx prisma migrate dev

### estrutura

```
backend/
├── docker-compose.yml
├── .env
├── prisma/
├── src/
├── package.json
└── Dockerfile
```

## estrutura com docker-compose.yml

```
backend/
├── docker-compose.yml
├── .env
├── Dockerfile
├── package.json
├── prisma/
│   └── schema.prisma
└── src/
    ├── server.js
    └── routes/
```

## docker-compose.yml

```yaml
services:

  postgres:
    image: postgres:16
    container_name: postgres-db

    restart: always

    environment:
      POSTGRES_USER: postgres
      POSTGRES_PASSWORD: postgres
      POSTGRES_DB: contabilidade

    ports:
      - "5432:5432"

    volumes:
      - postgres_data:/var/lib/postgresql/data

  pgadmin:
    image: dpage/pgadmin4
    container_name: pgadmin

    restart: always

    environment:
      PGADMIN_DEFAULT_EMAIL: admin@admin.com
      PGADMIN_DEFAULT_PASSWORD: admin

    ports:
      - "8080:80"

    depends_on:
      - postgres

  api:
    build: .

    container_name: fastify-api

    restart: always

    ports:
      - "3000:3000"

    environment:
      DATABASE_URL: postgresql://postgres:postgres@postgres:5432/contabilidade?schema=public

    depends_on:
      - postgres

volumes:
  postgres_data:
```

## dockerfile da apinode

```yaml
FROM node:22

WORKDIR /app

COPY package*.json ./

RUN npm install

COPY . .

RUN npx prisma generate

EXPOSE 3000

CMD ["npm", "run", "dev"]
```

## Inicialização completa

### 1. Subir containers

docker compose up -d

### 2. Entrar no container API

docker exec -it fastify-api sh

### 3. Criar migration

npx prisma migrate dev --name init

## PgAdmin

**Acesso**

`http://localhost:8080`

**Login**

`admin@admin.com`

**Senha**

`admin`