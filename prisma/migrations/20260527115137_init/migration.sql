-- CreateEnum
CREATE TYPE "LancamentoTipo" AS ENUM ('D', 'C');

-- CreateEnum
CREATE TYPE "JobStatus" AS ENUM ('PENDING', 'PROCESSING', 'COMPLETED', 'FAILED');

-- CreateTable
CREATE TABLE "empresa" (
    "id" SERIAL NOT NULL,
    "cnpj" TEXT NOT NULL,
    "nome" TEXT NOT NULL,
    "uf" TEXT,
    "municipio" TEXT,
    "data_inicio" DATE,
    "data_fim" DATE,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "excluido_at" TIMESTAMP(3),

    CONSTRAINT "empresa_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "report_types" (
    "id" UUID NOT NULL,
    "code" VARCHAR(30) NOT NULL,
    "name" TEXT NOT NULL,

    CONSTRAINT "report_types_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "plano_contas_referencial" (
    "id" INTEGER NOT NULL,
    "codigo" TEXT NOT NULL,
    "nome" TEXT NOT NULL,
    "tipo" TEXT,
    "natureza" TEXT,
    "nivel" INTEGER,
    "grupo" TEXT,
    "dre_grupo" TEXT,
    "fluxo_caixa_tipo" TEXT,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "excluded_at" TIMESTAMP(3),
    "parent_id" INTEGER,

    CONSTRAINT "plano_contas_referencial_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "plano_contas" (
    "id" INTEGER NOT NULL,
    "empresa_id" INTEGER,
    "plano_contas_referencial_id" INTEGER,
    "codigo" TEXT NOT NULL,
    "descricao" TEXT NOT NULL,
    "tipo" TEXT NOT NULL,
    "natureza" TEXT,
    "nivel" INTEGER NOT NULL,
    "codigo_referencial" TEXT,
    "aceita_lancamento" BOOLEAN NOT NULL DEFAULT true,
    "grupo" TEXT,
    "subgrupo" TEXT,
    "dre_grupo" TEXT,
    "fluxo_caixa_tipo" TEXT,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "excluido_at" TIMESTAMP(3),
    "conta_pai_id" INTEGER,

    CONSTRAINT "plano_contas_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "centro_custo" (
    "id" UUID NOT NULL,
    "empresa_id" INTEGER NOT NULL,
    "codigo" TEXT,
    "nome" TEXT NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "centro_custo_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "lancamento" (
    "id" INTEGER NOT NULL,
    "empresa_id" INTEGER,
    "data" DATE NOT NULL,
    "historico" TEXT,
    "tipo" TEXT NOT NULL DEFAULT 'N',
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "excluido_at" TIMESTAMP(3),

    CONSTRAINT "lancamento_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "lancamento_item" (
    "id" INTEGER NOT NULL,
    "lancamento_id" INTEGER,
    "conta_id" INTEGER,
    "centro_custo_id" UUID,
    "tipo" "LancamentoTipo" NOT NULL,
    "valor" DECIMAL(14,2) NOT NULL,

    CONSTRAINT "lancamento_item_pkey" PRIMARY KEY ("id")
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

-- CreateTable
CREATE TABLE "mapa_demonstracoes" (
    "id" SERIAL NOT NULL,
    "conta_id" INTEGER,
    "tipo" TEXT,
    "categoria" TEXT,
    "excluido_at" TIMESTAMP(3),

    CONSTRAINT "mapa_demonstracoes_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "tags" (
    "id" UUID NOT NULL,
    "empresa_id" INTEGER,
    "name" TEXT NOT NULL,

    CONSTRAINT "tags_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "lancamento_item_tags" (
    "lancamento_item_id" INTEGER NOT NULL,
    "tag_id" UUID NOT NULL,

    CONSTRAINT "lancamento_item_tags_pkey" PRIMARY KEY ("lancamento_item_id","tag_id")
);

-- CreateTable
CREATE TABLE "sped_mappings" (
    "id" UUID NOT NULL,
    "conta_id" INTEGER NOT NULL,
    "sped_code" TEXT NOT NULL,
    "description" TEXT,

    CONSTRAINT "sped_mappings_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "usuarios" (
    "id" UUID NOT NULL,
    "nome" TEXT NOT NULL,
    "email" TEXT NOT NULL,
    "password_hash" TEXT NOT NULL,
    "is_active" BOOLEAN NOT NULL DEFAULT true,
    "last_login_at" TIMESTAMP(3),
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "usuarios_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "regras" (
    "id" UUID NOT NULL,
    "code" TEXT NOT NULL,
    "name" TEXT NOT NULL,

    CONSTRAINT "regras_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "permissoes" (
    "id" UUID NOT NULL,
    "code" TEXT NOT NULL,
    "descricao" TEXT,

    CONSTRAINT "permissoes_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "regra_permissao" (
    "role_id" UUID NOT NULL,
    "permission_id" UUID NOT NULL,

    CONSTRAINT "regra_permissao_pkey" PRIMARY KEY ("role_id","permission_id")
);

-- CreateTable
CREATE TABLE "empresa_usuario" (
    "user_id" UUID NOT NULL,
    "company_id" INTEGER NOT NULL,
    "role_id" UUID,

    CONSTRAINT "empresa_usuario_pkey" PRIMARY KEY ("user_id","company_id")
);

-- CreateTable
CREATE TABLE "usuario_sessoes" (
    "id" UUID NOT NULL,
    "user_id" UUID NOT NULL,
    "token" TEXT NOT NULL,
    "ip_address" INET,
    "user_agent" TEXT,
    "expires_at" TIMESTAMP(3) NOT NULL,
    "revoked" BOOLEAN NOT NULL DEFAULT false,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "usuario_sessoes_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "audit_logs" (
    "id" UUID NOT NULL,
    "company_id" INTEGER,
    "user_id" UUID,
    "entity_name" TEXT,
    "entity_id" TEXT,
    "action" TEXT,
    "old_data" JSONB,
    "new_data" JSONB,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "audit_logs_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "sped_natureza" (
    "id" UUID NOT NULL,
    "code" TEXT NOT NULL,
    "description" TEXT NOT NULL,

    CONSTRAINT "sped_natureza_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "report_versions" (
    "id" UUID NOT NULL,
    "empresa_id" INTEGER NOT NULL,
    "report_template_id" UUID,
    "report_type_id" UUID,
    "version_number" INTEGER NOT NULL,
    "fiscal_year" INTEGER NOT NULL,
    "start_period" DATE NOT NULL,
    "end_period" DATE NOT NULL,
    "generated_by" UUID,
    "is_locked" BOOLEAN NOT NULL DEFAULT false,
    "notes" TEXT,
    "integrity_hash" TEXT,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "report_versions_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "report_version_lines" (
    "id" UUID NOT NULL,
    "report_version_id" UUID NOT NULL,
    "line_order" INTEGER,
    "code" TEXT,
    "title" TEXT,
    "amount" DECIMAL(18,2),
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "report_version_lines_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "trava_contabil" (
    "id" UUID NOT NULL,
    "empresa_id" INTEGER NOT NULL,
    "year" INTEGER NOT NULL,
    "month" INTEGER NOT NULL,
    "is_closed" BOOLEAN NOT NULL DEFAULT false,
    "closed_by" UUID,
    "closed_at" TIMESTAMP(3),

    CONSTRAINT "trava_contabil_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "certificados_digitais" (
    "id" UUID NOT NULL,
    "empresa_id" INTEGER NOT NULL,
    "certificate_name" TEXT,
    "serial_number" TEXT,
    "valid_from" DATE,
    "valid_until" DATE,
    "issuer" TEXT,
    "encrypted_pfx" BYTEA,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "certificados_digitais_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "ecd_arquivos" (
    "id" UUID NOT NULL,
    "empresa_id" INTEGER NOT NULL,
    "fiscal_year" INTEGER NOT NULL,
    "file_name" TEXT,
    "file_hash" TEXT,
    "generated_by" UUID,
    "generated_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "signed_at" TIMESTAMP(3),
    "delivered_at" TIMESTAMP(3),
    "status" TEXT,

    CONSTRAINT "ecd_arquivos_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "assinaturas_digitais" (
    "id" UUID NOT NULL,
    "ecd_file_id" UUID NOT NULL,
    "signed_by" UUID,
    "certificate_id" UUID,
    "signature_hash" TEXT NOT NULL,
    "signed_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "assinaturas_digitais_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "sped_entregas" (
    "id" UUID NOT NULL,
    "empresa_id" INTEGER NOT NULL,
    "sped_type" TEXT,
    "fiscal_year" INTEGER,
    "protocol" TEXT,
    "receipt_number" TEXT,
    "delivered_at" TIMESTAMP(3),
    "status" TEXT,

    CONSTRAINT "sped_entregas_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "jobs" (
    "id" UUID NOT NULL,
    "queue_name" TEXT,
    "payload" JSONB,
    "status" TEXT NOT NULL DEFAULT 'PENDING',
    "retries" INTEGER NOT NULL DEFAULT 0,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "processed_at" TIMESTAMP(3),

    CONSTRAINT "jobs_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "empresa_configuracao" (
    "empresa_id" INTEGER NOT NULL,
    "permitir_dinheiro_negativo" BOOLEAN NOT NULL DEFAULT false,
    "periodo_fechamento_automatico" BOOLEAN NOT NULL DEFAULT false,
    "default_report_template" UUID,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "empresa_configuracao_pkey" PRIMARY KEY ("empresa_id")
);

-- CreateIndex
CREATE UNIQUE INDEX "report_types_code_key" ON "report_types"("code");

-- CreateIndex
CREATE INDEX "idx_lancamento_data" ON "lancamento"("data");

-- CreateIndex
CREATE INDEX "idx_lancamento_item_conta" ON "lancamento_item"("conta_id");

-- CreateIndex
CREATE UNIQUE INDEX "usuarios_email_key" ON "usuarios"("email");

-- CreateIndex
CREATE UNIQUE INDEX "regras_code_key" ON "regras"("code");

-- CreateIndex
CREATE UNIQUE INDEX "permissoes_code_key" ON "permissoes"("code");

-- CreateIndex
CREATE UNIQUE INDEX "usuario_sessoes_token_key" ON "usuario_sessoes"("token");

-- CreateIndex
CREATE UNIQUE INDEX "sped_natureza_code_key" ON "sped_natureza"("code");

-- AddForeignKey
ALTER TABLE "plano_contas_referencial" ADD CONSTRAINT "plano_contas_referencial_parent_id_fkey" FOREIGN KEY ("parent_id") REFERENCES "plano_contas_referencial"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "plano_contas" ADD CONSTRAINT "plano_contas_empresa_id_fkey" FOREIGN KEY ("empresa_id") REFERENCES "empresa"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "plano_contas" ADD CONSTRAINT "plano_contas_plano_contas_referencial_id_fkey" FOREIGN KEY ("plano_contas_referencial_id") REFERENCES "plano_contas_referencial"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "plano_contas" ADD CONSTRAINT "plano_contas_conta_pai_id_fkey" FOREIGN KEY ("conta_pai_id") REFERENCES "plano_contas"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "centro_custo" ADD CONSTRAINT "centro_custo_empresa_id_fkey" FOREIGN KEY ("empresa_id") REFERENCES "empresa"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "lancamento" ADD CONSTRAINT "lancamento_empresa_id_fkey" FOREIGN KEY ("empresa_id") REFERENCES "empresa"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "lancamento_item" ADD CONSTRAINT "lancamento_item_lancamento_id_fkey" FOREIGN KEY ("lancamento_id") REFERENCES "lancamento"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "lancamento_item" ADD CONSTRAINT "lancamento_item_conta_id_fkey" FOREIGN KEY ("conta_id") REFERENCES "plano_contas"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "lancamento_item" ADD CONSTRAINT "lancamento_item_centro_custo_id_fkey" FOREIGN KEY ("centro_custo_id") REFERENCES "centro_custo"("id") ON DELETE SET NULL ON UPDATE CASCADE;

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
ALTER TABLE "mapa_demonstracoes" ADD CONSTRAINT "mapa_demonstracoes_conta_id_fkey" FOREIGN KEY ("conta_id") REFERENCES "plano_contas"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "tags" ADD CONSTRAINT "tags_empresa_id_fkey" FOREIGN KEY ("empresa_id") REFERENCES "empresa"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "lancamento_item_tags" ADD CONSTRAINT "lancamento_item_tags_lancamento_item_id_fkey" FOREIGN KEY ("lancamento_item_id") REFERENCES "lancamento_item"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "lancamento_item_tags" ADD CONSTRAINT "lancamento_item_tags_tag_id_fkey" FOREIGN KEY ("tag_id") REFERENCES "tags"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "sped_mappings" ADD CONSTRAINT "sped_mappings_conta_id_fkey" FOREIGN KEY ("conta_id") REFERENCES "plano_contas"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "regra_permissao" ADD CONSTRAINT "regra_permissao_role_id_fkey" FOREIGN KEY ("role_id") REFERENCES "regras"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "regra_permissao" ADD CONSTRAINT "regra_permissao_permission_id_fkey" FOREIGN KEY ("permission_id") REFERENCES "permissoes"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "empresa_usuario" ADD CONSTRAINT "empresa_usuario_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "usuarios"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "empresa_usuario" ADD CONSTRAINT "empresa_usuario_company_id_fkey" FOREIGN KEY ("company_id") REFERENCES "empresa"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "empresa_usuario" ADD CONSTRAINT "empresa_usuario_role_id_fkey" FOREIGN KEY ("role_id") REFERENCES "regras"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "usuario_sessoes" ADD CONSTRAINT "usuario_sessoes_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "usuarios"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "audit_logs" ADD CONSTRAINT "audit_logs_company_id_fkey" FOREIGN KEY ("company_id") REFERENCES "empresa"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "audit_logs" ADD CONSTRAINT "audit_logs_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "usuarios"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "report_versions" ADD CONSTRAINT "report_versions_empresa_id_fkey" FOREIGN KEY ("empresa_id") REFERENCES "empresa"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "report_versions" ADD CONSTRAINT "report_versions_report_template_id_fkey" FOREIGN KEY ("report_template_id") REFERENCES "report_templates"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "report_versions" ADD CONSTRAINT "report_versions_report_type_id_fkey" FOREIGN KEY ("report_type_id") REFERENCES "report_types"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "report_versions" ADD CONSTRAINT "report_versions_generated_by_fkey" FOREIGN KEY ("generated_by") REFERENCES "usuarios"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "report_version_lines" ADD CONSTRAINT "report_version_lines_report_version_id_fkey" FOREIGN KEY ("report_version_id") REFERENCES "report_versions"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "trava_contabil" ADD CONSTRAINT "trava_contabil_empresa_id_fkey" FOREIGN KEY ("empresa_id") REFERENCES "empresa"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "trava_contabil" ADD CONSTRAINT "trava_contabil_closed_by_fkey" FOREIGN KEY ("closed_by") REFERENCES "usuarios"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "certificados_digitais" ADD CONSTRAINT "certificados_digitais_empresa_id_fkey" FOREIGN KEY ("empresa_id") REFERENCES "empresa"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ecd_arquivos" ADD CONSTRAINT "ecd_arquivos_empresa_id_fkey" FOREIGN KEY ("empresa_id") REFERENCES "empresa"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ecd_arquivos" ADD CONSTRAINT "ecd_arquivos_generated_by_fkey" FOREIGN KEY ("generated_by") REFERENCES "usuarios"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "assinaturas_digitais" ADD CONSTRAINT "assinaturas_digitais_ecd_file_id_fkey" FOREIGN KEY ("ecd_file_id") REFERENCES "ecd_arquivos"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "assinaturas_digitais" ADD CONSTRAINT "assinaturas_digitais_signed_by_fkey" FOREIGN KEY ("signed_by") REFERENCES "usuarios"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "assinaturas_digitais" ADD CONSTRAINT "assinaturas_digitais_certificate_id_fkey" FOREIGN KEY ("certificate_id") REFERENCES "certificados_digitais"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "sped_entregas" ADD CONSTRAINT "sped_entregas_empresa_id_fkey" FOREIGN KEY ("empresa_id") REFERENCES "empresa"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "empresa_configuracao" ADD CONSTRAINT "empresa_configuracao_empresa_id_fkey" FOREIGN KEY ("empresa_id") REFERENCES "empresa"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "empresa_configuracao" ADD CONSTRAINT "empresa_configuracao_default_report_template_fkey" FOREIGN KEY ("default_report_template") REFERENCES "report_templates"("id") ON DELETE SET NULL ON UPDATE CASCADE;
