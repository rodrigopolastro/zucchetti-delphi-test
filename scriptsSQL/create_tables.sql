-- Prefix: PDT ---------------------------------
CREATE TABLE Produtos (
    PDT_id INTEGER,
    PDT_descri VARCHAR2(50) DEFAULT '' NOT NULL,
    PDT_preco NUMBER(7, 2) DEFAULT 0.00 NOT NULL
);
ALTER TABLE Produtos 
    ADD CONSTRAINT PK_Produtos 
    PRIMARY KEY (PDT_id);
    
CREATE SEQUENCE SEQ_Produtos;

-- Prefix: PED ---------------------------------
CREATE TABLE Pedidos(
    PED_id INTEGER,
    PED_date DATE
);
ALTER TABLE Pedidos 
    ADD CONSTRAINT PK_Pedidos 
    PRIMARY KEY (PED_id);

CREATE SEQUENCE SEQ_Pedidos;

-- Prefix: ITN ---------------------------------
CREATE TABLE Itens(
    ITN_PED_id INTEGER,
    ITN_PDT_id INTEGER,
    ITN_qtd INTEGER DEFAULT 1 NOT NULL
);

ALTER TABLE Itens 
    ADD CONSTRAINT FK_Itens_Pedidos 
    FOREIGN KEY (ITN_PED_id) 
    REFERENCES Pedidos (PED_id);

ALTER TABLE Itens 
    ADD CONSTRAINT FK_Itens_Produtos 
    FOREIGN KEY (ITN_PDT_id) 
    REFERENCES Produtos (PDT_id);

ALTER TABLE Itens 
    ADD CONSTRAINT AK_Items_PED_id_PDT_id 
    UNIQUE (ITN_PED_id, ITN_PDT_id);
