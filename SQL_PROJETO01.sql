                                                ----   PROJETO    ----

  --- 1º FASE TRATAMENTO DAS INFORMAÇÕES E CRIANDO TABELAS QUE OCUPEM MENOS ESPAÇO NA MEMORIA DO COMPUTADOR OU DO SERVIDOR ---
    -- TRANSFORMANDO AS INFORMAÇÕES DE CARGA PARA INFORMAÇÕES ATUAIS --

--SELECT TOP 10 * 
--FROM TB_CG_OLIST_COSTUMERS
--SELECT TOP 10 * 
--FROM TB_CG_PRODUCT_CATEGORY_NAME_TRANSLATION
--SELECT TOP 10 *
--FROM TB_CG_OLIST_PRODUCTS
--SELECT TOP 10 *
--FROM TB_CG_OLIST_ORDERS
--SELECT TOP 10 *
--FROM TB_CG_OLIST_ORDER_REVIEWS
--SELECT TOP 10 *
--FROM TB_CG_OLIST_ORDER_PAYMENTS
--SELECT TOP 10 *
--FROM TB_CG_OLIST_ORDER_ITEMS
--SELECT TOP 10 *
--FROM TB_CG_OLIST_GEOLOCATION

------------------------------------------------------------------------------------------------------------------------------

CREATE TABLE TB_ACT_OLIST_COSTUMERS
(
customer_id NVARCHAR(150),
customer_unique_id NVARCHAR(150),
customer__zip_code_prefix NVARCHAR(15),
customer_city NVARCHAR(100),
customer_state CHAR(2)
)
INSERT INTO TB_ACT_OLIST_COSTUMERS
SELECT * 
FROM TB_CG_OLIST_COSTUMERS

SELECT * 
FROM TB_ACT_OLIST_COSTUMERS

------------------------------------------------------------------------------------------------------------------------------

CREATE TABLE TB_ACT_PRODUCT_CATEGORY_NAME_TRANSLATION
(
product_category_name NVARCHAR(150),
product_category_name_english NVARCHAR(150)
)
INSERT INTO TB_ACT_PRODUCT_CATEGORY_NAME_TRANSLATION
SELECT * 
FROM TB_CG_PRODUCT_CATEGORY_NAME_TRANSLATION

SELECT * 
FROM TB_ACT_PRODUCT_CATEGORY_NAME_TRANSLATION

------------------------------------------------------------------------------------------------------------------------------

CREATE TABLE TB_ACT_OLIST_PRODUCTS
(
product_id NVARCHAR(150),
product_category_name NVARCHAR(150),
product_name_lenght INT,
product_description_lenght INT,
product_photos_qty INT,
product_weight_g INT,
product_length_cm INT,
product_height_cm INT,
product_width_cm INT
)
UPDATE TB_CG_OLIST_PRODUCTS SET ["product_category_name"] = NULL
WHERE ["product_category_name"] = ''
UPDATE TB_CG_OLIST_PRODUCTS SET ["product_name_lenght"] = NULL
WHERE ["product_name_lenght"] = ''
UPDATE TB_CG_OLIST_PRODUCTS SET ["product_description_lenght"] = NULL
WHERE ["product_description_lenght"] = ''
UPDATE TB_CG_OLIST_PRODUCTS SET ["product_photos_qty"] = NULL
WHERE ["product_photos_qty"] = ''

INSERT INTO TB_ACT_OLIST_PRODUCTS
SELECT * 
FROM TB_CG_OLIST_PRODUCTS

SELECT * 
FROM TB_ACT_OLIST_PRODUCTS

------------------------------------------------------------------------------------------------------------------------------

CREATE TABLE TB_ACT_OLIST_ORDERS
(
order_id NVARCHAR(150),
customer_id NVARCHAR(150),
order_status VARCHAR(30),
order_purchase_timestamp DATETIME,
order_approved_at DATETIME,
order_delivered_carrier_date DATETIME,
order_delivered_customer_date DATETIME,
order_estimated_delivery_date DATETIME
)
UPDATE TB_CG_OLIST_ORDERS SET ["order_approved_at"] = NULL
WHERE ["order_approved_at"] = ''
UPDATE TB_CG_OLIST_ORDERS SET ["order_delivered_carrier_date"] = NULL
WHERE ["order_delivered_carrier_date"] = ''
UPDATE TB_CG_OLIST_ORDERS SET ["order_delivered_customer_date"] = NULL
WHERE ["order_delivered_customer_date"] = ''

INSERT INTO TB_ACT_OLIST_ORDERS
SELECT *
FROM TB_CG_OLIST_ORDERS

UPDATE TB_ACT_OLIST_ORDERS SET [order_approved_at] = NULL
WHERE [order_approved_at] = '1900-01-01 00:00:00.000'
UPDATE TB_ACT_OLIST_ORDERS SET [order_delivered_carrier_date] = NULL
WHERE [order_delivered_carrier_date] = '1900-01-01 00:00:00.000'
UPDATE TB_ACT_OLIST_ORDERS SET [order_delivered_customer_date] = NULL
WHERE [order_delivered_customer_date] = '1900-01-01 00:00:00.000'

SELECT *
FROM TB_ACT_OLIST_ORDERS

------------------------------------------------------------------------------------------------------------------------------

CREATE TABLE TB_ACT_OLIST_ORDER_REVIEWS
(
review_id NVARCHAR(150),
order_id NVARCHAR(150),
review_score NVARCHAR(10),
review_comment_title NVARCHAR(50),
review_comment_message NVARCHAR(300),
review_creation_date DATETIME,
review_answer_timestamp DATETIME
)
UPDATE TB_CG_OLIST_ORDER_REVIEWS SET ["review_comment_title"] = NULL
WHERE ["review_comment_title"] = ''
UPDATE TB_CG_OLIST_ORDER_REVIEWS SET ["review_comment_message"] = NULL
WHERE ["review_comment_message"] = ''

INSERT INTO TB_ACT_OLIST_ORDER_REVIEWS
SELECT * 
FROM TB_CG_OLIST_ORDER_REVIEWS

UPDATE TB_ACT_OLIST_ORDER_REVIEWS SET [review_comment_title] = NULL
WHERE [review_comment_title] = ''
UPDATE TB_ACT_OLIST_ORDER_REVIEWS SET [review_comment_message] = NULL
WHERE [review_comment_message] = ''

SELECT *
FROM TB_ACT_OLIST_ORDER_REVIEWS

------------------------------------------------------------------------------------------------------------------------------

CREATE TABLE TB_ACT_OLIST_ORDER_PAYMENTS
(
order_id NVARCHAR(150),
payment_sequential INT,
payment_type NVARCHAR(30),
payment_installments INT,
payment_value NUMERIC(15,2)
)
INSERT INTO TB_ACT_OLIST_ORDER_PAYMENTS
SELECT *
FROM TB_CG_OLIST_ORDER_PAYMENTS

SELECT *
FROM TB_ACT_OLIST_ORDER_PAYMENTS

------------------------------------------------------------------------------------------------------------------------------

CREATE TABLE TB_ACT_OLIST_ORDER_ITEMS
(
order_id NVARCHAR(150),
order_item_id INT,
product_id NVARCHAR(150),
seller_id NVARCHAR(150),
shipping_limit_date DATETIME,
price NUMERIC(15,2),
freight_value NUMERIC(10,2)
)
INSERT INTO TB_ACT_OLIST_ORDER_ITEMS
SELECT *
FROM TB_CG_OLIST_ORDER_ITEMS

SELECT *
FROM TB_ACT_OLIST_ORDER_ITEMS

------------------------------------------------------------------------------------------------------------------------------

CREATE TABLE TB_ACT_OLIST_GEOLOCATION
(
geolocation_zip_code_prefix FLOAT,
geolocation_lat NVARCHAR(60),
geolocation_lng NVARCHAR(60),
geolocation_city NVARCHAR(70),
geolocation_state VARCHAR(2)
)
INSERT INTO TB_ACT_OLIST_GEOLOCATION
SELECT *
FROM TB_CG_OLIST_GEOLOCATION

SELECT *
FROM TB_ACT_OLIST_GEOLOCATION

------------------------------------------------------------------------------------------------------------------------------

--- 2º FASE RESPONDER AS PERGUNTAS ---

   -- SUPOSIÇÃO DE PERGUNTA: QUAIS CLIENTES FIZERAM UM PEDIDO E QUAIS OS NOMES DE SUAS CIDADES? --
   SELECT *
   FROM TB_ACT_OLIST_COSTUMERS
   SELECT *
   FROM TB_ACT_OLIST_ORDERS

   CREATE VIEW VW_PEDIDOS_POR_CLIENTE   --  CRIAR UMA VISUALIZAÇÃO DA QUERY 
   AS                               -- OBS: CASO QUEIRA ALTERAR A VIEW É SO TROCAR CREATE VIEW POR ALTER VIEW E FAZER AS ALTERAÇÕES NO PROGRAMA
   SELECT AC.customer_city, AC.customer_state, AO.*
   FROM TB_ACT_OLIST_COSTUMERS AS AC
   INNER JOIN TB_ACT_OLIST_ORDERS AS AO
   ON ac.customer_id = ao.customer_id
   WHERE order_status = 'DELIVERED'

   SELECT *
   FROM VW_PEDIDOS_POR_CLIENTE 
  