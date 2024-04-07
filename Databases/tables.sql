
CREATE TABLE IF NOT EXISTS Customer (
  customer_id VARCHAR(11) NOT NULL UNIQUE PRIMARY KEY,
  amount NUMERIC,
  name VARCHAR(20) NOT NULL
);

CREATE TABLE IF NOT EXISTS Product (
  product_id NUMERIC NOT NULL UNIQUE PRIMARY KEY,
  price NUMERIC NOT NULL,
  name VARCHAR(20) NOT NULL,
  availability BOOLEAN,
  cost NUMERIC
);

CREATE TABLE IF NOT EXISTS Orders (
  order_id NUMERIC NOT NULL UNIQUE PRIMARY KEY,
  amount NUMERIC,
  items NUMERIC,
  customer_name VARCHAR(20),
  customer_id VARCHAR(11) NOT NULL,
  processed BOOLEAN DEFAULT FALSE,
  order_date DATE DEFAULT CURRENT_DATE,
  payment_method VARCHAR(10),
  FOREIGN KEY (customer_id) REFERENCES Customer(customer_id)
);

-- Bridge entity for Product and Order
CREATE TABLE IF NOT EXISTS Bill (
  order_id NUMERIC NOT NULL,
  product_id NUMERIC NOT NULL,
  FOREIGN KEY (order_id) REFERENCES Orders(order_id),
  FOREIGN KEY (product_id) REFERENCES Product(product_id)
);

CREATE TABLE IF NOT EXISTS Caterer (
    total_earning NUMERIC,
    total_cost NUMERIC,
    total_sale NUMERIC,
    total_product_count NUMERIC,
    total_material_cost NUMERIC
);

CREATE TABLE IF NOT EXISTS Supplier (
  supplier_id NUMERIC NOT NULL UNIQUE PRIMARY KEY,
  name VARCHAR(20),
  item VARCHAR(20),
  amount NUMERIC,
  order_count NUMERIC
);

CREATE TABLE IF NOT EXISTS Material (
  material_id NUMERIC NOT NULL UNIQUE PRIMARY KEY,
  price NUMERIC,
  name VARCHAR(20),
  description VARCHAR(50),
  supplier_id NUMERIC,
  FOREIGN KEY (supplier_id) REFERENCES Supplier(supplier_id)
);

-- Bridge entity between Product and Material
CREATE TABLE IF NOT EXISTS Product_Material (
  product_id NUMERIC NOT NULL,
  material_id NUMERIC NOT NULL,
  FOREIGN KEY (product_id) REFERENCES Product(product_id),
  FOREIGN KEY (material_id) REFERENCES Material(material_id)
);

CREATE TABLE IF NOT EXISTS User_Feedback (
  customer_id VARCHAR(11),
  customer_name VARCHAR(20),
  feedback_text VARCHAR(100)
);
