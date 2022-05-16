USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_DELMARGENSOMA]    Script Date: 13-05-2022 10:53:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_DELMARGENSOMA] 	
   (   @p_Codigo_Instrumento    NUMERIC(5)   = 0
   ,   @p_Clasificacion_Riesgo  CHARACTER(3) = ''
   ,   @p_Tipo_OpSoma           CHARACTER(3) = ''
   )
AS
BEGIN

     SET NOCOUNT ON 

	  DELETE FROM MARGEN_INSTRUMENTO_SOMA
	  WHERE Codigo_instrumento   = @p_Codigo_Instrumento
	  AND   Clasificacion_Riesgo = @p_Clasificacion_Riesgo
	  AND   Tipo_OpSoma          = @p_Tipo_OpSoma 
	

	SET NOCOUNT OFF

END
GO
