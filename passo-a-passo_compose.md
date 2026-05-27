### montando ambiente prisma

## objetivo

teste de postgres com prisma, partindo do banco zerado
mas tendo o schema.prisma criado

- prisma - A CLI do Prisma para executar comandos como prisma init, prisma migrate, eprisma generate
- @prisma/client - A biblioteca Prisma Client para consultar seu banco de dados
- @prisma/adapter-pg - O node-postgresadaptador de driver que conecta o Prisma Client ao seu banco de dados
- pg - O driver de banco de dados node-postgres
- @types/pg - Definições de tipo TypeScript para node-postgres
- dotenv - Carrega variáveis ​​de ambiente do seu .env arquivo

- usar banco postgres docker

npm init

npm install typescript tsx @types/node --save-dev

npx tsc --init

npm install prisma @types/pg --save-dev

npm install @prisma/client @prisma/adapter-pg pg dotenv


## configurar tsconfig.json

```
{
  "compilerOptions": {
    "module": "ESNext",
    "moduleResolution": "bundler",
    "target": "ES2023",
    "strict": true,
    "esModuleInterop": true,
    "ignoreDeprecations": "6.0"
  }
}
```

## package.json
```
{
  "type": "module"
}
```

## inicializar prisma

npx prisma

## criar prisma schema

npx prisma init --datasource-provider postgresql --output ../generated/prisma

### opcional

CONNECT EXISTING DATABASE:
  1. Configure your DATABASE_URL in prisma.config.ts
  2. Run prisma db pull to introspect your database.

CREATE NEW DATABASE:
  Local: npx prisma dev (runs Postgres locally in your terminal)
  Cloud: npx create-db (creates a free Prisma Postgres database)

Then, define your models in prisma/schema.prisma and run prisma migrate dev to apply your schema.


### estrutura

```
backend/
├── docker-compose.yml
├── .env
├── prisma/
├── server.js
├── package.json
├── lib/prisma.ts
└── Dockerfile
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
      POSTGRES_DB: pjla_contabil

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

  ## secao comentada porque esta demorando subir e porque os testes estao localhost
  ## ao descomentar colocar o host da `.env` para `postgres`
  # api:
  #   build: .

  #   container_name: fastify-api

  #   restart: always

  #   ports:
  #     - "3000:3000"

  #   environment:
  #     DATABASE_URL: postgresql://postgres:postgres@postgres:5432/pjla_contabil?schema=public

  #   depends_on:
  #     - postgres

volumes:
  postgres_data:
```

## dockerfile da apinode - so rodar se no compose fastify-api estiver online

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

### 2. Entrar no container API - so rodar isso se no docker compose estiver descomentado

docker exec -it fastify-api sh

### 3. Criar migration - rodar isso dentro do container para aplicacao producao, ou fora do container para localhost

npx prisma migrate dev --name init

## PgAdmin

**Acesso**

`http://localhost:8080`

**Login**

`admin@admin.com`

**Senha**

`admin`