CREATE OR REPLACE PROCEDURE newCustomer(
  INPcustomer_name VARCHAR(20),
  INPcustomer_id VARCHAR(11)
) AS $$
DECLARE
  INPamount NUMERIC := 0;
  -- (SELECT SUM(orderTable.amount) FROM orderTable WHERE orderTable.customer_id = INPcustomer_id)
BEGIN
  INSERT INTO customer(customer_name, customer_id, customer_amount) VALUES (INPcustomer_name, INPcustomer_id, INPamount);
  UPDATE customer SET customer_amount = customer.customer_amount + orderTable.amount FROM orderTable WHERE orderTable.customer_id = INPcustomer_id;
  RAISE NOTICE 'new customer created';
END
$$
LANGUAGE
plpgsql;




CREATE OR REPLACE PROCEDURE newOrder(
  INPorder_id NUMERIC,
  INPamount NUMERIC,
  INPitems NUMERIC,
  INPcustomer_name VARCHAR(20),
  INPcustomer_id VARCHAR(11),
  INPproduct_list NUMERIC[]
) AS $$
BEGIN
  INSERT INTO orderTable(order_id, amount, items, customer_name, customer_id, product_list)
    VALUES (INPorder_id, INPamount, INPitems, INPcustomer_name, INPcustomer_id, INPproduct_list);
    RAISE NOTICE 'order created';
  INSERT INTO customer(customer_name, customer_id) VALUES (INPcustomer_name, INPcustomer_id)
    ON CONFLICT DO NOTHING;
  UPDATE customer SET customer_amount = customer.customer_amount + INPamount WHERE customer_id = INPcustomer_id;
  RAISE NOTICE 'order details updated to customer account';
END
$$
LANGUAGE
plpgsql;


--CALL newOrder(003,1000,10,'Mohnish','AU2040110','{1,2,3}');




CREATE OR REPLACE PROCEDURE newProduct(
  INPproduct_id NUMERIC,
  INPprice NUMERIC,
  INPproduct_name VARCHAR(20),
  INPavailability BOOLEAN
) AS $$
BEGIN
  INSERT INTO product(product_id, price, product_name, availability)
    VALUES (INPproduct_id,
    INPprice,
    INPproduct_name,
    INPavailability);
    RAISE NOTICE 'product created';
  -- INSERT INTO customer(customer_name, customer_id) VALUES (INPcustomer_name, INPcustomer_id)
  --   ON CONFLICT DO NOTHING;
  UPDATE menu SET product_list = array_append(product_list,INPproduct_id);
  -- UPDATE menu SET product_price = {product_price,INPproduct_id};
  -- UPDATE menu SET product_list = {product_list,INPproduct_id};

  RAISE NOTICE 'product details updated to menu';
END
$$
LANGUAGE
plpgsql;













--
-- CREATE OR REPLACE PROCEDURE newOrder(
--   INPorder_id NUMERIC,
--   INPamount NUMERIC,
--   INPitems NUMERIC,
--   INPcustomer_name VARCHAR(20),
--   INPcustomer_id VARCHAR(11),
--   INPproduct_list NUMERIC
-- ) AS $$
-- BEGIN
--   INSERT INTO orderTable(order_id, amount, items, customer_name, customer_id, product_list)
--     VALUES (INPorder_id, INPamount, INPitems, INPcustomer_name, INPcustomer_id, INPproduct_list);
--     RAISE NOTICE 'order created';
--   UPDATE customer SET order_id = order_id || INPorder_id WHERE customer_id = INPcustomer_id;
--   INSERT INTO customer(customer_name, customer_id, order_id) VALUES (INPcustomer_name, INPcustomer_id, [customer.order_id,INPorder_id]);
-- --WHERE NOT EXISTS (SELECT customer_id FROM customer WHERE customer.customer_id = INPcustomer_id);
--   UPDATE customer SET customer_amount = customer_amount + INPamount WHERE customer_id = INPcustomer_id;
--   RAISE NOTICE 'order details updated to customer account';
-- END
-- $$
-- LANGUAGE
-- plpgsql;
--
--
-- CREATE OR REPLACE PROCEDURE newCustomer(
--   INPcustomer_name VARCHAR(20),
--   INPcustomer_id VARCHAR(11)
-- ) AS $$
-- DECLARE
--   INPamount NUMERIC := 0;
--   INPorder_id NUMERIC[];
-- BEGIN
--   INSERT INTO customer(customer_name, customer_id, order_id, customer_amount) VALUES (INPcustomer_name, INPcustomer_id, INPorder_id, INPamount);
--   RAISE NOTICE 'new customer created';
-- END
-- $$
-- LANGUAGE
-- plpgsql;
--
--
--
-- --
-- -- CREATE OR REPLACE PROCEDURE addNewProduct() AS $$
-- -- --
--
-- --
-- -- CREATE OR REPLACE PROCEDURE modifyProduct() AS $$
-- -- CREATE OR REPLACE PROCEDURE closeAllOrders() AS $$
--
--
-- --  The Following procudure will repalce the entire database to original status
-- CREATE OR REPLACE PROCEDURE dropAll() AS $$
-- BEGIN
--   DROP TABLE customer CASCADE;
--   DROP TABLE orderTable;
--   DROP TABLE product;
--   DROP TABLE caterer;
--   DROP TABLE menu;
--   DROP TABLE material;
--   DROP TABLE supplier;
--
-- END;
-- $$
-- LANGUAGE
-- plpgsql;
--
--
--
-- CREATE OR REPLACE PROCEDURE resetAll() AS $$
-- BEGIN
--   DROP TABLE customer;
--   DROP TABLE orderTable;
--   DROP TABLE product;
--   DROP TABLE caterer;
--
--   CREATE TABLE IF NOT EXISTS customer(
--     customer_id VARCHAR(11) NOT NULL UNIQUE PRIMARY KEY,
--     customer_amount NUMERIC,
--     customer_name VARCHAR(20),
--     order_id NUMERIC[] NOT NULL
--   );
--
--
--   CREATE TABLE IF NOT EXISTS orderTable(
--     order_id NUMERIC NOT NULL UNIQUE PRIMARY KEY,
--     amount NUMERIC,
--     items NUMERIC,
--     customer_name VARCHAR(20),
--     customer_id VARCHAR(11) NOT NULL,
--     product_list NUMERIC[],
--     processed BOOLEAN,
--     FOREIGN KEY (customer_id) REFERENCES customer(customer_id)
--   );
--
--
--
--   CREATE TABLE IF NOT EXISTS product(
--     product_id NUMERIC NOT NULL UNIQUE PRIMARY KEY,
--     price NUMERIC,
--     product_name VARCHAR(20) NOT NULL,
--     availability BOOLEAN
--   );
--
--
--   CREATE TABLE IF NOT EXISTS caterer(
--       order_list NUMERIC[],
--       product_list NUMERIC[]
--   );
--
--   CREATE TABLE IF NOT EXISTS menu(
--     product_list NUMERIC[],
--     product_price NUMERIC[]
--     --FOREIGN KEY (EACH ELEMENT OF product_list) REFERENCES product(product_id),
--   --  FOREIGN KEY (EACH ELEMENT OF product_price) REFERENCES product(price)
--   );
--
--
--
--
--   CREATE TABLE IF NOT EXISTS  material(
--     material_id NUMERIC NOT NULL UNIQUE PRIMARY KEY,
--     price NUMERIC,
--     material_name VARCHAR(20),
--     material_desc VARCHAR(50)
--   );
--
--
--   CREATE TABLE IF NOT EXISTS supplier(
--     supplier_id NUMERIC NOT NULL,
--     product_supplied VARCHAR(20) NOT NULL,
--     PRIMARY KEY(supplier_id, product_supplied)
--   );
--
-- END;
-- $$
-- LANGUAGE
-- plpgsql;
