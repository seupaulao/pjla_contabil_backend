import Fastify from 'fastify';
import { Type } from '@sinclair/typebox';
import { prisma } from './lib/prisma';
import { AssinaturaService } from './assinatura';

const assinaturaService = new AssinaturaService();

const fastify = Fastify({ logger: true });


//trava contabil

fastify.post('/api/trava_contabil', async (request, reply) => {
  const data = request.body as any;
  const result = await prisma.travaContabil.create({ data });
  reply.code(201).send(result);
});
fastify.get('/api/empresa/:id/trava_contabil', async (request, reply) => {
  const { id } = request.params as any;
  const result = await prisma.travaContabil.findMany({ where: { empresaId: Number(id) } });
  reply.send(result);
});
fastify.get('/api/trava_contabil/:id', async (request, reply) => {
  const { id } = request.params as any;
  const result = await prisma.travaContabil.findUnique({ where: { id: id } });
  if (!result) return reply.code(404).send({ error: 'Not found' });
  reply.send(result);
});
fastify.put('/api/trava_contabil/:id', async (request, reply) => {
  const { id } = request.params as any;
  const data = request.body as any;
  const result = await prisma.travaContabil.update({ where: { id: id }, data });
  reply.send(result);
});
fastify.delete('/api/trava_contabil/:id', async (request, reply) => {
  const { id } = request.params as any;
  await prisma.travaContabil.delete({ where: { id: id } });
  reply.code(204).send();
});

// =========================
// empresa - prestadora de serviço
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
// tomador - empresa tomadora do serviço
// =========================
fastify.get('/api/tomador', async (request, reply) => {
  const result = await prisma.tomador.findMany();
  reply.send(result);
});

fastify.get('/api/tomador/:id', async (request, reply) => {
  const { id } = request.params as any;
  const result = await prisma.tomador.findUnique({ where: { id: Number(id) } });
  if (!result) return reply.code(404).send({ error: 'Not found' });
  reply.send(result);
});

fastify.post('/api/tomador', async (request, reply) => {
  const data = request.body as any;
  const result = await prisma.tomador.create({ data });
  reply.code(201).send(result);
});

fastify.put('/api/tomador/:id', async (request, reply) => {
  const { id } = request.params as any;
  const data = request.body as any;
  const result = await prisma.tomador.update({ where: { id: Number(id) }, data });
  reply.send(result);
});

fastify.delete('/api/tomador/:id', async (request, reply) => {
  const { id } = request.params as any;
  await prisma.tomador.delete({ where: { id: Number(id) } });
  reply.code(204).send();
});

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
// plano_contas
// =========================
fastify.get('/api/plano_contas', async (request, reply) => {
  const result = await prisma.planoContas.findMany();
  reply.send(result);
});

fastify.get('/api/empresa/:id/plano_contas', async (request, reply) => {
  const { id } = request.params as any;
  const result = await prisma.planoContas.findMany({ where: { empresaId: Number(id) } });
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

//copiar plano conta referencial para plano de contas da empresa
fastify.post('/api/empresa/:id/copy_plano_contas_referencial', async (request, reply) => {
  const { id } = request.params as any;
  const empresa = await prisma.empresa.findUnique({ where: { id: Number(id) } });
  if (!empresa) return reply.code(404).send({ error: 'Empresa not found' });
  const planoContasReferencial = await prisma.planoContasReferencial.findMany();
  const planoContasData = planoContasReferencial.map((conta) => ({
    codigo: conta.codigo,
    descricao: conta.nome,
    tipo: conta.tipo,
    natureza: conta.natureza,
    nivel: conta.nivel,
    grupo: conta.grupo,
    dreGrupo: conta.dreGrupo,
    fluxoCaixaTipo: conta.fluxoCaixaTipo,
    planoContasReferencialId: conta.id,
    empresaId: Number(id),
  }));
  await prisma.planoContas.createMany({ data: planoContasData });
  reply.send({ message: 'Plano de Contas copiado com sucesso' });
});

// =========================
// lancamento
// =========================
fastify.get('/api/lancamento', async (request, reply) => {
  const result = await prisma.lancamento.findMany();
  reply.send(result);
});

fastify.get('/api/lancamento/:id', async (request, reply) => {
  const { id } = request.params as any;
  const result = await prisma.lancamento.findUnique({ where: { id: Number(id) } });
  if (!result) return reply.code(404).send({ error: 'Not found' });
  reply.send(result);
});

fastify.post('/api/lancamento', async (request, reply) => {
  const data = request.body as any;
  const result = await prisma.lancamento.create({ data });
  reply.code(201).send(result);
});

fastify.put('/api/lancamento/:id', async (request, reply) => {
  const { id } = request.params as any;
  const data = request.body as any;
  const result = await prisma.lancamento.update({ where: { id: Number(id) }, data });
  reply.send(result);
});

fastify.delete('/api/lancamento/:id', async (request, reply) => {
  const { id } = request.params as any;
  await prisma.lancamento.delete({ where: { id: Number(id) } });
  reply.code(204).send();
});

fastify.get('/api/empresa/:id/lancamento/:data', async (request, reply) => {
  const { id, data } = request.params as any;
  const result = await prisma.lancamento.findMany({ where: { empresaId: Number(id), data: new Date(data) } });
  if (!result) return reply.code(404).send({ error: 'Not found' });
  reply.send(result);
});

fastify.get('/api/empresa/:id/lancamento', async (request, reply) => {
  const { id } = request.params as any;
  const result = await prisma.lancamento.findMany({ where: { empresaId: Number(id) } });
  if (!result) return reply.code(404).send({ error: 'Not found' });
  reply.send(result);
});
fastify.get('/api/lancamento/:id/itens', async (request, reply) => {
  const { id } = request.params as any;
  const result = await prisma.lancamentoItem.findMany({ where: { lancamentoId: Number(id) } });
  if (!result) return reply.code(404).send({ error: 'Not found' });
  reply.send(result);
});

fastify.get('/api/lancamento/:id/itens/:idLancamentoItem', async (request, reply) => {
  const { id, idLancamentoItem } = request.params as any;
  const result = await prisma.lancamentoItem.findUnique({ where: { id: Number(idLancamentoItem), lancamentoId: Number(id) } });
  if (!result)return reply.code(404).send({ error: 'Not found' });
  reply.send(result);
});

fastify.put('/api/lancamento/:id/itens/:idLancamentoItem', async (request, reply) => {
  const { id, idLancamentoItem } = request.params as any;
  const data = request.body as any;
  const result = await prisma.lancamentoItem.update({ where: { id: Number(idLancamentoItem), lancamentoId: Number(id) }, data });
  reply.send(result);
});

fastify.delete('/api/lancamento/:id/itens/:idLancamentoItem', async (request, reply) => {
  const { id, idLancamentoItem } = request.params as any;
  await prisma.lancamentoItem.delete({ where: { id: Number(idLancamentoItem), lancamentoId: Number(id) } });
  reply.code(204).send();
});
// ### mapa das demonstracoes

// GET /api/mapademonstracoes
fastify.get('/api/mapademonstracoes', async (request, reply) => {
  const result = await prisma.mapaDemonstracoes.findMany();
  reply.send(result);
});
// GET /api/mapademonstracoes/{id}
fastify.get('/api/mapademonstracoes/:id', async (request, reply) => {
  const { id } = request.params as any;
  const result = await prisma.mapaDemonstracoes.findUnique({ where: { id: Number(id) } });
  if (!result) return reply.code(404).send({ error: 'Not found' });
  reply.send(result);
});
// GET /api/plano_contas/{id}/mapademonstracoes/{id}
fastify.get('/api/plano_contas/:id/mapademonstracoes/:idMapa', async (request, reply) => {
  const { id, idMapa } = request.params as any;
  const result = await prisma.mapaDemonstracoes.findUnique({ where: { id: Number(idMapa), contaId: Number(id) } });
  if (!result) return reply.code(404).send({ error: 'Not found' });
  reply.send(result);
});
// POST /api/mapademonstracoes
fastify.post('/api/mapademonstracoes', async (request, reply) => {
  const data = request.body as any;
  const result = await prisma.mapaDemonstracoes.create({ data });
  reply.code(201).send(result);
});
// PUT /api/mapademonstracoes/{id}
fastify.put('/api/mapademonstracoes/:id', async (request, reply) => {
  const { id } = request.params as any;
  const data = request.body as any;
  const result = await prisma.mapaDemonstracoes.update({ where: { id: Number(id) }, data });
  reply.send(result);
});
// DELETE /api/mapademonstracoes/{id}
fastify.delete('/api/mapademonstracoes/:id', async (request, reply) => {
  const { id } = request.params as any;
  await prisma.mapaDemonstracoes.delete({ where: { id: Number(id) } });
  reply.code(204).send();
});

// ### SpedMapping

fastify.get('/api/spedmapping', async (request, reply) => {
  const result = await prisma.spedMapping.findMany();
  reply.send(result);
});

fastify.get('/api/plano_contas/:contaid/spedmapping/:spedcode', async (request, reply) => {
  const { contaid, spedcode } = request.params as any;
  const result = await prisma.spedMapping.findMany({ where: { contaId: Number(contaid), spedCode: spedcode } });
  if (!result) return reply.code(404).send({ error: 'Not found' });
  reply.send(result);
});
 
fastify.get('/api/plano_contas/:contaid/spedmapping', async (request, reply) => {
  const { contaid } = request.params as any;
  const result = await prisma.spedMapping.findMany({ where: { contaId: Number(contaid) } });
  if (!result) return reply.code(404).send({ error: 'Not found' });
  reply.send(result);
});

fastify.post('/api/spedmapping', async (request, reply) => {
  const data = request.body as any;
  const result = await prisma.spedMapping.create({ data });
  reply.code(201).send(result);
});

fastify.put('/api/spedmapping/:id', async (request, reply) => {
  const { id } = request.params as any;
  const data = request.body as any;
  const result = await prisma.spedMapping.update({ where: { id: id }, data });
  reply.send(result);
});

fastify.delete('/api/spedmapping/:id', async (request, reply) => {
  const { id } = request.params as any;
  await prisma.spedMapping.delete({ where: { id: id } });
  reply.code(204).send();
});

// ### Usuario

fastify.get('/api/usuario', async (request, reply) => {
  const result = await prisma.usuario.findMany();
  reply.send(result);
});

fastify.get('/api/usuario/:id', async (request, reply) => {
  const { id } = request.params as any;
  const result = await prisma.usuario.findUnique({ where: { id: id } });
  if (!result) return reply.code(404).send({ error: 'Not found' });
  reply.send(result);
});

fastify.get('/api/usuario/active/:isActive', async (request, reply) => {
  const { isActive } = request.params as any;
  const result = await prisma.usuario.findMany({ where: { isActive: isActive === 'true' } });
  if (!result) return reply.code(404).send({ error: 'Not found' });
  reply.send(result);
});

fastify.post('/api/usuario', async (request, reply) => {
  const data = request.body as any;
  const result = await prisma.usuario.create({ data });
  reply.code(201).send(result);
});

fastify.put('/api/usuario/:id', async (request, reply) => {
  const { id } = request.params as any;
  const data = request.body as any;
  const result = await prisma.usuario.update({ where: { id: id }, data });
  reply.send(result);
});

fastify.delete('/api/usuario/:id', async (request, reply) => {
  const { id } = request.params as any;
  await prisma.usuario.delete({ where: { id: id } });
  reply.code(204).send();
});

//========================
//crud assinatura digital
//========================

fastify.post('/api/assinar', async (request, reply) => {
  const { xml } = request.body as any;
  const xmlAssinado = await assinaturaService.assinar(xml);
  reply.send({ xmlAssinado });
});

fastify.get('/api/assinatura_digital', async (request, reply) => {
  const result = await prisma.assinaturaDigital.findMany();
  reply.send(result);
});
fastify.get('/api/assinatura_digital/:id', async (request, reply) => {
  const { id } = request.params as any;
  const result = await prisma.assinaturaDigital.findUnique({ where: { id: id } });
  if (!result) return reply.code(404).send({ error: 'Not found' });
  reply.send(result);
});
fastify.post('/api/assinatura_digital', async (request, reply) => {
  const data = request.body as any;
  const result = await prisma.assinaturaDigital.create({ data });
  reply.code(201).send(result);
});
fastify.put('/api/assinatura_digital/:id', async (request, reply) => {
  const { id } = request.params as any;
  const data = request.body as any;
  const result = await prisma.assinaturaDigital.update({ where: { id: id }, data });
  reply.send(result);
});
fastify.delete('/api/assinatura_digital/:id', async (request, reply) => {
  const { id } = request.params as any;
  await prisma.assinaturaDigital.delete({ where: { id: id } });
  reply.code(204).send();
});

//========================
//crud certificado digital
//========================

fastify.get('/api/certificado_digital', async (request, reply) => {
  const result = await prisma.certificadoDigital.findMany();
  reply.send(result);
});
fastify.get('/api/certificado_digital/:id', async (request, reply) => {
  const { id } = request.params as any;
  const result = await prisma.certificadoDigital.findUnique({ where: { id: id } });
  if (!result) return reply.code(404).send({ error: 'Not found' });
  reply.send(result);
});
fastify.post('/api/certificado_digital', async (request, reply) => {
  const data = request.body as any;
  const result = await prisma.certificadoDigital.create({ data });
  reply.code(201).send(result);
});
fastify.put('/api/certificado_digital/:id', async (request, reply) => {
  const { id } = request.params as any;
  const data = request.body as any;
  const result = await prisma.certificadoDigital.update({ where: { id: id }, data });
  reply.send(result);
});
fastify.delete('/api/certificado_digital/:id', async (request, reply) => {
  const { id } = request.params as any;
  await prisma.certificadoDigital.delete({ where: { id: id } });
  reply.code(204).send();
});

//========================
//crud nota fiscal
//========================

//serviço para criar nota fiscal, assinar e atualizar status - DEVE VALIDAR AINDA
fastify.post("/nfe", async (req, reply) => {

   const nota = await prisma.notaFiscal.create({
      data: {
         numero: 1,
         xml: "<NFe>...</NFe>",
         status: "CRIADA"
      }
   });

   const xmlAssinado =
      await assinaturaService.assinar(nota.xml);

   await prisma.notaFiscal.update({
      where: { id: nota.id },
      data: {
         xmlAssinado,
         status: "ASSINADA"
      }
   });

   return {
      sucesso: true
   };
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
