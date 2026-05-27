import Fastify from 'fastify';
import { Type } from '@sinclair/typebox';
import { prisma } from './lib/prisma';

const fastify = Fastify({ logger: true });

// =========================
// plano_contas_referencial
// =========================
fastify.get('/api/plano_contas_referencial', async (request, reply) => {
  const result = await prisma.planoContasReferencial.findMany();
  reply.send(result);
});

fastify.get('/api/plano_contas_referencial/:id', async (request, reply) => {
  const { id } = request.params as any;
  const result = await prisma.planoContasReferencial.findUnique({ where: { id: Number(id) } });
  if (!result) return reply.code(404).send({ error: 'Not found' });
  reply.send(result);
});

fastify.post('/api/plano_contas_referencial', async (request, reply) => {
  const data = request.body as any;
  const result = await prisma.planoContasReferencial.create({ data });
  reply.code(201).send(result);
});

fastify.put('/api/plano_contas_referencial/:id', async (request, reply) => {
  const { id } = request.params as any;
  const data = request.body as any;
  const result = await prisma.planoContasReferencial.update({ where: { id: Number(id) }, data });
  reply.send(result);
});

fastify.delete('/api/plano_contas_referencial/:id', async (request, reply) => {
  const { id } = request.params as any;
  await prisma.planoContasReferencial.delete({ where: { id: Number(id) } });
  reply.code(204).send();
});

// =========================
// empresa
// =========================
fastify.get('/api/empresa', async (request, reply) => {
  const result = await prisma.empresa.findMany();
  reply.send(result);
});

fastify.get('/api/empresa/:id', async (request, reply) => {
  const { id } = request.params as any;
  const result = await prisma.empresa.findUnique({ where: { id: Number(id) } });
  if (!result) return reply.code(404).send({ error: 'Not found' });
  reply.send(result);
});

fastify.post('/api/empresa', async (request, reply) => {
  const data = request.body as any;
  const result = await prisma.empresa.create({ data });
  reply.code(201).send(result);
});

fastify.put('/api/empresa/:id', async (request, reply) => {
  const { id } = request.params as any;
  const data = request.body as any;
  const result = await prisma.empresa.update({ where: { id: Number(id) }, data });
  reply.send(result);
});

fastify.delete('/api/empresa/:id', async (request, reply) => {
  const { id } = request.params as any;
  await prisma.empresa.delete({ where: { id: Number(id) } });
  reply.code(204).send();
});

// =========================
// plano_contas
// =========================
fastify.get('/api/plano_contas', async (request, reply) => {
  const result = await prisma.planoContas.findMany();
  reply.send(result);
});

fastify.get('/api/plano_contas/:id', async (request, reply) => {
  const { id } = request.params as any;
  const result = await prisma.planoContas.findUnique({ where: { id: Number(id) } });
  if (!result) return reply.code(404).send({ error: 'Not found' });
  reply.send(result);
});

fastify.post('/api/plano_contas', async (request, reply) => {
  const data = request.body as any;
  const result = await prisma.planoContas.create({ data });
  reply.code(201).send(result);
});

fastify.put('/api/plano_contas/:id', async (request, reply) => {
  const { id } = request.params as any;
  const data = request.body as any;
  const result = await prisma.planoContas.update({ where: { id: Number(id) }, data });
  reply.send(result);
});

fastify.delete('/api/plano_contas/:id', async (request, reply) => {
  const { id } = request.params as any;
  await prisma.planoContas.delete({ where: { id: Number(id) } });
  reply.code(204).send();
});

// =========================
// Inicialização do servidor
// =========================
const start = async () => {
  try {
    await fastify.listen({ port: 3000, host: '0.0.0.0' });
    console.log('Servidor rodando em http://localhost:3000');
  } catch (err) {
    fastify.log.error(err);
    process.exit(1);
  }
};

start();
