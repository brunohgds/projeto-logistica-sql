USE db_logistica
GO

-- 4. Quais são os 3 clientes com maior volume de frete que tiveram pelo menos uma entrega atrasada no último trimestre?

WITH ClientesComAtraso AS(
	SELECT DISTINCT -- Usei o "SELECT DISTINCT" para remover os possiveis valores duplicados 
		ID_Cliente
	FROM Fat_Entregas FE
	WHERE
		Status_Entrega = 'Entregue com Atraso' 
		AND Data_Entrega_Real >= DATEADD(QUARTER, -1, DATEFROMPARTS( -- DATEADD(QUARTER, -1, ...) volta 1 trimestre
																	 -- a partir da data de referência
			YEAR((SELECT MAX(Data_Entrega_Real) FROM Fat_Entregas)), 
			MONTH((SELECT MAX(Data_Entrega_Real) FROM Fat_Entregas)),
			1
		)
	)
	AND Data_Entrega_Real <
		DATEFROMPARTS(
			YEAR((SELECT MAX(Data_Entrega_Real) FROM Fat_Entregas)),
			MONTH((SELECT MAX(Data_Entrega_Real) FROM Fat_Entregas)),
			1
		)
),
VolumeFreteClientes AS (
	SELECT 
		Nome_Cliente,
		SUM(Valor_Frete) AS Volume_Total_Frete
	FROM Fat_Entregas FE
	JOIN Dim_Clientes DC
		ON FE.ID_Cliente = DC.ID_Cliente
	WHERE 
		FE.ID_Cliente IN (SELECT ID_Cliente FROM ClientesComAtraso)
		AND FE.Data_Pedido >=	DATEADD(QUARTER, -1, DATEFROMPARTS( -- O uso do "QUARTER" é para indicar Trimestre, e o '-1' para voltar um trimestre
			YEAR((SELECT MAX(Data_Entrega_Real) FROM Fat_Entregas)),
			MONTH((SELECT MAX(Data_Entrega_Real) FROM Fat_Entregas)),
			1
		)
	)
	AND FE.Data_Pedido <
		DATEFROMPARTS(
			YEAR((SELECT MAX(Data_Entrega_Real) FROM Fat_Entregas)),
			MONTH((SELECT MAX(Data_Entrega_Real) FROM Fat_Entregas)),
			1
		)
	GROUP BY 
		DC.Nome_Cliente
)
SELECT TOP 3 
	Nome_Cliente,
	Volume_Total_Frete
FROM 
	VolumeFreteClientes
ORDER BY 
	Volume_Total_Frete DESC 