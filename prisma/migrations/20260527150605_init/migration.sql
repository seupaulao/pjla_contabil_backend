-- AlterTable
CREATE SEQUENCE lancamento_id_seq;
ALTER TABLE "lancamento" ALTER COLUMN "id" SET DEFAULT nextval('lancamento_id_seq');
ALTER SEQUENCE lancamento_id_seq OWNED BY "lancamento"."id";

-- AlterTable
CREATE SEQUENCE lancamento_item_id_seq;
ALTER TABLE "lancamento_item" ALTER COLUMN "id" SET DEFAULT nextval('lancamento_item_id_seq');
ALTER SEQUENCE lancamento_item_id_seq OWNED BY "lancamento_item"."id";

-- AlterTable
CREATE SEQUENCE plano_contas_id_seq;
ALTER TABLE "plano_contas" ALTER COLUMN "id" SET DEFAULT nextval('plano_contas_id_seq');
ALTER SEQUENCE plano_contas_id_seq OWNED BY "plano_contas"."id";

-- AlterTable
CREATE SEQUENCE plano_contas_referencial_id_seq;
ALTER TABLE "plano_contas_referencial" ALTER COLUMN "id" SET DEFAULT nextval('plano_contas_referencial_id_seq');
ALTER SEQUENCE plano_contas_referencial_id_seq OWNED BY "plano_contas_referencial"."id";
