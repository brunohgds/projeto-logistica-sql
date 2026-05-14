USE db_logistica
GO

-- 2. Qual o percentual de entregas atrasadas por transportadora no último mês?

SELECT 
	Nome_Transportadora,
	(COUNT( CASE WHEN Status_Entrega = 'Entregue com Atraso' THEN 1 END) * 100.0) / COUNT(*) AS Percentual_Atraso -- Usei o "CASE WHEN" para contar o numero de entregas com atraso
FROM 
	Fat_Entregas FE
JOIN Dim_Transportadoras DT
	ON FE.ID_Transportadora = DT.ID_Transportadora
WHERE
  -- EOMONTH() pega o último dia do mês.
    -- O parâmetro "-2" volta 2 meses a partir da maior data da tabela.
    -- Depois, DATEADD(DAY, 1, ...) adiciona 1 dia,
    -- transformando o fim do mês em início do próximo mês.
	Data_Entrega_Real >= DATEADD(DAY, 1, EOMONTH(
		(SELECT MAX(Data_Entrega_Real) FROM Fat_Entregas), -2
	))
	AND Data_Entrega_Real < DATEADD(DAY, 1, EOMONTH(
		(SELECT MAX(Data_Entrega_Real) FROM Fat_Entregas), 1
	))
GROUP BY
	Nome_Transportadora
ORDER BY 
	Percentual_Atraso DESC