/*
  Warnings:

  - You are about to drop the column `centro_custo_id` on the `lancamento_item` table. All the data in the column will be lost.
  - You are about to drop the column `aceita_lancamento` on the `plano_contas` table. All the data in the column will be lost.
  - You are about to drop the column `codigo_referencial` on the `plano_contas` table. All the data in the column will be lost.
  - You are about to drop the `centro_custo` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `report_line_accounts` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `report_template_lines` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `report_templates` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `report_types` table. If the table is not empty, all the data it contains will be lost.

*/
-- DropForeignKey
ALTER TABLE "centro_custo" DROP CONSTRAINT "centro_custo_empresa_id_fkey";

-- DropForeignKey
ALTER TABLE "empresa_configuracao" DROP CONSTRAINT "empresa_configuracao_default_report_template_fkey";

-- DropForeignKey
ALTER TABLE "lancamento_item" DROP CONSTRAINT "lancamento_item_centro_custo_id_fkey";

-- DropForeignKey
ALTER TABLE "report_line_accounts" DROP CONSTRAINT "report_line_accounts_conta_id_fkey";

-- DropForeignKey
ALTER TABLE "report_line_accounts" DROP CONSTRAINT "report_line_accounts_report_line_id_fkey";

-- DropForeignKey
ALTER TABLE "report_template_lines" DROP CONSTRAINT "report_template_lines_parent_id_fkey";

-- DropForeignKey
ALTER TABLE "report_template_lines" DROP CONSTRAINT "report_template_lines_template_id_fkey";

-- DropForeignKey
ALTER TABLE "report_templates" DROP CONSTRAINT "report_templates_empresa_id_fkey";

-- DropForeignKey
ALTER TABLE "report_templates" DROP CONSTRAINT "report_templates_report_type_id_fkey";

-- DropForeignKey
ALTER TABLE "report_versions" DROP CONSTRAINT "report_versions_report_template_id_fkey";

-- DropForeignKey
ALTER TABLE "report_versions" DROP CONSTRAINT "report_versions_report_type_id_fkey";

-- AlterTable
ALTER TABLE "lancamento_item" DROP COLUMN "centro_custo_id";

-- AlterTable
ALTER TABLE "plano_contas" DROP COLUMN "aceita_lancamento",
DROP COLUMN "codigo_referencial";

-- DropTable
DROP TABLE "centro_custo";

-- DropTable
DROP TABLE "report_line_accounts";

-- DropTable
DROP TABLE "report_template_lines";

-- DropTable
DROP TABLE "report_templates";

-- DropTable
DROP TABLE "report_types";
