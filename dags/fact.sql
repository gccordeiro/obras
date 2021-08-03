truncate table ft_obra;
insert into ft_obra (
    select
        dm_modalidade_contratacao.id as id_modalidade_contratacao,
        dm_forma_execucao.id as id_forma_execucao,
        dm_tipo_servico.id as id_tipo_servico,
        dm_setor_beneficiario.id as id_setor_beneficiario,
        dm_tipo_obra.id as id_tipo_obra,
        dm_bem_publico.id as id_bem_publico,
        dm_objeto_edital.id as id_objeto_edital,
        dm_entidade_demandante.id as id_entidade_demandante,
        dm_tipo_situacao.id as id_tipo_situacao,
        dm_municipio.id as id_municipio,
        valormedicoes as vl_medicao,
        valormateriais as vl_material,
        valormaquinasequipamentos as vl_equipamento,
        valoraditado as vl_aditado,
        (valorinicial + valormedicoes + valormateriais + 
            valormaquinasequipamentos + valoraditado) as vl_total
    from stage_obra o 
    join dm_modalidade_contratacao d1
        on d1.descricao = o.modalidade
    join dm_forma_execucao d2
        on d2.descricao = o.formaexecucao
    join dm_tipo_servico d3
        on d2.descricao = o.tiposervico
    join dm_setor_beneficiario d4
        on d4.descricao = o.setorbeneficiario
    join dm_tipo_obra d5
        on d5.descricao = o.tipoobra
    join dm_bem_publico d6 
        on d6.descricao = o.bempublico
    join dm_objeto_edital d7 
        on d7.descricao = o.objeto
    join dm_entidade_demandante d8
        on d8.sigla = o.sigla_orgao
    join dm_tipo_situacao d9
        on d9.descricao = o.ultima_situacao
    join dm_municipio d10 
        on d10.descricao = o.mun_nome
);
