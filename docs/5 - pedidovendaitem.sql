/* Table: PEDIDOVENDAITEM */

CREATE TABLE PEDIDOVENDAITEM (
    ID INTEGER NOT NULL,
    ID_PEDIDO INTEGER NOT NULL,
    ID_PRODUTO INTEGER NOT NULL,
    VALORUNITARIO DOUBLE PRECISION NOT NULL,
    QT DOUBLE PRECISION NOT NULL);



/* Primary keys definition */

ALTER TABLE PEDIDOVENDAITEM ADD CONSTRAINT PK_PEDIDOVENDAITEM PRIMARY KEY (ID);


/* Foreign keys definition */

ALTER TABLE PEDIDOVENDAITEM ADD  CONSTRAINT FK_PEDIDOVENDAITEM_ID_PEDIDO FOREIGN KEY (ID_PEDIDO) REFERENCES PEDIDOVENDA (ID);
ALTER TABLE PEDIDOVENDAITEM ADD  CONSTRAINT FK_PEDIDOVENDAITEM_ID_PRODUTO FOREIGN KEY (ID_PRODUTO) REFERENCES PRODUTO (ID);


CREATE GENERATOR GN_PEDIDOVENDAITEM;