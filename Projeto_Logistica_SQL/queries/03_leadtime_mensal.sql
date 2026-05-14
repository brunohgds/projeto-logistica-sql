USE db_logistica
GO

-- 3. Qual o Lead Time médio de entrega para cada transportadora, comparado com o Lead Time médio da transportadora no mês anterior?

WITH LeadTimeMensal AS ( -- O uso do "WITH" é para criar uma tabela temporaria lógica 
	SELECT 
		Nome_Transportadora,
		DATEFROMPARTS( -- Usei 'DATEFROMPARTS' para extrair o mês da da data, e agrupar por mês, transformando toda data em dia '1'.
			YEAR(FE.Data_Entrega_Real),
			MONTH(FE.Data_Entrega_Real),
			1
		) AS Mes_Entrega,
		AVG(
			DATEDIFF( -- O 'DATEDIFF' calcula a diferença entre as duas datas, e o 'AVG' extrai a média.
				DAY,
				FE.Data_Pedido,
				FE.Data_Entrega_Real
			) * 1.0 -- O '*1.0' Para trazer o calculo decimal
		) AS LeadTime_Medio_Atual
	FROM Fat_Entregas FE
	JOIN Dim_Transportadoras DT
		ON FE.ID_Transportadora = DT.ID_Transportadora
	WHERE FE.Status_Entrega IN (
		'Entregue no Prazo',
		'Entregue com Atraso'
	)
	GROUP BY 
		Nome_Transportadora,
		DATEFROMPARTS(
			YEAR(Data_Entrega_Real),
			MONTH(Data_Entrega_Real),
			1
		)
)
SELECT 
	Nome_Transportadora,
	Mes_Entrega,
	LeadTime_Medio_Atual,
	LAG(LeadTime_Medio_Atual, 1, 0) -- Usei o 'LAG' para pegar o valor da linha anterior:	LAG(coluna, linhas_para_tras, valor_default)	
		OVER(
			PARTITION BY Nome_Transportadora -- Uma janela para cada transportadora 
			ORDER BY Mes_Entrega -- Sequencia temporal 
		) AS LeadTime_Medio_Mes_Anteriror,
	LeadTime_Medio_Atual -
	LAG(LeadTime_Medio_Atual, 1, 0)
		OVER(
			PARTITION BY Nome_Transportadora
			ORDER BY Mes_Entrega
		) Diferenca_Mes_Anterior
FROM LeadTimeMensal
ORDER BY
	Nome_Transportadora,
	Mes_Entrega