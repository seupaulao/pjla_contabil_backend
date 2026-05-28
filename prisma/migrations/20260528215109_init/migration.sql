/*
  Warnings:

  - You are about to drop the column `company_id` on the `audit_logs` table. All the data in the column will be lost.
  - The primary key for the `empresa_usuario` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - You are about to drop the column `company_id` on the `empresa_usuario` table. All the data in the column will be lost.
  - Added the required column `empresa_id` to the `empresa_usuario` table without a default value. This is not possible if the table is not empty.

*/
-- DropForeignKey
ALTER TABLE "audit_logs" DROP CONSTRAINT "audit_logs_company_id_fkey";

-- DropForeignKey
ALTER TABLE "empresa_usuario" DROP CONSTRAINT "empresa_usuario_company_id_fkey";

-- AlterTable
ALTER TABLE "audit_logs" DROP COLUMN "company_id";

-- AlterTable
ALTER TABLE "empresa_usuario" DROP CONSTRAINT "empresa_usuario_pkey",
DROP COLUMN "company_id",
ADD COLUMN     "empresa_id" INTEGER NOT NULL,
ADD CONSTRAINT "empresa_usuario_pkey" PRIMARY KEY ("user_id", "empresa_id");

-- CreateTable
CREATE TABLE "tomadores" (
    "id" SERIAL NOT NULL,
    "nome" TEXT NOT NULL,
    "cnpj" TEXT,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "tomadores_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "nota_fiscal" (
    "id" TEXT NOT NULL,
    "numero" INTEGER NOT NULL,
    "chave" TEXT,
    "xml" TEXT NOT NULL,
    "xmlAssinado" TEXT,
    "protocolo" TEXT,
    "status" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "conta_id" INTEGER,
    "valorTotal" DECIMAL(14,2),
    "dataEmissao" DATE,
    "tomador_id" INTEGER,
    "empresa_id" INTEGER,

    CONSTRAINT "nota_fiscal_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "report_types" (
    "id" UUID NOT NULL,
    "code" VARCHAR(30) NOT NULL,
    "name" TEXT NOT NULL,

    CONSTRAINT "report_types_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "report_templates" (
    "id" UUID NOT NULL,
    "empresa_id" INTEGER,
    "report_type_id" UUID NOT NULL,
    "name" TEXT NOT NULL,
    "is_default" BOOLEAN NOT NULL DEFAULT false,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "report_templates_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "report_template_lines" (
    "id" UUID NOT NULL,
    "template_id" UUID NOT NULL,
    "line_order" INTEGER NOT NULL,
    "code" TEXT,
    "title" TEXT NOT NULL,
    "line_type" TEXT NOT NULL,
    "formula" TEXT,
    "is_bold" BOOLEAN NOT NULL DEFAULT false,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "parent_id" UUID,

    CONSTRAINT "report_template_lines_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "report_line_accounts" (
    "id" UUID NOT NULL,
    "report_line_id" UUID NOT NULL,
    "conta_id" INTEGER NOT NULL,

    CONSTRAINT "report_line_accounts_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "report_types_code_key" ON "report_types"("code");

-- AddForeignKey
ALTER TABLE "nota_fiscal" ADD CONSTRAINT "nota_fiscal_conta_id_fkey" FOREIGN KEY ("conta_id") REFERENCES "plano_contas"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "nota_fiscal" ADD CONSTRAINT "nota_fiscal_tomador_id_fkey" FOREIGN KEY ("tomador_id") REFERENCES "tomadores"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "report_templates" ADD CONSTRAINT "report_templates_empresa_id_fkey" FOREIGN KEY ("empresa_id") REFERENCES "empresa"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "report_templates" ADD CONSTRAINT "report_templates_report_type_id_fkey" FOREIGN KEY ("report_type_id") REFERENCES "report_types"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "report_template_lines" ADD CONSTRAINT "report_template_lines_template_id_fkey" FOREIGN KEY ("template_id") REFERENCES "report_templates"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "report_template_lines" ADD CONSTRAINT "report_template_lines_parent_id_fkey" FOREIGN KEY ("parent_id") REFERENCES "report_template_lines"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "report_line_accounts" ADD CONSTRAINT "report_line_accounts_report_line_id_fkey" FOREIGN KEY ("report_line_id") REFERENCES "report_template_lines"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "report_line_accounts" ADD CONSTRAINT "report_line_accounts_conta_id_fkey" FOREIGN KEY ("conta_id") REFERENCES "plano_contas"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "report_versions" ADD CONSTRAINT "report_versions_report_template_id_fkey" FOREIGN KEY ("report_template_id") REFERENCES "report_templates"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "report_versions" ADD CONSTRAINT "report_versions_report_type_id_fkey" FOREIGN KEY ("report_type_id") REFERENCES "report_types"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "empresa_usuario" ADD CONSTRAINT "empresa_usuario_empresa_id_fkey" FOREIGN KEY ("empresa_id") REFERENCES "empresa"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "empresa_configuracao" ADD CONSTRAINT "empresa_configuracao_default_report_template_fkey" FOREIGN KEY ("default_report_template") REFERENCES "report_templates"("id") ON DELETE SET NULL ON UPDATE CASCADE;
