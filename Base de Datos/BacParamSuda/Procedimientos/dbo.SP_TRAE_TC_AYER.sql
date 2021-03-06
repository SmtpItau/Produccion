USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_TRAE_TC_AYER]    Script Date: 13-05-2022 10:53:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_TRAE_TC_AYER]
(   @dFechaProceso 	DATETIME 
,   @Nemo		CHAR(10)
)
AS
BEGIN

  SET NOCOUNT ON


  DECLARE  @Fec_Ant DATETIME	

  SELECT  @Fec_Ant = acfecante 
  FROM BacTraderSuda.. mdac

 
       	  SELECT A.Tipo_Cambio 	
      		,A.Porcentaje_Variacion	
		,B.Tipo_Cambio 	
	  FROM  Valor_Moneda_Contable A LEFT JOIN Valor_Moneda_Contable  B 
					ON  B.Fecha	= @dFechaProceso
					AND B.Codigo_Moneda=A.Codigo_Moneda
	  WHERE A.Fecha =@Fec_Ant
	  AND   A.Nemo_Moneda  =@Nemo

END 


GO
