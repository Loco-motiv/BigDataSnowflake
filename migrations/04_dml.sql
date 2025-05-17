INSERT INTO
    countries (name)
SELECT DISTINCT
    customer_country
FROM
    public.mock_data
WHERE
    customer_country IS NOT NULL ON CONFLICT (name) DO NOTHING;

INSERT INTO
    countries (name)
SELECT DISTINCT
    seller_country
FROM
    public.mock_data
WHERE
    seller_country IS NOT NULL ON CONFLICT (name) DO NOTHING;

INSERT INTO
    countries (name)
SELECT DISTINCT
    store_country
FROM
    public.mock_data
WHERE
    store_country IS NOT NULL ON CONFLICT (name) DO NOTHING;

INSERT INTO
    countries (name)
SELECT DISTINCT
    supplier_country
FROM
    public.mock_data
WHERE
    supplier_country IS NOT NULL ON CONFLICT (name) DO NOTHING;

INSERT INTO
    cities (name)
SELECT DISTINCT
    store_city
FROM
    public.mock_data
WHERE
    store_city IS NOT NULL ON CONFLICT (name) DO NOTHING;

INSERT INTO
    cities (name)
SELECT DISTINCT
    supplier_city
FROM
    public.mock_data
WHERE
    supplier_city IS NOT NULL ON CONFLICT (name) DO NOTHING;

INSERT INTO
    pet_types (name)
SELECT DISTINCT
    customer_pet_type
FROM
    public.mock_data
WHERE
    customer_pet_type IS NOT NULL ON CONFLICT (name) DO NOTHING;

INSERT INTO
    pet_breeds (name)
SELECT DISTINCT
    customer_pet_breed
FROM
    public.mock_data
WHERE
    customer_pet_breed IS NOT NULL ON CONFLICT (name) DO NOTHING;

INSERT INTO
    pet_categories (name)
SELECT DISTINCT
    pet_category
FROM
    public.mock_data
WHERE
    pet_category IS NOT NULL ON CONFLICT (name) DO NOTHING;

INSERT INTO
    product_names (name)
SELECT DISTINCT
    product_name
FROM
    public.mock_data
WHERE
    product_name IS NOT NULL ON CONFLICT (name) DO NOTHING;

INSERT INTO
    product_categories (name)
SELECT DISTINCT
    product_category
FROM
    public.mock_data
WHERE
    product_category IS NOT NULL ON CONFLICT (name) DO NOTHING;

INSERT INTO
    product_brands (name)
SELECT DISTINCT
    product_brand
FROM
    public.mock_data
WHERE
    product_brand IS NOT NULL ON CONFLICT (name) DO NOTHING;

INSERT INTO
    product_colors (name)
SELECT DISTINCT
    product_color
FROM
    public.mock_data
WHERE
    product_color IS NOT NULL ON CONFLICT (name) DO NOTHING;

INSERT INTO
    product_sizes (name)
SELECT DISTINCT
    product_size
FROM
    public.mock_data
WHERE
    product_size IS NOT NULL ON CONFLICT (name) DO NOTHING;

INSERT INTO
    product_materials (name)
SELECT DISTINCT
    product_material
FROM
    public.mock_data
WHERE
    product_material IS NOT NULL ON CONFLICT (name) DO NOTHING;

INSERT INTO
    customers (
        first_name,
        last_name,
        age,
        email,
        postal_code,
        pet_name,
        pet_type_id,
        pet_breed_id,
        pet_category_id,
        country_id
    )
SELECT
    md.customer_first_name,
    md.customer_last_name,
    md.customer_age,
    md.customer_email,
    md.customer_postal_code,
    md.customer_pet_name,
    pt.id,
    pb.id,
    pc.id,
    c.id
FROM
    public.mock_data md
    JOIN pet_types pt ON pt.name = md.customer_pet_type
    JOIN pet_breeds pb ON pb.name = md.customer_pet_breed
    JOIN pet_categories pc ON pc.name = md.pet_category
    JOIN countries c ON c.name = md.customer_country ON CONFLICT DO NOTHING;

INSERT INTO
    sellers (
        first_name,
        last_name,
        email,
        postal_code,
        country_id
    )
SELECT
    md.seller_first_name,
    md.seller_last_name,
    md.seller_email,
    md.seller_postal_code,
    c.id
FROM
    public.mock_data md
    JOIN countries c ON c.name = md.seller_country ON CONFLICT DO NOTHING;

INSERT INTO
    stores (
        name,
        location,
        state,
        phone,
        email,
        country_id,
        city_id
    )
SELECT DISTINCT
    md.store_name,
    md.store_location,
    md.store_state,
    md.store_phone,
    md.store_email,
    c.id,
    ci.id
FROM
    public.mock_data md
    JOIN countries c ON c.name = md.store_country
    JOIN cities ci ON ci.name = md.store_city ON CONFLICT DO NOTHING;

INSERT INTO
    suppliers (
        name,
        contact,
        email,
        phone,
        address,
        country_id,
        city_id
    )
SELECT DISTINCT
    md.supplier_name,
    md.supplier_contact,
    md.supplier_email,
    md.supplier_phone,
    md.supplier_address,
    c.id,
    ci.id
FROM
    public.mock_data md
    JOIN countries c ON c.name = md.supplier_country
    JOIN cities ci ON ci.name = md.supplier_city ON CONFLICT DO NOTHING;

INSERT INTO
    products (
        price,
        quantity,
        weight,
        description,
        rating,
        reviews,
        release_date,
        expiry_date,
        product_name_id,
        product_category_id,
        product_size_id,
        product_color_id,
        product_brand_id,
        product_material_id
    )
SELECT DISTINCT
    md.product_price,
    md.product_quantity,
    md.product_weight,
    md.product_description,
    md.product_rating,
    md.product_reviews,
    md.product_release_date,
    md.product_expiry_date,
    pn.id,
    pcg.id,
    ps.id,
    pcol.id,
    pb.id,
    pm.id
FROM
    public.mock_data md
    JOIN product_names pn ON pn.name = md.product_name
    JOIN product_categories pcg ON pcg.name = md.product_category
    JOIN product_sizes ps ON ps.name = md.product_size
    JOIN product_colors pcol ON pcol.name = md.product_color
    JOIN product_brands pb ON pb.name = md.product_brand
    JOIN product_materials pm ON pm.name = md.product_material ON CONFLICT DO NOTHING;

INSERT INTO
    sales (
        sale_date,
        sale_customer_id,
        sale_seller_id,
        sale_product_id,
        sale_quantity,
        sale_total_price
    )
SELECT
    md.sale_date,
    cust.id,
    sell.id,
    prod.id,
    md.sale_quantity,
    md.sale_total_price
FROM
    public.mock_data md
    JOIN customers cust ON cust.email = md.customer_email
    JOIN sellers sell ON sell.email = md.seller_email
    JOIN products prod ON prod.price = md.product_price
    AND prod.quantity = md.product_quantity
    AND prod.product_name_id = (
        SELECT
            id
        FROM
            product_names
        WHERE
            name = md.product_name
    ) ON CONFLICT DO NOTHING;