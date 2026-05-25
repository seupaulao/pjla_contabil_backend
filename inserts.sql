INSERT INTO report_types (code, name)
VALUES
('BALANCO', 'Balanço Patrimonial'),
('DRE', 'Demonstração do Resultado'),
('DFC', 'Demonstração do Fluxo de Caixa'),
('DVA', 'Demonstração do Valor Adicionado'),
('BALANCETE', 'Balancete');

INSERT INTO regras (code, name)
VALUES
('SUPER_ADMIN', 'Super Administrador'),
('ACCOUNTANT', 'Contador'),
('ASSISTANT', 'Assistente Contábil'),
('AUDITOR', 'Auditor'),
('CLIENT', 'Cliente');

INSERT INTO permissoes (code, descricao)
VALUES
('COMPANY_VIEW', 'Visualizar empresas'),
('COMPANY_EDIT', 'Editar empresas'),
('ACCOUNT_VIEW', 'Visualizar plano de contas'),
('ACCOUNT_EDIT', 'Editar plano de contas'),
('ENTRY_VIEW', 'Visualizar lançamentos'),
('ENTRY_CREATE', 'Criar lançamentos'),
('ENTRY_EDIT', 'Editar lançamentos'),
('REPORT_VIEW', 'Visualizar relatórios'),
('REPORT_EDIT', 'Editar relatórios'),
('SPED_EXPORT', 'Exportar SPED'),
('ECD_SIGN', 'Assinar ECD');

INSERT INTO sped_natureza (code, description)
VALUES
('01', 'Contas de Ativo'),
('02', 'Contas de Passivo'),
('03', 'Patrimônio Líquido'),
('04', 'Receitas'),
('05', 'Custos'),
('06', 'Despesas');

-- ============================================================
-- INSERTS: plano_contas_referencial e plano_contas
-- Gerado com base no hledger_plano_contas.txt
-- IDs inteiros explícitos (esquema de numeração hierárquica)
-- ============================================================

-- ============================================================
-- PLANO DE CONTAS REFERENCIAL
-- ============================================================

-- Nível 1 – Grupos principais
INSERT INTO plano_contas_referencial (id, codigo, nome, tipo, natureza, nivel, parent_id, grupo)
VALUES
  (1, '1', 'Ativo',              'S', 'D', 1, NULL, 'ATIVO'),
  (2, '2', 'Passivo',            'S', 'C', 1, NULL, 'PASSIVO'),
  (3, '3', 'Patrimônio Líquido', 'S', 'C', 1, NULL, 'PL'),
  (4, '4', 'Receita',            'S', 'C', 1, NULL, 'RESULTADO'),
  (5, '5', 'Despesa',            'S', 'D', 1, NULL, 'RESULTADO');

-- Nível 2 – Ativo
INSERT INTO plano_contas_referencial (id, codigo, nome, tipo, natureza, nivel, parent_id, grupo)
VALUES
  (11, '1.1', 'Caixa',            'A', 'D', 2, 1, 'ATIVO'),
  (12, '1.2', 'Banco',            'S', 'D', 2, 1, 'ATIVO'),
  (13, '1.3', 'Contas a Receber', 'S', 'D', 2, 1, 'ATIVO'),
  (14, '1.4', 'Imobilizado',      'S', 'D', 2, 1, 'ATIVO');

-- Nível 2 – Passivo
INSERT INTO plano_contas_referencial (id, codigo, nome, tipo, natureza, nivel, parent_id, grupo)
VALUES
  (21, '2.1', 'Fornecedores',        'A', 'C', 2, 2, 'PASSIVO'),
  (22, '2.2', 'Impostos a Recolher', 'S', 'C', 2, 2, 'PASSIVO'),
  (23, '2.3', 'INSS a Recolher',     'A', 'C', 2, 2, 'PASSIVO'),
  (24, '2.4', 'Pró-labore a Pagar',  'A', 'C', 2, 2, 'PASSIVO');

-- Nível 2 – Patrimônio Líquido
INSERT INTO plano_contas_referencial (id, codigo, nome, tipo, natureza, nivel, parent_id, grupo)
VALUES
  (31, '3.1', 'Capital Social',        'A', 'C', 2, 3, 'PL'),
  (32, '3.2', 'Lucros Acumulados',     'A', 'C', 2, 3, 'PL'),
  (33, '3.3', 'Distribuição de Lucros','A', 'C', 2, 3, 'PL');

-- Nível 2 – Receita
INSERT INTO plano_contas_referencial (id, codigo, nome, tipo, natureza, nivel, parent_id, grupo, dre_grupo)
VALUES
  (41, '4.1', 'Receita de Plantão',     'S', 'C', 2, 4, 'RESULTADO', 'RECEITA_BRUTA'),
  (42, '4.2', 'Receita de Consultas',   'A', 'C', 2, 4, 'RESULTADO', 'RECEITA_BRUTA'),
  (43, '4.3', 'Rendimentos Financeiros','A', 'C', 2, 4, 'RESULTADO', 'RECEITA_FINANCEIRA');

-- Nível 2 – Despesa
INSERT INTO plano_contas_referencial (id, codigo, nome, tipo, natureza, nivel, parent_id, grupo, dre_grupo)
VALUES
  (51,  '5.1',  'Aluguel',          'A', 'D', 2, 5, 'RESULTADO', 'DESPESA_OPERACIONAL'),
  (52,  '5.2',  'Internet',         'A', 'D', 2, 5, 'RESULTADO', 'DESPESA_OPERACIONAL'),
  (53,  '5.3',  'Energia',          'A', 'D', 2, 5, 'RESULTADO', 'DESPESA_OPERACIONAL'),
  (54,  '5.4',  'Software',         'A', 'D', 2, 5, 'RESULTADO', 'DESPESA_OPERACIONAL'),
  (55,  '5.5',  'Contabilidade',    'A', 'D', 2, 5, 'RESULTADO', 'DESPESA_OPERACIONAL'),
  (56,  '5.6',  'Pró-labore',       'A', 'D', 2, 5, 'RESULTADO', 'DESPESA_PESSOAL'),
  (57,  '5.7',  'INSS',             'A', 'D', 2, 5, 'RESULTADO', 'DESPESA_PESSOAL'),
  (58,  '5.8',  'DAS',              'A', 'D', 2, 5, 'RESULTADO', 'DESPESA_TRIBUTARIA'),
  (59,  '5.9',  'ISS',              'A', 'D', 2, 5, 'RESULTADO', 'DESPESA_TRIBUTARIA'),
  (510, '5.10', 'Tarifas Bancárias','A', 'D', 2, 5, 'RESULTADO', 'DESPESA_FINANCEIRA'),
  (511, '5.11', 'Juros',            'A', 'D', 2, 5, 'RESULTADO', 'DESPESA_FINANCEIRA');

-- Nível 3 – Banco
INSERT INTO plano_contas_referencial (id, codigo, nome, tipo, natureza, nivel, parent_id, grupo)
VALUES
  (121, '1.2.1', 'Conta Corrente', 'A', 'D', 3, 12, 'ATIVO'),
  (122, '1.2.2', 'Conta Digital',  'A', 'D', 3, 12, 'ATIVO');

-- Nível 3 – Contas a Receber
INSERT INTO plano_contas_referencial (id, codigo, nome, tipo, natureza, nivel, parent_id, grupo)
VALUES
  (131, '1.3.1', 'Hospital A', 'A', 'D', 3, 13, 'ATIVO'),
  (132, '1.3.2', 'Hospital B', 'A', 'D', 3, 13, 'ATIVO');

-- Nível 3 – Imobilizado
INSERT INTO plano_contas_referencial (id, codigo, nome, tipo, natureza, nivel, parent_id, grupo)
VALUES
  (141, '1.4.1', 'Equipamentos', 'A', 'D', 3, 14, 'ATIVO'),
  (142, '1.4.2', 'Computadores', 'A', 'D', 3, 14, 'ATIVO');

-- Nível 3 – Impostos (Passivo)
INSERT INTO plano_contas_referencial (id, codigo, nome, tipo, natureza, nivel, parent_id, grupo)
VALUES
  (221, '2.2.1', 'DAS a Recolher', 'A', 'C', 3, 22, 'PASSIVO'),
  (222, '2.2.2', 'ISS a Recolher', 'A', 'C', 3, 22, 'PASSIVO');

-- Nível 3 – Receita de Plantão
INSERT INTO plano_contas_referencial (id, codigo, nome, tipo, natureza, nivel, parent_id, grupo, dre_grupo)
VALUES
  (411, '4.1.1', 'Plantão Hospital A', 'A', 'C', 3, 41, 'RESULTADO', 'RECEITA_BRUTA'),
  (412, '4.1.2', 'Plantão Hospital B', 'A', 'C', 3, 41, 'RESULTADO', 'RECEITA_BRUTA');


-- =================
-- EMPRESA 
-- =================
INSERT INTO empresa(id, cnpj, nome, uf, municipio, data_inicio)
VALUES
  (1, 66779912000111, 'PAOLA LTDA', 'CE', 'FORTALEZA', '2026-05-14'),
  (2, 78480043000109, 'TEC EXEMPLO LTDA', 'CE', 'FORTALEZA', '2026-05-14');

-- ============================================================
-- PLANO DE CONTAS (espelha o referencial sem empresa específica)
-- conta_pai_id resolvido via subquery no codigo
-- aceita_lancamento: 0 = sintética, 1 = analítica
-- ============================================================

-- Nível 1
INSERT INTO plano_contas (id, empresa_id, plano_contas_referencial_id, codigo, descricao, tipo, natureza, nivel, conta_pai_id, codigo_referencial, grupo, aceita_lancamento)
VALUES
  (1, 1, 1, '1', 'Ativo',              'S', 'D', 1, NULL, '1', 'ATIVO',     0),
  (2, 1, 2, '2', 'Passivo',            'S', 'C', 1, NULL, '2', 'PASSIVO',   0),
  (3, 1, 3, '3', 'Patrimônio Líquido', 'S', 'C', 1, NULL, '3', 'PL',        0),
  (4, 1, 4, '4', 'Receita',            'S', 'C', 1, NULL, '4', 'RESULTADO', 0),
  (5, 1, 5, '5', 'Despesa',            'S', 'D', 1, NULL, '5', 'RESULTADO', 0);

-- Nível 2 – Ativo
INSERT INTO plano_contas (id, empresa_id, plano_contas_referencial_id, codigo, descricao, tipo, natureza, nivel, conta_pai_id, codigo_referencial, grupo, aceita_lancamento)
SELECT 6, 1, 11, '1.1', 'Caixa',            'A', 'D', 2, id, '1.1', 'ATIVO', 1 FROM plano_contas WHERE codigo = '1';
INSERT INTO plano_contas (id, empresa_id, plano_contas_referencial_id, codigo, descricao, tipo, natureza, nivel, conta_pai_id, codigo_referencial, grupo, aceita_lancamento)
SELECT 7, 1, 12, '1.2', 'Banco',            'S', 'D', 2, id, '1.2', 'ATIVO', 0 FROM plano_contas WHERE codigo = '1';
INSERT INTO plano_contas (id, empresa_id, plano_contas_referencial_id, codigo, descricao, tipo, natureza, nivel, conta_pai_id, codigo_referencial, grupo, aceita_lancamento)
SELECT 8, 1, 13, '1.3', 'Contas a Receber', 'S', 'D', 2, id, '1.3', 'ATIVO', 0 FROM plano_contas WHERE codigo = '1';
INSERT INTO plano_contas (id, empresa_id, plano_contas_referencial_id, codigo, descricao, tipo, natureza, nivel, conta_pai_id, codigo_referencial, grupo, aceita_lancamento)
SELECT 9, 1, 14, '1.4', 'Imobilizado',      'S', 'D', 2, id, '1.4', 'ATIVO', 0 FROM plano_contas WHERE codigo = '1';

-- Nível 2 – Passivo
INSERT INTO plano_contas (id, empresa_id, plano_contas_referencial_id, codigo, descricao, tipo, natureza, nivel, conta_pai_id, codigo_referencial, grupo, aceita_lancamento)
SELECT 10, 1, 21, '2.1', 'Fornecedores',        'A', 'C', 2, id, '2.1', 'PASSIVO', 1 FROM plano_contas WHERE codigo = '2';
INSERT INTO plano_contas (id, empresa_id, plano_contas_referencial_id, codigo, descricao, tipo, natureza, nivel, conta_pai_id, codigo_referencial, grupo, aceita_lancamento)
SELECT 11, 1, 22, '2.2', 'Impostos a Recolher', 'S', 'C', 2, id, '2.2', 'PASSIVO', 0 FROM plano_contas WHERE codigo = '2';
INSERT INTO plano_contas (id, empresa_id, plano_contas_referencial_id, codigo, descricao, tipo, natureza, nivel, conta_pai_id, codigo_referencial, grupo, aceita_lancamento)
SELECT 12, 1, 23, '2.3', 'INSS a Recolher',     'A', 'C', 2, id, '2.3', 'PASSIVO', 1 FROM plano_contas WHERE codigo = '2';
INSERT INTO plano_contas (id, empresa_id, plano_contas_referencial_id, codigo, descricao, tipo, natureza, nivel, conta_pai_id, codigo_referencial, grupo, aceita_lancamento)
SELECT 13, 1, 24, '2.4', 'Pró-labore a Pagar',  'A', 'C', 2, id, '2.4', 'PASSIVO', 1 FROM plano_contas WHERE codigo = '2';

-- Nível 2 – Patrimônio Líquido
INSERT INTO plano_contas (id, empresa_id, plano_contas_referencial_id, codigo, descricao, tipo, natureza, nivel, conta_pai_id, codigo_referencial, grupo, aceita_lancamento)
SELECT 14, 1, 31, '3.1', 'Capital Social',        'A', 'C', 2, id, '3.1', 'PL', 1 FROM plano_contas WHERE codigo = '3';
INSERT INTO plano_contas (id, empresa_id, plano_contas_referencial_id, codigo, descricao, tipo, natureza, nivel, conta_pai_id, codigo_referencial, grupo, aceita_lancamento)
SELECT 15, 1, 32, '3.2', 'Lucros Acumulados',     'A', 'C', 2, id, '3.2', 'PL', 1 FROM plano_contas WHERE codigo = '3';
INSERT INTO plano_contas (id, empresa_id, plano_contas_referencial_id, codigo, descricao, tipo, natureza, nivel, conta_pai_id, codigo_referencial, grupo, aceita_lancamento)
SELECT 16, 1, 33, '3.3', 'Distribuição de Lucros','A', 'C', 2, id, '3.3', 'PL', 1 FROM plano_contas WHERE codigo = '3';

-- Nível 2 – Receita
INSERT INTO plano_contas (id, empresa_id, plano_contas_referencial_id, codigo, descricao, tipo, natureza, nivel, conta_pai_id, codigo_referencial, grupo, dre_grupo, aceita_lancamento)
SELECT 17, 1, 41, '4.1', 'Receita de Plantão',     'S', 'C', 2, id, '4.1', 'RESULTADO', 'RECEITA_BRUTA',     0 FROM plano_contas WHERE codigo = '4';
INSERT INTO plano_contas (id, empresa_id, plano_contas_referencial_id, codigo, descricao, tipo, natureza, nivel, conta_pai_id, codigo_referencial, grupo, dre_grupo, aceita_lancamento)
SELECT 18, 1, 42, '4.2', 'Receita de Consultas',   'A', 'C', 2, id, '4.2', 'RESULTADO', 'RECEITA_BRUTA',     1 FROM plano_contas WHERE codigo = '4';
INSERT INTO plano_contas (id, empresa_id, plano_contas_referencial_id, codigo, descricao, tipo, natureza, nivel, conta_pai_id, codigo_referencial, grupo, dre_grupo, aceita_lancamento)
SELECT 19, 1, 43, '4.3', 'Rendimentos Financeiros','A', 'C', 2, id, '4.3', 'RESULTADO', 'RECEITA_FINANCEIRA', 1 FROM plano_contas WHERE codigo = '4';

-- Nível 2 – Despesa
INSERT INTO plano_contas (id, empresa_id, plano_contas_referencial_id, codigo, descricao, tipo, natureza, nivel, conta_pai_id, codigo_referencial, grupo, dre_grupo, aceita_lancamento)
SELECT 20, 1, 51,  '5.1',  'Aluguel',          'A', 'D', 2, id, '5.1',  'RESULTADO', 'DESPESA_OPERACIONAL', 1 FROM plano_contas WHERE codigo = '5';
INSERT INTO plano_contas (id, empresa_id, plano_contas_referencial_id, codigo, descricao, tipo, natureza, nivel, conta_pai_id, codigo_referencial, grupo, dre_grupo, aceita_lancamento)
SELECT 21, 1, 52,  '5.2',  'Internet',         'A', 'D', 2, id, '5.2',  'RESULTADO', 'DESPESA_OPERACIONAL', 1 FROM plano_contas WHERE codigo = '5';
INSERT INTO plano_contas (id, empresa_id, plano_contas_referencial_id, codigo, descricao, tipo, natureza, nivel, conta_pai_id, codigo_referencial, grupo, dre_grupo, aceita_lancamento)
SELECT 22, 1, 53,  '5.3',  'Energia',          'A', 'D', 2, id, '5.3',  'RESULTADO', 'DESPESA_OPERACIONAL', 1 FROM plano_contas WHERE codigo = '5';
INSERT INTO plano_contas (id, empresa_id, plano_contas_referencial_id, codigo, descricao, tipo, natureza, nivel, conta_pai_id, codigo_referencial, grupo, dre_grupo, aceita_lancamento)
SELECT 23, 1, 54,  '5.4',  'Software',         'A', 'D', 2, id, '5.4',  'RESULTADO', 'DESPESA_OPERACIONAL', 1 FROM plano_contas WHERE codigo = '5';
INSERT INTO plano_contas (id, empresa_id, plano_contas_referencial_id, codigo, descricao, tipo, natureza, nivel, conta_pai_id, codigo_referencial, grupo, dre_grupo, aceita_lancamento)
SELECT 24, 1, 55,  '5.5',  'Contabilidade',    'A', 'D', 2, id, '5.5',  'RESULTADO', 'DESPESA_OPERACIONAL', 1 FROM plano_contas WHERE codigo = '5';
INSERT INTO plano_contas (id, empresa_id, plano_contas_referencial_id, codigo, descricao, tipo, natureza, nivel, conta_pai_id, codigo_referencial, grupo, dre_grupo, aceita_lancamento)
SELECT 25, 1, 56,  '5.6',  'Pró-labore',       'A', 'D', 2, id, '5.6',  'RESULTADO', 'DESPESA_PESSOAL',    1 FROM plano_contas WHERE codigo = '5';
INSERT INTO plano_contas (id, empresa_id, plano_contas_referencial_id, codigo, descricao, tipo, natureza, nivel, conta_pai_id, codigo_referencial, grupo, dre_grupo, aceita_lancamento)
SELECT 26, 1, 57,  '5.7',  'INSS',             'A', 'D', 2, id, '5.7',  'RESULTADO', 'DESPESA_PESSOAL',    1 FROM plano_contas WHERE codigo = '5';
INSERT INTO plano_contas (id, empresa_id, plano_contas_referencial_id, codigo, descricao, tipo, natureza, nivel, conta_pai_id, codigo_referencial, grupo, dre_grupo, aceita_lancamento)
SELECT 27, 1, 58,  '5.8',  'DAS',              'A', 'D', 2, id, '5.8',  'RESULTADO', 'DESPESA_TRIBUTARIA', 1 FROM plano_contas WHERE codigo = '5';
INSERT INTO plano_contas (id, empresa_id, plano_contas_referencial_id, codigo, descricao, tipo, natureza, nivel, conta_pai_id, codigo_referencial, grupo, dre_grupo, aceita_lancamento)
SELECT 28, 1, 59,  '5.9',  'ISS',              'A', 'D', 2, id, '5.9',  'RESULTADO', 'DESPESA_TRIBUTARIA', 1 FROM plano_contas WHERE codigo = '5';
INSERT INTO plano_contas (id, empresa_id, plano_contas_referencial_id, codigo, descricao, tipo, natureza, nivel, conta_pai_id, codigo_referencial, grupo, dre_grupo, aceita_lancamento)
SELECT 29, 1, 510, '5.10', 'Tarifas Bancárias','A', 'D', 2, id, '5.10', 'RESULTADO', 'DESPESA_FINANCEIRA', 1 FROM plano_contas WHERE codigo = '5';
INSERT INTO plano_contas (id, empresa_id, plano_contas_referencial_id, codigo, descricao, tipo, natureza, nivel, conta_pai_id, codigo_referencial, grupo, dre_grupo, aceita_lancamento)
SELECT 30, 1, 511, '5.11', 'Juros',            'A', 'D', 2, id, '5.11', 'RESULTADO', 'DESPESA_FINANCEIRA', 1 FROM plano_contas WHERE codigo = '5';

-- Nível 3 – Banco
INSERT INTO plano_contas (id, empresa_id, plano_contas_referencial_id, codigo, descricao, tipo, natureza, nivel, conta_pai_id, codigo_referencial, grupo, aceita_lancamento)
SELECT 31, 1, 121, '1.2.1', 'Conta Corrente', 'A', 'D', 3, id, '1.2.1', 'ATIVO', 1 FROM plano_contas WHERE codigo = '1.2';
INSERT INTO plano_contas (id, empresa_id, plano_contas_referencial_id, codigo, descricao, tipo, natureza, nivel, conta_pai_id, codigo_referencial, grupo, aceita_lancamento)
SELECT 32, 1, 122, '1.2.2', 'Conta Digital',  'A', 'D', 3, id, '1.2.2', 'ATIVO', 1 FROM plano_contas WHERE codigo = '1.2';

-- Nível 3 – Contas a Receber
INSERT INTO plano_contas (id, empresa_id, plano_contas_referencial_id, codigo, descricao, tipo, natureza, nivel, conta_pai_id, codigo_referencial, grupo, aceita_lancamento)
SELECT 33, 1, 131, '1.3.1', 'Hospital A', 'A', 'D', 3, id, '1.3.1', 'ATIVO', 1 FROM plano_contas WHERE codigo = '1.3';
INSERT INTO plano_contas (id, empresa_id, plano_contas_referencial_id, codigo, descricao, tipo, natureza, nivel, conta_pai_id, codigo_referencial, grupo, aceita_lancamento)
SELECT 34, 1, 132, '1.3.2', 'Hospital B', 'A', 'D', 3, id, '1.3.2', 'ATIVO', 1 FROM plano_contas WHERE codigo = '1.3';

-- Nível 3 – Imobilizado
INSERT INTO plano_contas (id, empresa_id, plano_contas_referencial_id, codigo, descricao, tipo, natureza, nivel, conta_pai_id, codigo_referencial, grupo, aceita_lancamento)
SELECT 35, 1, 141, '1.4.1', 'Equipamentos', 'A', 'D', 3, id, '1.4.1', 'ATIVO', 1 FROM plano_contas WHERE codigo = '1.4';
INSERT INTO plano_contas (id, empresa_id, plano_contas_referencial_id, codigo, descricao, tipo, natureza, nivel, conta_pai_id, codigo_referencial, grupo, aceita_lancamento)
SELECT 36, 1, 142, '1.4.2', 'Computadores', 'A', 'D', 3, id, '1.4.2', 'ATIVO', 1 FROM plano_contas WHERE codigo = '1.4';

-- Nível 3 – Impostos (Passivo)
INSERT INTO plano_contas (id, empresa_id, plano_contas_referencial_id, codigo, descricao, tipo, natureza, nivel, conta_pai_id, codigo_referencial, grupo, aceita_lancamento)
SELECT 37, 1, 221, '2.2.1', 'DAS a Recolher', 'A', 'C', 3, id, '2.2.1', 'PASSIVO', 1 FROM plano_contas WHERE codigo = '2.2';
INSERT INTO plano_contas (id, empresa_id, plano_contas_referencial_id, codigo, descricao, tipo, natureza, nivel, conta_pai_id, codigo_referencial, grupo, aceita_lancamento)
SELECT 38, 1, 222, '2.2.2', 'ISS a Recolher', 'A', 'C', 3, id, '2.2.2', 'PASSIVO', 1 FROM plano_contas WHERE codigo = '2.2';

-- Nível 3 – Receita de Plantão
INSERT INTO plano_contas (id, empresa_id, plano_contas_referencial_id, codigo, descricao, tipo, natureza, nivel, conta_pai_id, codigo_referencial, grupo, dre_grupo, aceita_lancamento)
SELECT 39, 1, 411, '4.1.1', 'Plantão Hospital A', 'A', 'C', 3, id, '4.1.1', 'RESULTADO', 'RECEITA_BRUTA', 1 FROM plano_contas WHERE codigo = '4.1';
INSERT INTO plano_contas (id, empresa_id, plano_contas_referencial_id, codigo, descricao, tipo, natureza, nivel, conta_pai_id, codigo_referencial, grupo, dre_grupo, aceita_lancamento)
SELECT 40, 1, 412, '4.1.2', 'Plantão Hospital B', 'A', 'C', 3, id, '4.1.2', 'RESULTADO', 'RECEITA_BRUTA', 1 FROM plano_contas WHERE codigo = '4.1';
