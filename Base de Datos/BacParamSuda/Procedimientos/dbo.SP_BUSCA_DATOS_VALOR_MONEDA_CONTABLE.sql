USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_BUSCA_DATOS_VALOR_MONEDA_CONTABLE]    Script Date: 13-05-2022 10:53:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_BUSCA_DATOS_VALOR_MONEDA_CONTABLE] 
(   @dFechaProceso 	DATETIME )
AS
BEGIN

  SET NOCOUNT ON


  DECLARE  @Fecmax  DATETIME	
  ,        @Fec_Ant DATETIME	

  SELECT  @Fecmax = MAX(Fecha)  
  FROM Valor_Moneda_Contable  

  SELECT  @Fec_Ant = acfecante
  FROM BacTraderSuda..MDAC

 
  IF NOT EXISTS(SELECT * FROM Valor_Moneda_Contable WHERE Fecha =@dFechaProceso)
  BEGIN 
       	   SELECT  A.Fecha                       
		, A.Codigo_Moneda 
		, A.Nemo_Moneda 
	        , C.mnglosa
		, A.Codigo_Contable 
		, 0.0 -- A.Tipo_Cambio 
		, A.Porcentaje_Variacion   
		, ISNULL(B.Tipo_Cambio,0.0) 
	  FROM  Valor_Moneda_Contable A
					LEFT JOIN Valor_Moneda_Contable  B 
					ON  B.Fecha	= @Fec_Ant
					AND B.Codigo_Moneda=A.Codigo_Moneda
	  , Moneda C 
	  WHERE A.Fecha = @Fecmax
	  AND   A.Codigo_Moneda  = C.mncodmon
	
  END	
  ELSE
  BEGIN
 	  SELECT  A.Fecha                       
		, A.Codigo_Moneda 
		, A.Nemo_Moneda 
	        , C.mnglosa
		, A.Codigo_Contable 
		, A.Tipo_Cambio 
		, A.Porcentaje_Variacion   
		, ISNULL(B.Tipo_Cambio,0.0)
	  FROM  Valor_Moneda_Contable A
					LEFT JOIN Valor_Moneda_Contable  B 
					ON  B.Fecha	= @Fec_Ant
					AND B.Codigo_Moneda=A.Codigo_Moneda
	  , Moneda C 
	  WHERE A.Fecha =@dFechaProceso
	  AND   A.Codigo_Moneda  = C.mncodmon


  END 

END 





-- SELECT  *  FROM Valor_Moneda_Contable 







GO
