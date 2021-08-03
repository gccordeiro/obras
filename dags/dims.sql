truncate table dm_modalidade_contratacao;
insert into dm_modalidade_contratacao (
    select distinct modalidade from stage_obra
);

truncate table dm_forma_execucao;
insert into dm_forma_execucao (
    select distinct formaexecucao from stage_obra
);

truncate table dm_tipo_servico;
insert into dm_tipo_servico (
    select distinct tiposervico from stage_obra
);

truncate table dm_setor_beneficiario;
insert into dm_setor_beneficiario (
    select distinct setorbeneficiario from stage_obra
);

truncate table dm_tipo_obra;
insert into dm_tipo_obra (
    select distinct tipoobra from stage_obra
);

truncate table dm_bem_publico;
insert into dm_bem_publico (
    select distinct bempublico from stage_obra
);

truncate table dm_objeto_edital;
insert into dm_objeto_edital (
    select distinct objeto from stage_obra
);

truncate table dm_entidade_demandante;
insert into dm_entidade_demandante (
    select distinct nome_entidade, sigla_orgao from stage_obra
);

truncate table dm_tipo_situacao;
insert into dm_tipo_situacao (
    select distinct ultima_situacao from stage_obra
);

truncate table dm_municipio;
insert into dm_municipio (
    select distinct mun_nome, nome from stage_obra
);
