# pjla_contabil_backend

## objetivo

backend de escritorio contabil

## ler os arquivos
- processo1.md
- processo2.md

para saber como lidar com a arquitetura
- docker
- docker compose
- prisma orm

## tecnologias
- nodejs
- prisma orm
- fastfy
- dotenv

## OBSERVAÇÕES

tentar subir tudo no docker compose

tratar a base de dados direto do ORM

usar `npx prisma studio` ou `pgdmin`

gerar endpoints no fastfy

## endpoints

### plano_contas_referencial

GET /api/plano_contas_referencial
GET /api/plano_contas_referencial/{id}
POST /api/plano_contas_referencial
PUT /api/plano_contas_referencial/{id}
DELETE /api/plano_contas_referencial/{id}

### empresa

GET /api/empresa
GET /api/empresa/{id}
GET /api/empresa/{cnpj}
POST /api/empresa
PUT /api/empresa/{id}
DELETE /api/empresa/{id}

### plano_contas

GET /api/plano_contas
GET /api/plano_contas/{id}
POST /api/plano_contas
PUT /api/plano_contas/{id}
DELETE /api/plano_contas/{id}
GET /api/empresa/{id}/plano_contas/{codigo}
GET /api/empresa/{id}/plano_contas/{nome}

### centro de custo
GET /api/centro_custos
GET /api/empresa/{id}/centro_custos
GET /api/empresa/{id}/centro_custos/{id}
GET /api/centro_custos/{id}
POST /api/centro_custos
PUT /api/centro_custos/{id}
DELETE /api/centro_custos/{id}


### lancamento

GET /api/lancamento
GET /api/lancamento/{data}
GET /api/empresa/{id}/lancamento
GET /api/empresa/{id}/lancamento/{data}
GET /api/lancamento/{id}
GET /api/lancamento/{id}/itens
POST /api/lancamento
PUT /api/lancamento/{id}
PUT /api/lancamento/{id}/item/{idLancamentoItem}
DELETE /api/lancamento/{id}/item/{idLancamentoItem}
DELETE /api/lancamento/{id}

### mapa das demonstracoes

GET /api/mapademonstracoes
GET /api/mapademonstracoes/{id}
GET /api/plano_contas/{id}/mapademonstracoes/{id}
POST /api/mapademonstracoes
PUT /api/mapademonstracoes/{id}
DELETE /api/mapademonstracoes/{id}

### SpedMapping

GET /api/spedmapping
GET /api/spedmapping/{id}
GET /api/plano_contas/{contaid}/spedmapping
GET /api/plano_contas/{contaid}/spedmapping/{id}
GET /api/plano_contas/{contaid}/spedmapping/{spedcode}
POST /api/spedmapping
PUT /api/spedmapping/{id}
DELETE /api/spedmapping/{id}

### Usuario

GET /api/usuario
GET /api/usuario/{id}
GET /api/usuario/{isActive}
POST /api/usuario
PUT /api/usuario/{id}
DELETE /api/usuario/{id}

