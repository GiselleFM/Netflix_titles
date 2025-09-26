# Netflix Dashboard – Resumo

## Objetivo
Analisar o catálogo da Netflix explorando títulos, países, gêneros, elenco e evolução temporal, com dashboard interativo no Power BI.

---

## Preparação dos Dados

### Python
- Carregamento do dataset.  
- Conversão de tipos de dados.  
- Tratamento de valores nulos.  
- Criação de novas colunas.
- Padronização de dados.

### SQL
- Criação de tabelas dimensões:
  - `titles_by_country(id, show_id, country)`  
  - `titles_by_genre(id, show_id, genre)` 
- População das tabelas intermediárias usando `JSON_TABLE` para separar valores multivalorados.  

### Relacionamento entre tabelas
- **Tabela fato:** `titles_clean` (cada linha representa um título único, chave primária `show_id`).  
- **Tabelas dimensões:** `titles_by_country`, `titles_by_genre`.  
- **Chave de relacionamento:** `show_id` conecta cada dimensão à tabela fato.  
- **Tipo de relacionamento:** **Many (dimensão) → 1 (fato)**, permitindo filtros dinâmicos e agregações eficientes.  

---

## Carregamento no Power BI via MySQL
1. No Power BI Desktop, fui em **Obter Dados → Banco de Dados → MySQL**.  
2. Informei o **servidor**.  
3. Selecionei o **banco de dados** que contém as tabelas.
5. Na aba de Modelo, configurei os **relacionamentos** usando `show_id` para conectar a tabela fato às dimensões.  
6. Após carregar e relacionar, criei **medidas DAX**, **slicers** e **visuais** para montar o dashboard.


## Dashboard Power BI
- **Página Países**: total de títulos, top países, mapa coroplético, evolução temporal.  
- **Página Filmes x Séries**: total de filmes e séries, top gêneros, evolução anual, informações sobre título.  
