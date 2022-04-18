-- Creating Tables For Database
CREATE TABLE IF NOT EXISTS salesperson(
    salesperson_id SERIAL PRIMARY KEY,
    first_name VARCHAR(30),
    last_name VARCHAR(30)
);

CREATE TABLE IF NOT EXISTS car(
    car_id SERIAL PRIMARY KEY,
    make VARCHAR(20),
    model VARCHAR(20),
    vin VARCHAR(20),
    color VARCHAR(20),
    car_year INTEGER
);

CREATE TABLE IF NOT EXISTS customer(
    customer_id SERIAL PRIMARY KEY,
    first_name VARCHAR(30),
    last_name VARCHAR(30),
    billing_info VARCHAR(100),
    email VARCHAR(30),
    phone_number INTEGER,
    city VARCHAR(20)
);

CREATE TABLE IF NOT EXISTS invoice(
    invoice_id SERIAL PRIMARY KEY,
    transaction_date DATE DEFAULT CURRENT_DATE,
    invoice_amount NUMERIC(8,2),
    salesperson_id INTEGER NOT NULL,
    customer_id INTEGER NOT NULL,
    car_id INTEGER NOT NULL,
    FOREIGN KEY(salesperson_id) REFERENCES salesperson(salesperson_id),
    FOREIGN KEY(customer_id) REFERENCES customer(customer_id),
    FOREIGN KEY(car_id) REFERENCES car(car_id)
);

CREATE TABLE IF NOT EXISTS service_ticket(
    service_ticket_id SERIAL PRIMARY KEY,
    service_date DATE DEFAULT CURRENT_DATE,
    service_ticket_amount NUMERIC(8,2),
    service_type VARCHAR(100),
    customer_id INTEGER NOT NULL,
    part_id INTEGER NOT NULL,
    mechanic_id INTEGER NOT NULL,
    car_id INTEGER NOT NULL,
	FOREIGN KEY(customer_id) REFERENCES customer(customer_id),
	FOREIGN KEY(part_id) REFERENCES part(part_id),
	FOREIGN KEY(mechanic_id) REFERENCES mechanic(mechanic_id),
	FOREIGN KEY(car_id) REFERENCES car(car_id)
);

CREATE TABLE IF NOT EXISTS service_history(
    service_history_id SERIAL PRIMARY KEY,
	service_history_date DATE DEFAULT CURRENT_DATE,
    car_id INTEGER NOT NULL,
    service_ticket_id INTEGER NOT NULL,
	FOREIGN KEY(car_id) REFERENCES car(car_id),
	FOREIGN KEY(service_ticket_id) REFERENCES service_ticket(service_ticket_id)
);

CREATE TABLE IF NOT EXISTS mechanic(
    mechanic_id SERIAL PRIMARY KEY,
    first_name VARCHAR(20),
    last_name VARCHAR(20)
);

CREATE TABLE IF NOT EXISTS part(
    part_id SERIAL PRIMARY KEY,
    part_name VARCHAR(20)
);

-- Stored Function Filling My Database 
-- Stored function to insert data into actor table
CREATE OR REPLACE FUNCTION add_salesperson(_salesperson_id INTEGER, _first_name VARCHAR, _last_name VARCHAR)
RETURNS void
AS $$
BEGIN
    INSERT INTO salesperson(salesperson_id, first_name, last_name)
	VALUES(_salesperson_id, _first_name, _last_name);
END;
$$
LANGUAGE plpgsql;

-- Adding in Two People into my Salesperson Database
SELECT add_salesperson(500, 'Chris', 'Rock')
SELECT add_salesperson(343, 'Rebel', 'Wilsom')

SELECT *
FROM salesperson;

-- Stored function to insert data into actor table
CREATE OR REPLACE FUNCTION add_customer(_customer_id INTEGER, _first_name VARCHAR, _last_name VARCHAR, _billing_info VARCHAR, _email VARCHAR, _phone_number VARCHAR, _city VARCHAR)
RETURNS void
AS $$
BEGIN
    INSERT INTO customer(customer_id, first_name, last_name, billing_info, email, phone_number, city)
	VALUES(_customer_id, _first_name, _last_name, _billing_info, _email, _phone_number, _city);
END;
$$
LANGUAGE plpgsql;

-- ALTER TABLE customer ALTER COLUMN phone_number TYPE VARCHAR; <-- Had to do this because original TYPE was INT

SELECT add_customer(333, 'Rand', 'alThor','5555-4444-3333-2222', 'dragonREborn@dragonmount.com','(555) 555-5555', 'Two Rivers')
SELECT add_customer(444, 'Kvothe', 'Son of Arliden','6666-6666-3333-2222', 'thebloodless@faefriend.com','(555) 555-5355', 'neware')
SELECT *
FROM customer;

-- INSERT INTO car(car_id, make, model, vin, color, car_year)
-- VALUES(1, 'DMC', 'Delorean', '1FTMF1CT6EFA69632', 'Silver', 1985);

-- INSERT INTO car(car_id, make, model, vin, color, car_year)
-- VALUES(2,'Pontiac','Trans-Am','JKBVNAE19YA010407', 'Black', 1982);

-- INSERT INTO invoice(invoice_id, invoice_amount, salesperson_id, customer_id, car_id)
-- VALUES(222, 899.22, 343, 444, 1);

-- INSERT INTO invoice(invoice_id, invoice_amount, salesperson_id, customer_id, car_id)
-- VALUES(223, 544.22, 500, 333, 2);

-- INSERT INTO service_ticket(service_ticket_id, service_ticket_amount, service_type, customer_id, part_id, mechanic_id, car_id)
-- VALUES(55, 4.44, 'oil change', 444, 654, 999, 1);

-- INSERT INTO service_ticket(service_ticket_id, service_ticket_amount, service_type, customer_id, part_id, mechanic_id, car_id)
-- VALUES(54, 267.56, 'routine maintanence', 333, 543, 998, 2);

-- INSERT INTO service_history(service_history_id, car_id, service_ticket_id)
-- VALUES(777, 1, 54);

-- INSERT INTO service_history(service_history_id, car_id, service_ticket_id)
-- VALUES(776, 2, 55);

-- INSERT INTO mechanic(mechanic_id,first_name,last_name)
-- VALUES(999, 'Johanness', 'Fonzie');

-- INSERT INTO mechanic(mechanic_id,first_name,last_name)
-- VALUES(998, 'Montgomery', 'Scott');

-- INSERT INTO part(part_id,part_name)
-- VALUES(654, 'Omega 13');

-- INSERT INTO part(part_id,part_name)
-- VALUES(543, 'Flux Capacitor');

	



