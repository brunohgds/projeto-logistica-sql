# 📊 Projeto de Análise Logística com SQL Server

Projeto desenvolvido com foco em análise logística utilizando SQL Server, abordando métricas operacionais, desempenho de transportadoras e análise temporal de entregas.

---

# 🎯 Objetivo

Responder perguntas de negócio através de SQL analítico, utilizando:

- JOINs
- CTEs
- Window Functions
- Agregações
- Filtros temporais
- Funções de data

---

# 📌 Perguntas de Negócio Respondidas

## 1. Volume total de frete e média de distância por transportadora

Análise do volume financeiro e eficiência operacional das transportadoras.
<img width="875" height="581" alt="01_volume_frete_transportadora" src="https://github.com/user-attachments/assets/592cfc34-34a4-41e5-84cb-d41c939f6419" />


---

## 2. Percentual de entregas atrasadas por transportadora

Cálculo do percentual de atrasos com filtros dinâmicos de período.
<img width="1074" height="558" alt="02_percentual_atraso" src="https://github.com/user-attachments/assets/a732d5f9-42fa-4875-a683-960edeb0dd37" />

---

## 3. Lead Time médio mensal comparado ao mês anterior

Uso de Window Functions (`LAG`) para comparação temporal de desempenho.
<img width="1116" height="698" alt="03_leadtime_mensal" src="https://github.com/user-attachments/assets/f552c48f-51c0-4861-acbd-11d8fcfb3cda" />

---

## 4. Top 3 clientes com maior volume de frete e atraso no último trimestre

Análise combinando:
- múltiplas CTEs
- agregações
- filtros temporais
- ranking

<img width="748" height="647" alt="04_top_clientes_atraso" src="https://github.com/user-attachments/assets/5e5bb1ab-513b-4dbe-a0af-27c069b4e36a" />

---

# 🛠 Tecnologias Utilizadas

- SQL Server
- SSMS (SQL Server Management Studio)
- Git
- GitHub

---

# 📚 Conceitos SQL Aplicados

- SELECT
- JOIN
- GROUP BY
- ORDER BY
- CASE WHEN
- AVG / SUM / COUNT
- DISTINCT
- CTE (`WITH`)
- Window Functions
- `LAG()`
- `DATEADD()`
- `DATEDIFF()`
- `EOMONTH()`
- `DATEFROMPARTS()`

---

# 📂 Estrutura do Projeto

```text
Projeto_Logistica_SQL/
│
├── README.md
│
├── queries/
│   ├── 01_volume_frete_transportadora.sql
│   ├── 02_percentual_atraso.sql
│   ├── 03_leadtime_mensal.sql
│   └── 04_top_clientes_atraso.sql
│
└── assets/
    └── 01_volume_frete_transportadora.jpeg
│   ├── 02_percentual_atraso.jpeg
│   ├── 03_leadtime_mensal.jpeg
│   └── 04_top_clientes_atraso.jpeg
```

---

# 🚀 Aprendizados

Durante o desenvolvimento deste projeto foram praticados conceitos importantes de SQL analítico, especialmente:

- construção de métricas de negócio
- manipulação de datas
- análise temporal
- comparação entre períodos
- organização de queries complexas
- documentação de código SQL

---

# 📈 Próximos Passos

- Criar dashboard no Power BI
- Adicionar KPIs visuais
- Melhorar performance das queries

