import { prisma } from "./lib/prisma";

async function main() {
const comandos = [
  { id: 1, codigo: "1", nome: "Ativo", tipo: "S", natureza: "D", nivel: 1, grupo: "ATIVO", dreGrupo: "", fluxoCaixaTipo: "", parentId: null, },
  { id: 2, codigo: "2", nome: "Passivo", tipo: "S", natureza: "C", nivel: 1, grupo: "PASSIVO", dreGrupo: "", fluxoCaixaTipo: "", parentId: null, },
  { id: 3, codigo: "3", nome: "Patrimonio Liquido", tipo: "S", natureza: "C", nivel: 1, grupo: "PL", dreGrupo: "", fluxoCaixaTipo: "", parentId: null, },
  { id: 4, codigo: "4", nome: "Resultado", tipo: "S", natureza: "C", nivel: 1, grupo: "RESULTADO", dreGrupo: "", fluxoCaixaTipo: "", parentId: null }, 
  { id: 5, codigo: "5", nome: "Despesa", tipo: "S", natureza: "D", nivel: 1, grupo: "DESPESA", dreGrupo: "", fluxoCaixaTipo: "", parentId: null, },
  { id: 11, codigo: "1.1", nome: "Caixa", tipo: "A", natureza: "D", nivel: 2, grupo: "ATIVO", dreGrupo: "", fluxoCaixaTipo: "", parentId: 1, },
  { id: 12, codigo: "1.2", nome: "Banco", tipo: "S", natureza: "D", nivel: 2, grupo: "ATIVO", dreGrupo: "", fluxoCaixaTipo: "", parentId: 1, },
  { id: 13, codigo: "1.3", nome: "Contas a receber", tipo: "S", natureza: "D", nivel: 2, grupo: "ATIVO", dreGrupo: "", fluxoCaixaTipo: "", parentId: 1, },
  { id: 14, codigo: "1.4", nome: "Imobilizado", tipo: "S", natureza: "D", nivel: 2, grupo: "ATIVO", dreGrupo: "", fluxoCaixaTipo: "", parentId: 1, },
  { id: 21, codigo: "2.1", nome: "Fornecedores", tipo: "A", natureza: "C", nivel: 2, grupo: "PASSIVO", dreGrupo: "", fluxoCaixaTipo: "", parentId: 2, },
  { id: 22, codigo: "2.2", nome: "Impostos a Recolher", tipo: "S", natureza: "C", nivel: 2, grupo: "PASSIVO", dreGrupo: "", fluxoCaixaTipo: "", parentId: 2, },
  { id: 23, codigo: "2.3", nome: "INSS a Recolher", tipo: "A", natureza: "C", nivel: 2, grupo: "PASSIVO", dreGrupo: "", fluxoCaixaTipo: "", parentId: 2, },
  { id: 24, codigo: "2.4", nome: "Pró-labore a Pagar", tipo: "A", natureza: "C", nivel: 2, grupo: "PASSIVO", dreGrupo: "", fluxoCaixaTipo: "", parentId: 2, },
  { id: 31, codigo: "3.1", nome: "Capital Social", tipo: "A", natureza: "C", nivel: 2, grupo: "PL", dreGrupo: "", fluxoCaixaTipo: "", parentId: 3, },
  { id: 32, codigo: "3.2", nome: "Lucros Acumulados", tipo: "A", natureza: "C", nivel: 2, grupo: "PL", dreGrupo: "", fluxoCaixaTipo: "", parentId: 3, },
  { id: 33, codigo: "3.3", nome: "Distribuição de Lucros", tipo: "A", natureza: "C", nivel: 2, grupo: "PL", dreGrupo: "", fluxoCaixaTipo: "", parentId: 3, },
  { id: 41, codigo: "4.1", nome: "Receita de Plantão", tipo: "S", natureza: "C", nivel: 2, grupo: "RECEITA", dreGrupo: "", fluxoCaixaTipo: "", parentId: 4 }, 
  { id: 42, codigo: "4.2", nome: "Receita de Consultas", tipo: "A", natureza: "C", nivel: 2, grupo: "RECEITA", dreGrupo: "", fluxoCaixaTipo: "", parentId: 4 }, 
  { id: 43, codigo: "4.3", nome: "Rendimentos Financeiros", tipo: "A", natureza: "C", nivel: 2, grupo: "RECEITA", dreGrupo: "", fluxoCaixaTipo: "", parentId: 4 }, 
  { id: 51, codigo: "5.1", nome: "Aluguel", tipo: "A", natureza: "D", nivel: 2, grupo: "DESPESA", dreGrupo: "", fluxoCaixaTipo: "", parentId: 5, },
  { id: 52, codigo: "5.2", nome: "Internet", tipo: "A", natureza: "D", nivel: 2, grupo: "DESPESA", dreGrupo: "", fluxoCaixaTipo: "", parentId: 5, },
  { id: 53, codigo: "5.3", nome: "Energia", tipo: "A", natureza: "D", nivel: 2, grupo: "DESPESA", dreGrupo: "", fluxoCaixaTipo: "", parentId: 5, },
  { id: 54, codigo: "5.4", nome: "Software", tipo: "A", natureza: "D", nivel: 2, grupo: "DESPESA", dreGrupo: "", fluxoCaixaTipo: "", parentId: 5, },
  { id: 55, codigo: "5.5", nome: "Contabilidade", tipo: "A", natureza: "D", nivel: 2, grupo: "DESPESA", dreGrupo: "", fluxoCaixaTipo: "", parentId: 5, },
  { id: 56, codigo: "5.6", nome: "Pró-labore", tipo: "A", natureza: "D", nivel: 2, grupo: "DESPESA", dreGrupo: "", fluxoCaixaTipo: "", parentId: 5, },
  { id: 57, codigo: "5.7", nome: "INSS", tipo: "A", natureza: "D", nivel: 2, grupo: "DESPESA", dreGrupo: "", fluxoCaixaTipo: "", parentId: 5, },
  { id: 58, codigo: "5.8", nome: "DAS", tipo: "A", natureza: "D", nivel: 2, grupo: "DESPESA", dreGrupo: "", fluxoCaixaTipo: "", parentId: 5, },
  { id: 59, codigo: "5.9", nome: "ISS", tipo: "A", natureza: "D", nivel: 2, grupo: "DESPESA", dreGrupo: "", fluxoCaixaTipo: "", parentId: 5, },
  { id: 510, codigo: "5.10", nome: "Tarifas Bancárias", tipo: "A", natureza: "D", nivel: 2, grupo: "DESPESA", dreGrupo: "", fluxoCaixaTipo: "", parentId: 5, },
  { id: 511, codigo: "5.11", nome: "Juros", tipo: "A", natureza: "D", nivel: 2, grupo: "DESPESA", dreGrupo: "", fluxoCaixaTipo: "", parentId: 5, },
  { id: 121, codigo: "1.2.1", nome: "Conta Corrente", tipo: "A", natureza: "D", nivel: 3, grupo: "ATIVO", dreGrupo: "", fluxoCaixaTipo: "", parentId: 12, },
  { id: 122, codigo: "1.2.2", nome: "Conta Digital", tipo: "A", natureza: "D", nivel: 3, grupo: "ATIVO", dreGrupo: "", fluxoCaixaTipo: "", parentId: 12, },
  { id: 131, codigo: "1.3.1", nome: "SOPAI", tipo: "A", natureza: "D", nivel: 3, grupo: "ATIVO", dreGrupo: "", fluxoCaixaTipo: "", parentId: 13, },
  { id: 132, codigo: "1.3.2", nome: "Hospital B", tipo: "A", natureza: "D", nivel: 3, grupo: "ATIVO", dreGrupo: "", fluxoCaixaTipo: "", parentId: 13, },  
  { id: 141, codigo: "1.4.1", nome: "Equipamentos", tipo: "A", natureza: "D", nivel: 3, grupo: "ATIVO", dreGrupo: "", fluxoCaixaTipo: "", parentId: 14, },
  { id: 142, codigo: "1.4.2", nome: "Computadores", tipo: "A", natureza: "D", nivel: 3, grupo: "ATIVO", dreGrupo: "", fluxoCaixaTipo: "", parentId: 14, },
  { id: 221, codigo: "2.2.1", nome: "DAS a Recolher", tipo: "A", natureza: "C", nivel: 3, grupo: "PASSIVO", dreGrupo: "", fluxoCaixaTipo: "", parentId: 22, },
  { id: 222, codigo: "2.2.2", nome: "ISS a Recolher", tipo: "A", natureza: "C", nivel: 3, grupo: "PASSIVO", dreGrupo: "", fluxoCaixaTipo: "", parentId: 22, },
  { id: 411, codigo: "4.1.1", nome: "Plantão SOPAI", tipo: "A", natureza: "C", nivel: 3, grupo: "RECEITA", dreGrupo: "", fluxoCaixaTipo: "", parentId: 41 }, 
  { id: 412, codigo: "4.1.2", nome: "Plantão Hospital B", tipo: "A", natureza: "C", nivel: 3, grupo: "RECEITA", dreGrupo: "", fluxoCaixaTipo: "", parentId: 41 }, 


];

await prisma.planoContasReferencial.createMany({
  data: comandos,
  skipDuplicates: true,
});

  console.log('Plano de Contas Referencial pré-populado com sucesso.');

}

main()
  .then(async () => {
    await prisma.$disconnect();
  })
  .catch(async (e) => {
    console.error(e);
    await prisma.$disconnect();
    process.exit(1);
  });