--SPRINT 3 - GRUPO CMD
--551665 - Felipe Cortez
--550282 - Guilherme Bezerra 
--98632 - Lucas de Lima
--99748 - Rodolfo Sanches
--99692 - Vitor Granero

CREATE TABLE estados(
    idEstado       NUMBER(7)    CONSTRAINT est_estado_id PRIMARY KEY,
    nome           VARCHAR2(200)NOT NULL);
    
CREATE TABLE cidades(
    idCidade       NUMBER(7)    CONSTRAINT cid_ibge_cod PRIMARY KEY,
    nome           VARCHAR2(200) NOT NULL,
    idEstado       NUMBER(7)    CONSTRAINT cid_estado_fk REFERENCES estados);

CREATE TABLE bairros(
    idBairro       NUMBER(7)    CONSTRAINT bairros_bairro_id PRIMARY KEY,
    nome           VARCHAR2(200)NOT NULL,
    idCidade       NUMBER(7)    CONSTRAINT bairros_cid_fk REFERENCES cidades);
    
CREATE TABLE logradouros(
    idLogradouro   NUMBER(7)    CONSTRAINT logr_logradouros_id PRIMARY KEY,
    descricao      VARCHAR2(200)NOT NULL);
    
CREATE TABLE enderecos(
    idEndereco     NUMBER(7)    CONSTRAINT end_endereco_id PRIMARY KEY,
    nomeLogradouro VARCHAR2(200)NOT NULL,
    idLogradouro   NUMBER(7)    CONSTRAINT end_logr_fk REFERENCES logradouros,
    idBairro       NUMBER(7)    CONSTRAINT end_bairro_fk REFERENCES bairros);

CREATE TABLE niveis_consultoras(
    idNivel        NUMBER(7)    CONSTRAINT niveis_nivel_id PRIMARY KEY,
    tipo           VARCHAR2(50) NOT NULL,
    descricao      VARCHAR2(200));

CREATE TABLE categorias_produtos(
    idCategoria    NUMBER(7)    CONSTRAINT cat_prod_cat_id PRIMARY KEY,
    descricao      VARCHAR2(50) NOT NULL);
    
CREATE TABLE clientes(
    idCliente      NUMBER(7)    CONSTRAINT cli_cliente_id PRIMARY KEY,
    nome           VARCHAR2(50) NOT NULL,
    cpf            VARCHAR2(11) NOT NULL
                                CONSTRAINT cli_cpf_uk UNIQUE
                                CONSTRAINT cli_cpf_ck CHECK(LENGTH(cpf)=11),
    dataNasc       DATE,
    telefone       VARCHAR2(15),
    numeroEndereco NUMBER(5)    NOT NULL,
    complementoEnd VARCHAR2(100),
    idEndereco     NUMBER(7)    CONSTRAINT cli_end_fk REFERENCES enderecos);

CREATE TABLE consultoras(
    idConsultora   NUMBER(7)    CONSTRAINT cons_consultora_id PRIMARY KEY,
    nome           VARCHAR2(50) NOT NULL,
    cpf            VARCHAR2(11) NOT NULL
                                CONSTRAINT cons_cpf_ck CHECK(LENGTH(cpf)=11),
    dataNasc       DATE         NOT NULL,
    emailLogin     VARCHAR2(200)NOT NULL
                                CONSTRAINT cons_email_uk UNIQUE,
    senhaLogin     VARCHAR2(50) NOT NULL
                                CONSTRAINT cons_senha_uk UNIQUE,
    telefone       VARCHAR2(15) NOT NULL,
    numeroEndereco NUMBER(5)    NOT NULL,
    complementoEnd VARCHAR2(100),
    idEndereco     NUMBER(7)    CONSTRAINT cons_end_fk REFERENCES enderecos,
    niveisConsultoras NUMBER(7) CONSTRAINT cons_niveis_fk REFERENCES niveis_consultoras);

CREATE TABLE compras(
    idCompra       NUMBER(7)    CONSTRAINT comp_compras_id PRIMARY KEY,
    valor          NUMBER(10,2) NOT NULL,
                                CONSTRAINT comp_valor_ck CHECK (valor>0),
    dataCompra     DATE         NOT NULL,
    idConsultora   NUMBER(7)    CONSTRAINT comp_cons_fk REFERENCES consultoras);

CREATE TABLE vendas(
    idVenda        NUMBER(7)    CONSTRAINT vendas_venda_id PRIMARY KEY,
    valor          NUMBER(10,2) NOT NULL
                                CONSTRAINT vendas_valor_ck CHECK(valor>0),
    dataVenda      DATE         NOT NULL,
    idConsultora   NUMBER(7)    CONSTRAINT vendas_cons_fk REFERENCES consultoras,
    idCliente      NUMBER(7)    CONSTRAINT vendas_cli_fk REFERENCES clientes);
    
CREATE TABLE produtos(
    idProduto      NUMBER(7)    CONSTRAINT prod_produto_id PRIMARY KEY,
    nome           VARCHAR2(50) NOT NULL,
    preco          NUMBER(10,2) NOT NULL
                                CONSTRAINT prod_preco_ck CHECK(preco>0),
    idCategoria    NUMBER(7)    CONSTRAINT prod_cat_fk REFERENCES categorias_produtos);

CREATE TABLE vendas_produtos(
    qntd           NUMBER(10)   NOT NULL
                                CONSTRAINT vend_prod_qntd_ck CHECK(qntd>0),
    idVenda        NUMBER(7)    CONSTRAINT vend_prod_vend_fk REFERENCES vendas,
    idProduto      NUMBER(7)    CONSTRAINT vend_prod_prod_fk REFERENCES produtos);
  
CREATE TABLE compras_produtos(
    qntd           NUMBER(10)   NOT NULL
                                CONSTRAINT comp_prod_qntd_ck CHECK(qntd>0),
    idCompra       NUMBER(7)    CONSTRAINT comp_prod_comp_fk REFERENCES compras,
    idProduto      NUMBER(7)    CONSTRAINT comp_prod_prod_fk REFERENCES produtos);

CREATE TABLE clientes_consultoras(
    idCliente      NUMBER(7)    CONSTRAINT cli_cons_cli_id REFERENCES clientes,
    idConsultora   NUMBER(7)    CONSTRAINT cli_cons_cons_id REFERENCES consultoras); 
