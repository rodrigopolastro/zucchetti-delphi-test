CREATE OR REPLACE TRIGGER RODRIGO_TESTE.increment_product_id
   BEFORE INSERT
   ON Products
   FOR EACH ROW
BEGIN
   SELECT seq_product_id.NEXTVAL 
   INTO :NEW.product_id 
   FROM Products;
END;