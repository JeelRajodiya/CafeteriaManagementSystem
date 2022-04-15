
CREATE OR REPLACE FUNCTION getPendingOrder() RETURNS TABLE(order_id NUMERIC, customer_name VARCHAR(20), customer_id VARCHAR(11), amount NUMERIC) AS $$
BEGIN
  RETURN QUERY SELECT orderTable.order_id, orderTable.customer_name, orderTable.customer_id, orderTable.amount FROM orderTable WHERE (orderTable.processed = false);
END
$$
LANGUAGE
plpgsql;



CREATE OR REPLACE FUNCTION filterTableElements(cutoffLimit NUMERIC) RETURNS RECORD AS $$
BEGIN
  CREATE VIEW filteredElements AS
  (SELECT * FROM
    ordertable FULL OUTER JOIN customer ON ordertable.order_id = customer.order_id
    WHERE customer.customer_amount > cutoffLimit OR ordertable.amount > cutoffLimit);

  RETURN filteredElements;
END
$$
LANGUAGE
plpgsql;

CREATE OR REPLACE FUNCTION getMaxPayingCustomer() RETURNS RECORD AS $$
BEGIN
  RETURN (SELECT * FROM customer WHERE customer_amount = (SELECT MAX(customer_amount) FROM customer));
END
$$
LANGUAGE
plpgsql;




-- CREATE OR REPLACE FUNCTION getMaxOrderedItem() RETURNS RECORD AS $$
-- BEGIN
--
--
--
-- CREATE OR REPLACE FUNCTION getMaxProfitItem() RETURNS RECORD AS $$
-- CREATE OR REPLACE FUNCTION () RETURNS RECORD AS $$
