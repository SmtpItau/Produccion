USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_CONHAIRCUTSOMA]    Script Date: 13-05-2022 10:53:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_CONHAIRCUTSOMA] 	(  @TipoOpe	 CHAR(03)		
					)
					  					 					 					 
AS
BEGIN

     SET NOCOUNT ON 

      DECLARE @EXISTE AS INT
      SET @EXISTE =0
      
      SELECT @EXISTE =1
      FROM   HAIRCUT_SOMA
      WHERE  hctipoper   =  @TipoOpe 
     
	  
          IF @EXISTE =1
	  BEGIN	
 
		SELECT hcincodigo
   		,      hcClasificacionRiesgo
   		,      hctipoper
   		,      hchaircut
  
		FROM   HAIRCUT_SOMA
		WHERE  hctipoper   = @TipoOpe 
		
				
	   END 
	   ELSE 
	        BEGIN SELECT -1, 'No existe Información'
	   END
	
END
SET NOCOUNT OFF
GO
