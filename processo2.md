## objetivo

teste de potgres com prisma, partindo do banco zerado
mas tendo o schema.prisma criado

- prisma- A CLI do Prisma para executar comandos como prisma init, prisma migrate, eprisma generate
- @prisma/client- A biblioteca Prisma Client para consultar seu banco de dados
- @prisma/adapter-pg- O node-postgresadaptador de driver que conecta o Prisma Client ao seu banco de dados
- pg- O driver de banco de dados node-postgres
- @types/pg- Definições de tipo TypeScript para node-postgres
- dotenv- Carrega variáveis ​​de ambiente do seu .env arquivo

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

## docker

Dockerfile

```
FROM postgres:16

ENV POSTGRES_USER=postgres
ENV POSTGRES_PASSWORD=postgres
ENV POSTGRES_DB=contabilidade

EXPOSE 5432

VOLUME ["/var/lib/postgresql/data"]
```
**criar container**

docker build -t meu-postgres .

**rodar container**

docker run -d --name postgres-db_2 -p 5432:5432 -v postgres_data:/var/lib/postgresql/data  meu-postgres

**entrar no container**

docker exec -it postgres-db_2 psql -U postgres -d contabilidade

## crie o modelo em prisma/schema.prisma

## migração

npx prisma migrate dev --name init


## cliente prisma lib/prisma.ts

```ts
import "dotenv/config";
import { PrismaPg } from "@prisma/adapter-pg";
import { PrismaClient } from "../generated/prisma/client";

const connectionString = `${process.env.DATABASE_URL}`;

const adapter = new PrismaPg({ connectionString });
const prisma = new PrismaClient({ adapter });

export { prisma };
```
## rodando a primeira consulta

npx tsx consulta.ts

npx prisma studio




