USE [BacParamSuda]
GO
/****** Object:  UserDefinedFunction [dbo].[fx_Flujo_Adicional_Swap]    Script Date: 13-05-2022 10:49:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE FUNCTION  [dbo].[fx_Flujo_Adicional_Swap]
	(	@nNumeroOperacion		numeric(10)
	,   @iFlujo					INT
	,	@NumeroFlujo			INT
	)	returns		numeric(25,4)
as
BEGIN
	
	

	declare @nMontoRetorno	numeric(25,4);	set @nMontoRetorno	= 0.0
	



	DECLARE @dd_Flu1 AS TABLE (numero_operacion NUMERIC(10) ,
	Compra_Flujo_Adicional NUMERIC(25,4), 
	compra_amortiza NUMERIC(25,4), 
	numero_flujo NUMERIC(10),
	 sec numeric(10,0))


	INSERT INTO @dd_Flu1 
    SELECT numero_operacion,
           case when @iFlujo  = 1 then Compra_Flujo_Adicional ELSE venta_Flujo_Adicional END AS   Compra_Flujo_Adicional,
           compra_amortiza,
           numero_flujo,
           ROW_NUMBER() OVER(PARTITION BY numero_operacion ORDER BY numero_operacion) AS Sec 
    FROM   BacSwapSuda.dbo.cartera
    WHERE tipo_flujo = @iflujo 
    AND numero_operacion =@nNumeroOperacion

SELECT @nMontoRetorno =  Total FROM (

SELECT t1.numero_operacion,
       t1.Compra_Flujo_Adicional,
       t1.numero_flujo,
       SUM(t2.Compra_Flujo_Adicional)  AS Total
FROM   @dd_Flu1                     AS t1
       INNER JOIN @dd_Flu1          AS t2
            ON  t1.sec <= t2.sec
            AND t2.numero_operacion = t1.numero_operacion
GROUP BY
       t1.numero_operacion,
       t1.numero_flujo,
       t1.Compra_Flujo_Adicional
	
) AS RR WHERE numero_flujo=@NumeroFlujo
	
	return @nMontoRetorno
END



GO
