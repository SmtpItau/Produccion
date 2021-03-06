USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_CONTASAREFERENCIASOMA]    Script Date: 13-05-2022 10:53:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_CONTASAREFERENCIASOMA] (	@Codigo 	NUMERIC(3,0)
					  ,   	@Riesgo        	CHARACTER(3))
					  					 					 					 
AS
BEGIN

     SET NOCOUNT ON 

      DECLARE @EXISTE AS INT
      SET @EXISTE =0
      
      SELECT @EXISTE =1
      FROM tasa_referencia_soma
      WHERE trincodigo            = @Codigo 
      AND   trClasificacionriesgo = @Riesgo
	  
          IF @EXISTE =1
	  BEGIN	
 
		SELECT trincodigo
		,      trClasificacionriesgo
		,      trserie
		,      trDesde
		,      trHasta
		,      trtipoper
		,      trtasareferencial
		FROM   tasa_referencia_soma
		WHERE  (trincodigo            = @Codigo 
		AND	trClasificacionriesgo = @Riesgo )
				
	   END 
	   ELSE 
	        BEGIN SELECT -1, 'No existe Información'
	   END
	
END
SET NOCOUNT OFF
GO
