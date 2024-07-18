CREATE TABLE Products (
    product_id INTEGER NOT NULL,
    description VARCHAR2(50) NOT NULL,
    price NUMBER(7, 2) NOT NULL,
       
    PRIMARY KEY(product_id)
);
CREATE SEQUENCE seq_product_id;

CREATE TABLE Orders(
    order_id INTEGER NOT NULL,
    order_date DATE,
    
    PRIMARY KEY(order_id)
);
CREATE SEQUENCE seq_order_id;

CREATE TABLE Items(
    order_id INTEGER NOT NULL,
    product_id INTEGER NOT NULL,
    quantity INTEGER NOT NULL,
    
    FOREIGN KEY(order_id)
    REFERENCES Orders(order_id),
    
    FOREIGN KEY(product_id)
    REFERENCES Products(product_id),
    
    PRIMARY KEY(order_id, product_id)
);
CREATE SEQUENCE seq_item_id;

