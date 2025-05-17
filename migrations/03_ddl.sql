CREATE TABLE
	cities (id SERIAL PRIMARY KEY, name varchar(50) UNIQUE);

CREATE TABLE
	countries (id SERIAL PRIMARY KEY, name varchar(50) UNIQUE);

CREATE TABLE
	pet_breeds (id SERIAL PRIMARY KEY, name varchar(50) UNIQUE);

CREATE TABLE
	pet_categories (id SERIAL PRIMARY KEY, name varchar(50) UNIQUE);

CREATE TABLE
	pet_types (id SERIAL PRIMARY KEY, name varchar(50) UNIQUE);

CREATE TABLE
	product_brands (id SERIAL PRIMARY KEY, name varchar(50) UNIQUE);

CREATE TABLE
	product_categories (id SERIAL PRIMARY KEY, name varchar(50) UNIQUE);

CREATE TABLE
	product_colors (id SERIAL PRIMARY KEY, name varchar(50) UNIQUE);

CREATE TABLE
	product_materials (id SERIAL PRIMARY KEY, name varchar(50) UNIQUE);

CREATE TABLE
	product_names (id SERIAL PRIMARY KEY, name varchar(50) UNIQUE);

CREATE TABLE
	product_sizes (id SERIAL PRIMARY KEY, name varchar(50) UNIQUE);

CREATE TABLE
	customers (
		id SERIAL PRIMARY KEY,
		first_name varchar(50),
		last_name varchar(50),
		age INT,
		email varchar(50),
		postal_code varchar(50),
		pet_name varchar(50),
		pet_type_id INT REFERENCES pet_types (id),
		pet_breed_id INT REFERENCES pet_breeds (id),
		pet_category_id INT REFERENCES pet_categories (id),
		country_id INT REFERENCES countries (id)
	);

CREATE TABLE
	products (
		id SERIAL PRIMARY KEY,
		price REAL,
		quantity INT,
		weight REAL,
		description TEXT,
		rating REAL,
		reviews INT,
		release_date varchar(50),
		expiry_date varchar(50),
		product_name_id INT REFERENCES product_names (id),
		product_category_id INT REFERENCES product_categories (id),
		product_size_id INT REFERENCES product_sizes (id),
		product_color_id INT REFERENCES product_colors (id),
		product_brand_id INT REFERENCES product_brands (id),
		product_material_id INT REFERENCES product_materials (id)
	);

CREATE TABLE
	sellers (
		id SERIAL PRIMARY KEY,
		first_name varchar(50),
		last_name varchar(50),
		email varchar(50),
		postal_code varchar(50),
		country_id INT REFERENCES countries (id)
	);

CREATE TABLE
	stores (
		id SERIAL PRIMARY KEY,
		name varchar(50) UNIQUE,
		location varchar(50),
		state varchar(50),
		phone varchar(50),
		email varchar(50),
		country_id INT REFERENCES countries (id),
		city_id INT REFERENCES cities (id)
	);

CREATE TABLE
	suppliers (
		id SERIAL PRIMARY KEY,
		name varchar(50) UNIQUE,
		contact varchar(50),
		email varchar(50),
		phone varchar(50),
		address varchar(50),
		country_id INT REFERENCES countries (id),
		city_id INT REFERENCES cities (id)
	);

CREATE TABLE
	sales (
		id SERIAL PRIMARY KEY,
		sale_date varchar(50),
		sale_customer_id INT REFERENCES customers (id),
		sale_seller_id INT REFERENCES sellers (id),
		sale_product_id INT REFERENCES products (id),
		sale_quantity INT,
		sale_total_price REAL
	);