USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_DEL_DATOS_VALOR_MONEDA_CONTABLE]    Script Date: 13-05-2022 10:53:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_DEL_DATOS_VALOR_MONEDA_CONTABLE] 
(   @dFechaProceso 	DATETIME )
AS
BEGIN

  SET NOCOUNT ON


  DECLARE  @Fecmax DATETIME	

  SELECT  @Fecmax = MAX(Fecha)  
  FROM Valor_Moneda_Contable  

  DELETE Valor_Moneda_Contable  
  WHERE Fecha =@dFechaProceso


END 



GO
