USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[Sp_Elimina_Plazos_Aprobacion]    Script Date: 13-05-2022 11:31:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Sp_Elimina_Plazos_Aprobacion]
                        ( @Cartera        		NUMERIC(01,00)	,
                	  @Instrumento    		CHAR(10)	,
			  @Usuario_Administrativo 	char(12) ,	
			  @Usuario_Supervisor 		char(20),
			  @Fecha_de_actualizacion  	datetime 	,
 			  @Fecha_de_aprobacion  	datetime,
			  @status			int		,
			  @Codigo			INT      )
AS
BEGIN

SET NOCOUNT ON

      	UPDATE TBLimper_pre_Aprobado SET  
	       Cartera 				= @Cartera				,
	       Instrumento 			= @Instrumento  			, 
	       Codigo_Estado_de_Accion 		= @Codigo		, 
	       Usuario_Administrativo 		= @Usuario_Administrativo , 
	       Codigo_Estado_de_Informacion	= @status 		,
    	       Fecha_de_aprobacion 		= @Fecha_de_aprobacion	,
 	       Fecha_de_actualizacion 		= @Fecha_de_actualizacion ,
	       Usuario_Supervisor 		= @Usuario_Supervisor 	  
	WHERE Cartera = @Cartera and Instrumento = @Instrumento 


    SELECT 'OK'
    RETURN
SET NOCOUNT OFF

END

GO
