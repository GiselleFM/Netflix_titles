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

3. **Carregamento e modelagem no Power BI**
   - Conexão direta ao banco MySQL com as tabelas preparadas.
   - Criação de relacionamentos entre a tabela fato e dimensões.
   - Construção de páginas interativas:
     - **Países:** KPIs, top países, mapa coroplético, evolução temporal.
     - **Filmes x Séries:** total de filmes e séries, top gêneros, evolução anual, detalhamento de título.

---

## Motivação das Escolhas

- **Separação em tabelas dimensões:** evita duplicação e facilita filtros e análises dinâmicas.
- **Explosão de colunas multivalor:** garante medidas corretas e filtragem por país e gênero.
- **Modelo estrela:** clareza e eficiência em cálculos agregados no Power BI.
- **Uso de Power BI com MySQL:** integração direta com o banco, garantindo dados atualizados e manutenção fácil.

---

## Conclusões da Análise

- Identificação de **países com mais títulos** e análise temporal.
- Visualização da **distribuição de filmes x séries** e padrões de lançamento ao longo do tempo.
- Análise de Título permite ver elenco, data de entrada no catálogo, duração, tipo.
- Dashboard interativo facilita a exploração de tendências e insights para decisões rápidas com base nos dados.
