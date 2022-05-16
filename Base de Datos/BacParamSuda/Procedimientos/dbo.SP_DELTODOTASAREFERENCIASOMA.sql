USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_DELTODOTASAREFERENCIASOMA]    Script Date: 13-05-2022 10:53:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_DELTODOTASAREFERENCIASOMA] (	@Codigo	      NUMERIC(3,0)	
						     ,  @Riesgo       CHARACTER(3)	
						     )
AS
BEGIN

	SET NOCOUNT ON 

	DELETE	 tasa_referencia_soma
	WHERE    trincodigo	       = @Codigo                   
 	AND      trClasificacionriesgo = @Riesgo  
	

	SET NOCOUNT OFF

END
GO
