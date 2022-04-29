
CREATE TABLE IF NOT EXISTS customer(
  customer_id VARCHAR(11) NOT NULL UNIQUE PRIMARY KEY,
  customer_amount NUMERIC,
  customer_name VARCHAR(20)
);


CREATE TABLE IF NOT EXISTS orderTable(
  order_id NUMERIC NOT NULL UNIQUE PRIMARY KEY,
  amount NUMERIC,
  items NUMERIC,
  customer_name VARCHAR(20),
  customer_id VARCHAR(11) NOT NULL,
  processed BOOLEAN DEFAULT FALSE,
  order_date DATE DEFAULT CURRENT_DATE,
  product_id NUMERIC,
  FOREIGN KEY (product_id) REFERENCES product(product_id),
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
    product_list NUMERIC[],
    total_earning NUMERIC
);

CREATE TABLE IF NOT EXISTS menu(
  product_list NUMERIC[],
  product_price NUMERIC[],
  product_name VARCHAR(20)[]
  --FOREIGN KEY (EACH ELEMENT OF product_list) REFERENCES product(product_id),
--  FOREIGN KEY (EACH ELEMENT OF product_price) REFERENCES product(price)
);

CREATE TABLE IF NOT EXISTS material(
  material_id NUMERIC NOT NULL UNIQUE PRIMARY KEY,
  price NUMERIC,
  material_name VARCHAR(20),
  material_desc VARCHAR(50),
  required BOOLEAN,
  supplier_id NUMERIC,
  FOREIGN KEY (supplier_id, product_supplied) REFERENCES supplier.(supplier_id,product_supplied)
);

-- remove composite key if required.
CREATE TABLE IF NOT EXISTS supplier(
  supplier_id NUMERIC NOT NULL,
  product_supplied VARCHAR(20) NOT NULL,
  PRIMARY KEY(supplier_id, product_supplied)
);


--
-- CREATE TABLE IF NOT EXISTS bill(
--   order_id NUMERIC NOT NULL,
--
-- )
