/* Table: PEDIDOVENDA */

CREATE TABLE PEDIDOVENDA (
    ID INTEGER NOT NULL,
    DATA DATE NOT NULL,
    STATUS VARCHAR(1) NOT NULL,
    ID_CLIENTE INTEGER NOT NULL,
    VALORTOTAL DOUBLE PRECISION NOT NULL);



/* Primary keys definition */

ALTER TABLE PEDIDOVENDA ADD  PRIMARY KEY (ID);


/* Foreign keys definition */

ALTER TABLE PEDIDOVENDA ADD  CONSTRAINT FK_PEDIDOVENDA FOREIGN KEY (ID_CLIENTE) REFERENCES CLIENTE (ID);


CREATE GENERATOR GN_PEDIDOVENDA;
