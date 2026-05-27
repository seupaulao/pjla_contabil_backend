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

docker run -d --name postgres-db -p 5432:5432 -v postgres_data:/var/lib/postgresql/data  meu-postgres

**entrar no container**

docker exec -it postgres-db psql -U postgres -d contabilidade

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


## Instalação das dependências Fastify

Para adicionar o Fastify e as dependências de tipagem utilizadas na implementação, execute:

```
npm install fastify @fastify/type-provider-typebox @sinclair/typebox
```

## Implementação Fastify + Prisma

Foram implementados serviços REST utilizando Fastify e Prisma para as seguintes operações:

- Buscar usuário por id: `GET /users/:id`
- Buscar post por id: `GET /posts/:id`
- Buscar todos os posts de um usuário: `GET /users/:id/posts`
- Cadastrar um usuário (com ou sem posts): `POST /users`
- Atualizar um usuário: `PUT /users/:id`
- Deletar um usuário e seus posts: `DELETE /users/:id`
- Deletar um post específico: `DELETE /posts/:id`

Consulte exemplos de payloads e respostas no arquivo `examples_api_payloads.md`.

O servidor pode ser iniciado com:

```
npx tsx server.ts
```


## Considerações finais e futuras implementações

- **Autenticação e Autorização:**
  - Para ambientes de produção, recomenda-se implementar autenticação (ex: JWT, OAuth) e autorização para proteger as rotas e garantir que apenas usuários autorizados possam acessar ou modificar recursos.
  - Utilizar plugins como `@fastify/jwt` ou middlewares customizados.
- **Validação de dados:**
  - Adicionar validação mais robusta dos dados de entrada, utilizando bibliotecas como Zod ou Joi, além do TypeBox já utilizado nos schemas das rotas.
- **Tratamento de erros:**
  - Implementar um middleware global para tratamento padronizado de erros e respostas.
- **Logs e monitoramento:**
  - Adicionar logs estruturados e monitoramento para rastrear requisições e identificar problemas em produção.
- **Testes automatizados:**
  - Criar testes automatizados para garantir a qualidade e estabilidade da API.
- **Rate limiting e CORS:**
  - Configurar limites de requisições e CORS conforme necessidade do projeto.

Essas melhorias são essenciais para garantir segurança, escalabilidade e robustez em ambientes reais.




