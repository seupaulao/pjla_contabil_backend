# Plano de Implementação dos Endpoints REST

Este documento detalha o plano de implementação dos serviços REST listados em endpoints.md, utilizando Fastify com TypeScript e Prisma ORM, centralizando as rotas no arquivo server.ts. Inclui exemplos de payload para cada endpoint.

---

## 1. Preparação do Projeto

- Instalar dependências:
  - fastify, @prisma/client, prisma, typescript, ts-node, @types/fastify, etc.
- Gerar Prisma Client a partir do schema.prisma.
- Configurar o Prisma Client em lib/prisma.ts.

---

## 2. Estruturação do Servidor Fastify

- Criar/atualizar server.ts para:
  - Inicializar o Fastify.
  - Importar o Prisma Client.
  - Configurar parser de JSON.
  - Adicionar tratamento global de erros.

---

## 3. Implementação dos Serviços

Para cada domínio, implementar rotas conforme endpoints.md. Para cada rota:
- Definir método HTTP, path e parâmetros.
- Implementar handler usando Prisma Client.
- Validar entradas (body, params, query).
- Tratar erros e retornar respostas adequadas.

### 3.1. plano_contas_referencial

- **GET /api/plano_contas_referencial**
- **GET /api/plano_contas_referencial/{id}**
- **POST /api/plano_contas_referencial**
  - Exemplo:
    ```json
    {
      "id": 1,
      "codigo": "1.01",
      "nome": "Ativo Circulante",
      "tipo": "A",
      "natureza": "D",
      "nivel": 1
    }
    ```
- **PUT /api/plano_contas_referencial/{id}**
  - Exemplo:
    ```json
    {
      "nome": "Ativo Não Circulante"
    }
    ```
- **DELETE /api/plano_contas_referencial/{id}**

### 3.2. empresa

- **GET /api/empresa**
- **GET /api/empresa/{id}**
- **GET /api/empresa/{cnpj}**
- **POST /api/empresa**
  - Exemplo:
    ```json
    {
      "cnpj": "12345678000199",
      "nome": "Empresa Exemplo",
      "uf": "SP",
      "municipio": "São Paulo",
      "dataInicio": "2024-01-01"
    }
    ```
- **PUT /api/empresa/{id}**
  - Exemplo:
    ```json
    {
      "nome": "Empresa Exemplo Ltda."
    }
    ```
- **DELETE /api/empresa/{id}**

### 3.3. plano_contas

- **GET /api/plano_contas**
- **GET /api/plano_contas/{id}**
- **POST /api/plano_contas**
  - Exemplo:
    ```json
    {
      "id": 1,
      "empresaId": 1,
      "codigo": "1.01.01",
      "descricao": "Caixa",
      "tipo": "A",
      "nivel": 2
    }
    ```
- **PUT /api/plano_contas/{id}**
  - Exemplo:
    ```json
    {
      "descricao": "Caixa Geral"
    }
    ```
- **DELETE /api/plano_contas/{id}**
- **GET /api/empresa/{id}/plano_contas/{codigo}**
- **GET /api/empresa/{id}/plano_contas/{nome}**

### 3.4. centro de custo

- **GET /api/centro_custos**
- **GET /api/empresa/{id}/centro_custos**
- **GET /api/empresa/{id}/centro_custos/{id}**
- **GET /api/centro_custos/{id}**
- **POST /api/centro_custos**
  - Exemplo:
    ```json
    {
      "empresaId": 1,
      "nome": "Administrativo"
    }
    ```
- **PUT /api/centro_custos/{id}**
  - Exemplo:
    ```json
    {
      "nome": "Financeiro"
    }
    ```
- **DELETE /api/centro_custos/{id}**

### 3.5. lancamento

- **GET /api/lancamento**
- **GET /api/lancamento/{data}**
- **GET /api/empresa/{id}/lancamento**
- **GET /api/empresa/{id}/lancamento/{data}**
- **GET /api/lancamento/{id}**
- **GET /api/lancamento/{id}/itens**
- **POST /api/lancamento**
  - Exemplo:
    ```json
    {
      "empresaId": 1,
      "data": "2024-05-01",
      "historico": "Pagamento de fornecedor",
      "tipo": "N",
      "itens": [
        { "contaId": 1, "tipo": "D", "valor": 100.00 },
        { "contaId": 2, "tipo": "C", "valor": 100.00 }
      ]
    }
    ```
- **PUT /api/lancamento/{id}**
  - Exemplo:
    ```json
    {
      "historico": "Pagamento atualizado"
    }
    ```
- **PUT /api/lancamento/{id}/item/{idLancamentoItem}**
  - Exemplo:
    ```json
    {
      "valor": 150.00
    }
    ```
- **DELETE /api/lancamento/{id}/item/{idLancamentoItem}**
- **DELETE /api/lancamento/{id}**

### 3.6. mapa das demonstracoes

- **GET /api/mapademonstracoes**
- **GET /api/mapademonstracoes/{id}**
- **GET /api/plano_contas/{id}/mapademonstracoes/{id}**
- **POST /api/mapademonstracoes**
  - Exemplo:
    ```json
    {
      "contaId": 1,
      "tipo": "DRE",
      "categoria": "Receita"
    }
    ```
- **PUT /api/mapademonstracoes/{id}**
  - Exemplo:
    ```json
    {
      "categoria": "Despesa"
    }
    ```
- **DELETE /api/mapademonstracoes/{id}**

### 3.7. SpedMapping

- **GET /api/spedmapping**
- **GET /api/spedmapping/{id}**
- **GET /api/plano_contas/{contaid}/spedmapping**
- **GET /api/plano_contas/{contaid}/spedmapping/{id}**
- **GET /api/plano_contas/{contaid}/spedmapping/{spedcode}**
- **POST /api/spedmapping**
  - Exemplo:
    ```json
    {
      "contaId": 1,
      "spedCode": "A100",
      "description": "Receita de vendas"
    }
    ```
- **PUT /api/spedmapping/{id}**
  - Exemplo:
    ```json
    {
      "description": "Receita de serviços"
    }
    ```
- **DELETE /api/spedmapping/{id}**

### 3.8. Usuario

- **GET /api/usuario**
- **GET /api/usuario/{id}**
- **GET /api/usuario/{isActive}**
- **POST /api/usuario**
  - Exemplo:
    ```json
    {
      "nome": "João Silva",
      "email": "joao@exemplo.com",
      "passwordHash": "hashsenha"
    }
    ```
- **PUT /api/usuario/{id}**
  - Exemplo:
    ```json
    {
      "nome": "João S. Silva"
    }
    ```
- **DELETE /api/usuario/{id}**

---

## 4. Integração e Organização

- Centralizar todas as rotas em server.ts, agrupando por domínio.
- Utilizar funções auxiliares para evitar duplicação de código (ex: validação, tratamento de erros).
- Garantir que todas as rotas estejam documentadas e retornem status HTTP corretos.

---

## 5. Verificação e Testes

- Testar todos os endpoints manualmente (ou com scripts automatizados, se possível).
- Validar integração com o banco de dados via Prisma.
- Corrigir eventuais erros de tipagem ou integração.

---

## Observações

- Modularização futura recomendada caso o arquivo server.ts cresça muito.
- Caso endpoints exijam lógica complexa (ex: transações), considerar uso de middlewares ou serviços auxiliares.
- Validar se todos os relacionamentos do schema.prisma estão refletidos nas respostas dos endpoints.
