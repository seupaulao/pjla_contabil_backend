/*
  Warnings:

  - You are about to drop the column `conta_pai_id` on the `plano_contas` table. All the data in the column will be lost.

*/
-- DropForeignKey
ALTER TABLE "plano_contas" DROP CONSTRAINT "plano_contas_conta_pai_id_fkey";

-- AlterTable
ALTER TABLE "plano_contas" DROP COLUMN "conta_pai_id",
ALTER COLUMN "tipo" DROP NOT NULL,
ALTER COLUMN "nivel" DROP NOT NULL;
