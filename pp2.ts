import { prisma } from "./lib/prisma";

async function main() {
  const comando2 = {
     data: {
      codigo: "Alice2",
      nome: "alice2@prisma.io",
      tipo: "",
      natureza: "",
      nivel: 0,
      grupo: "",
      dreGrupo: "",
      fluxoCaixaTipo: "",
      parentId: null,
      id: 0,
    },
  };
  const planoContasReferencial = await prisma.planoContasReferencial.create(comando2);
  console.log("Created planoContasReferencial:", planoContasReferencial);

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