-- Prefix: PDT ---------------------------------
CREATE TABLE Produtos (
    PDT_codigo INTEGER,
    PDT_descri VARCHAR2(50) DEFAULT '' NOT NULL,
    PDT_preco NUMBER(7, 2) DEFAULT 0.00 NOT NULL
);
ALTER TABLE Produtos 
    ADD CONSTRAINT PK_Produtos 
    PRIMARY KEY (PDT_codigo);
    
CREATE SEQUENCE SEQ_Produtos;

COMMENT ON COLUMN Produtos.PDT_codigo IS 'Código único de cada produto';
COMMENT ON COLUMN Produtos.PDT_descri IS 'Descrição do produto';
COMMENT ON COLUMN Produtos.PDT_preco IS 'Preço de uma unidade do produto';

-- Prefix: PED ---------------------------------
CREATE TABLE Pedidos(
    PED_codigo INTEGER,
    PED_data DATE
);
ALTER TABLE Pedidos 
    ADD CONSTRAINT PK_Pedidos 
    PRIMARY KEY (PED_codigo);

CREATE SEQUENCE SEQ_Pedidos;

COMMENT ON COLUMN Pedidos.PED_codigo IS 'Código único de cada pedido';
COMMENT ON COLUMN Pedidos.PED_data IS 'Data em que o pedido foi realizado';


-- Prefix: ITN ---------------------------------
CREATE TABLE Itens(
    ITN_PED_codigo INTEGER,
    ITN_PDT_codigo INTEGER,
    ITN_qtd INTEGER DEFAULT 1 NOT NULL
);

ALTER TABLE Itens 
    ADD CONSTRAINT FK_Itens_Pedidos 
    FOREIGN KEY (ITN_PED_codigo) 
    REFERENCES Pedidos (PED_codigo);

ALTER TABLE Itens 
    ADD CONSTRAINT FK_Itens_Produtos 
    FOREIGN KEY (ITN_PDT_codigo) 
    REFERENCES Produtos (PDT_codigo);

ALTER TABLE Itens 
    ADD CONSTRAINT AK_Items_PED_codigo_PDT_codigo 
    UNIQUE (ITN_PED_codigo, ITN_PDT_codigo);
    
COMMENT ON COLUMN Itens.ITN_PED_codigo IS 'Código do pedido ao qual o item pertence';
COMMENT ON COLUMN Itens.ITN_PDT_codigo IS 'Código do produto adicionado ao pedido';
COMMENT ON COLUMN Itens.ITN_qtd IS 'Quantidade do produto adicionado ao pedido';
