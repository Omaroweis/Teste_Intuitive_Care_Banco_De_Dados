-- Database: demonstracoes_financeiras

DROP DATABASE demonstracoes_financeiras;

--CREATE DATABASE demonstracoes_financeiras
--   WITH 
--    OWNER = postgres
--    ENCODING = 'UTF8'
--    LC_COLLATE = 'Portuguese_Brazil.1252'
--    LC_CTYPE = 'Portuguese_Brazil.1252'
--   TABLESPACE = pg_default
--    CONNECTION LIMIT = -1;

-----QUERY CRIAÇÃO DE TABELA -----
DROP TABLE demonstracao;

CREATE TABLE demonstracao(
DATA date,
REG_ANS varchar,
CD_CONTA_CONTABIL varchar,
DESCRICAO varchar(150),
VL_SALDO_FINAL varchar
)

DROP TABLE relatorio_cadop;

CREATE TABLE RELATORIO_CADOP(
	REG_ANS VARCHAR,
	CNPJ VARCHAR,
	RAZAO_SOCIAL VARCHAR,
	NOME_FANTASIA VARCHAR,
	MODALIDADE VARCHAR,
	LOGADOURO VARCHAR,
	NUMERO varchar,
	COMPLEMENTO VARCHAR,
	BAIRRO VARCHAR,
	CIDADE VARCHAR,
	UF VARCHAR,
	CEP VARCHAR,
	DDD VARCHAR,
	TELEFONE VARCHAR,
	FAZ VARCHAR,
	ENDEREÇO_ELETRONICO VARCHAR,
	REPRESENTANTE VARCHAR,
	CARGO_REPRESENTANTE VARCHAR,
	DATA_REGISTRO_ANS DATE
)

-----QUERY DE INSERÇÃO-------

copy relatorio_cadop(
	REG_ANS,
	CNPJ,
	RAZAO_SOCIAL,
	NOME_FANTASIA,
	MODALIDADE,
	LOGADOURO,
	NUMERO,
	COMPLEMENTO,
	BAIRRO,
	CIDADE,
	UF,
	CEP,
	DDD,
	TELEFONE,
	FAZ,
	ENDEREÇO_ELETRONICO,
	REPRESENTANTE,
	CARGO_REPRESENTANTE,
	DATA_REGISTRO_ANS
)
from 'D:/bd/Relatorio_cadop.csv'
DELIMITER ';'
CSV HEADER
encoding 'ISO8859-1';
-----------
copy demonstracao
(
	DATA,
	REG_ANS,
	CD_CONTA_CONTABIL,
	DESCRICAO,
	VL_SALDO_FINAL
)
From 'D:/bd/4T2020.csv'
DELIMITER ';'
CSV HEADER
encoding 'ISO8859-1'
------------

copy demonstracao
(
	DATA,
	REG_ANS,
	CD_CONTA_CONTABIL,
	DESCRICAO,
	VL_SALDO_FINAL
)
From 'D:/bd/3T2020.csv'
DELIMITER ';'
CSV HEADER
encoding 'ISO8859-1'
--------------

copy demonstracao
(
	DATA,
	REG_ANS,
	CD_CONTA_CONTABIL,
	DESCRICAO,
	VL_SALDO_FINAL
)
From 'D:/bd/2T2020.csv'
DELIMITER ';'
CSV HEADER
encoding 'ISO8859-1'
-------------

copy demonstracao
(
	DATA,
	REG_ANS,
	CD_CONTA_CONTABIL,
	DESCRICAO,
	VL_SALDO_FINAL
)
From 'D:/bd/1T2020.csv'
DELIMITER ';'
CSV HEADER
encoding 'ISO8859-1';
-------------
copy demonstracao
(
	DATA,
	REG_ANS,
	CD_CONTA_CONTABIL,
	DESCRICAO,
	VL_SALDO_FINAL
)
From 'D:/bd/4T2019.csv'
DELIMITER ';'
CSV HEADER
encoding 'ISO8859-1'
---------------
copy demonstracao
(
	DATA,
	REG_ANS,
	CD_CONTA_CONTABIL,
	DESCRICAO,
	VL_SALDO_FINAL
)
From 'D:/bd/3T2019.csv'
DELIMITER ';'
CSV HEADER
encoding 'ISO8859-1'
-------------
copy demonstracao
(
	DATA,
	REG_ANS,
	CD_CONTA_CONTABIL,
	DESCRICAO,
	VL_SALDO_FINAL
)
From 'D:/bd/2T2019.csv'
DELIMITER ';'
CSV HEADER
encoding 'ISO8859-1'
-----------
copy demonstracao
(
	DATA,
	REG_ANS,
	CD_CONTA_CONTABIL,
	DESCRICAO,
	VL_SALDO_FINAL
)
From 'D:/bd/1T2019.csv'
DELIMITER ';'
CSV HEADER
encoding 'ISO8859-1'

-----ADICIONANDO CONSTRAINTS -----

ALTER TABLE relatorio_cadop
add constraint PK 
PRIMARY KEY (reg_ans)


ALTER TABLE demonstracao
ADD constraint PK_demonstracao
primary key(reg_ans, cd_conta_contabil, data)

-- erro pois existem linhas vazias nessa coluna em relatorio cadop. 
--ALTER TABLE demonstracao
--ADD constraint FK
--FOREIGN KEY(reg_ans) 
--REFERENCES relatorio_cadop(reg_ans)




---- QUERY DE SELEÇÃO --------


 ------10 MAIORES DESPESAS NO ULTIMO TRISMESTRE-----
select rc.razao_social as "Razão Social", d.vl_saldo_final as "Saldo Devedor", rc.nome_fantasia as "Nome fantasia", rc.cnpj as "CNPJ", d.data as "DATA"
from demonstracao as d
inner join relatorio_cadop as rc on rc.reg_ans = d.reg_ans
where d.descricao = 'EVENTOS/ SINISTROS CONHECIDOS OU AVISADOS  DE ASSISTÊNCIA A SAÚDE MEDICO HOSPITALAR ' and d.data BETWEEN '2020-10-01'::DATE AND '2020-12-31'::DATE
order by cast(LTrim(RTrim(replace (d.vl_saldo_final, ',','.'))) as numeric(20,2))
limit 10
-----------10 MAIORES DESPESAS NO ULTIMO ANO---------
select rc.razao_social as "Razão Social", d.vl_saldo_final as "Saldo Devedor", rc.nome_fantasia as "Nome fantasia", rc.cnpj as "CNPJ", d.data as "DATA"
from demonstracao as d
inner join relatorio_cadop as rc on rc.reg_ans = d.reg_ans
where d.descricao = 'EVENTOS/ SINISTROS CONHECIDOS OU AVISADOS  DE ASSISTÊNCIA A SAÚDE MEDICO HOSPITALAR ' and d.data BETWEEN '2020-01-01'::DATE AND '2020-12-31'::DATE
order by cast(LTrim(RTrim(replace (d.vl_saldo_final, ',','.'))) as numeric(20,2))
limit 10
