

CREATE OR REPLACE TRIGGER AFTER INSERT on order
  EXECUTE FUNCTION update_stock();

CREATE OR REPLACE TRIGGER customer_update BEFORE INSERT on orderTable
FOR EACH ROW
  EXECUTE FUNCTION update_customer();



CREATE OR REPLACE FUNCTION update_customer() RETURNS TRIGGER AS $$
BEGIN
  INSERT INTO customer values(NEW.customer_id, NEW.amount, NEW.customer_name) ON CONFLICT DO NOTHING;
  RAISE NOTICE "Customer Values Updated";
  RETURN NULL
END
$$
LANGUAGE
plpgsql;
