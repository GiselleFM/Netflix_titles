USE netflix_case;


-- Criação tabela fato

CREATE TABLE titles_clean (
    show_id VARCHAR(255),
    type VARCHAR(255),
    title VARCHAR(255),
    director VARCHAR(255),
    cast VARCHAR(255),
    country VARCHAR(255),
    date_added DATE,
    release_year INT,
    rating VARCHAR(255),
    duration VARCHAR(255),
    listed_in VARCHAR(255),
    description VARCHAR(255),
    duration_value int,
    duration_unit VARCHAR(255)
);

-- Preenchendo a tabela com o dataset clean

LOAD DATA INFILE "C:/wamp64/tmp/netflix_titles_clean.csv"
INTO TABLE tabela_central
FIELDS TERMINATED BY ','       -- separador do CSV
ENCLOSED BY '"'                -- aspas, se houver
LINES TERMINATED BY '\n'       -- quebra de linha
IGNORE 1 ROWS;                 -- ignora o cabeçalho


-- Criação tabela dimensão conectando pela chave primária SHOW_ID que se torna chave estrangeira

CREATE TABLE titles_by_country (
    id INT AUTO_INCREMENT PRIMARY KEY,
    show_id VARCHAR(255) NOT NULL,
    country VARCHAR(255) NOT NULL
);

-- Preenchendo tabela dimensão
INSERT INTO titles_by_country (show_id, country)
SELECT
    show_id,
    TRIM(value) AS country
FROM tabela_central
JOIN JSON_TABLE(
    CONCAT('["', REPLACE(country, ',', '","'), '"]'),
    '$[*]' COLUMNS (value VARCHAR(255) PATH '$')
) AS jt_country;


-- Segunda tabela dimensão com SHOW_ID chave estrangeira conectando a tabela fato
CREATE TABLE titles_by_genre (
    id INT AUTO_INCREMENT PRIMARY KEY,
    show_id VARCHAR(255) NOT NULL,
    genre VARCHAR(255) NOT NULL
);

-- Preenchendo tabela
INSERT INTO titles_by_genre (show_id, genre)
SELECT
    show_id,
    TRIM(value) AS genre
FROM tabela_central
JOIN JSON_TABLE(
    CONCAT('["', REPLACE(listed_in, ',', '","'), '"]'),
    '$[*]' COLUMNS (value VARCHAR(255) PATH '$')
) AS jt_genre;

-- Transformamos os valores separados por virgulas como uma array em JSON
-- Colocamos colchetes e aspas para transformar em uma array válida
-- A função explode o array JSON, criando uma linha para cada valor do array
-- Dessa forma, temos de forma detalhada e separada dentro de nossas tabelas dimensões
-- O relacionamento entre elas foi criado através do ID único SHOW_ID na tabela fato
-- Dentro do power bi podemos criar um star schema entre as tabelas por causa da chame primária e entrageira criadas





