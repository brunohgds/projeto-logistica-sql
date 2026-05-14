USE db_logistica
GO

-- 1. Qual o volume total de frete e a média de distância percorrida por transportadora?

SELECT
	Nome_Transportadora,
	SUM(Valor_Frete) AS Volume_total_frete,
	AVG(Distancia_Km) AS Media_distancia_percorrida
FROM Fat_Entregas FE
JOIN Dim_Transportadoras DT
	ON FE.ID_Transportadora = DT.ID_Transportadora
GROUP BY 
	Nome_Transportadora
ORDER BY
	Volume_total_frete DESC 