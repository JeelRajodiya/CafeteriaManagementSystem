
CREATE TABLE IF NOT EXISTS customer(
  customer_id VARCHAR(11) NOT NULL UNIQUE PRIMARY KEY,
  customer_amount NUMERIC,
  customer_name VARCHAR(20),
  order_id NUMERIC[]
);


CREATE TABLE IF NOT EXISTS orderTable(
  order_id NUMERIC NOT NULL UNIQUE PRIMARY KEY,
  amount NUMERIC,
  items NUMERIC,
  customer_name VARCHAR(20),
  customer_id VARCHAR(11) NOT NULL,
  product_list NUMERIC[],
  processed BOOLEAN,
  FOREIGN KEY (customer_id) REFERENCES customer(customer_id)
);



CREATE TABLE IF NOT EXISTS product(
  product_id NUMERIC NOT NULL UNIQUE PRIMARY KEY,
  price NUMERIC,
  product_name VARCHAR(20) NOT NULL,
  availability BOOLEAN
);


CREATE TABLE IF NOT EXISTS caterer(
    order_list NUMERIC[],
    product_list NUMERIC[]
);

CREATE TABLE IF NOT EXISTS menu(
  product_list NUMERIC[],
  product_price NUMERIC[]
  --FOREIGN KEY (EACH ELEMENT OF product_list) REFERENCES product(product_id),
--  FOREIGN KEY (EACH ELEMENT OF product_price) REFERENCES product(price)
);




CREATE TABLE IF NOT EXISTS  material(
  material_id NUMERIC NOT NULL UNIQUE PRIMARY KEY,
  price NUMERIC,
  material_name VARCHAR(20),
  material_desc VARCHAR(50)
);


CREATE TABLE IF NOT EXISTS supplier(
  supplier_id NUMERIC NOT NULL,
  product_supplied VARCHAR(20) NOT NULL,
  PRIMARY KEY(supplier_id, product_supplied)
);



-- TO DO - MAKE BRIDGE ENTITY FOR MANY TO MANY RELATIONSHIPS
