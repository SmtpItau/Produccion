USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[Sp_Elimina_Plazos_preaprobacion]    Script Date: 13-05-2022 11:31:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Sp_Elimina_Plazos_preaprobacion]
                        (
							@Cartera        NUMERIC(01,00)	,
							@Instrumento    CHAR(10)	,
							@Codigo	INT      ,
							@Usuario_Administrativo char(12) ,
							@status	int		,
 							@Fecha_de_aprobacion  datetime,
							@Fecha_de_actualizacion  datetime 	
                         )
AS
BEGIN

SET NOCOUNT ON

      	UPDATE TBLimper_pre_Aprobado SET  
	       Cartera = @Cartera				,
	       Instrumento = @Instrumento  			, 
	       Codigo_Estado_de_Accion = @Codigo		, 
	       Usuario_Administrativo = @Usuario_Administrativo , 
	       Codigo_Estado_de_Informacion = @status 		,
    	   Fecha_de_aprobacion = @Fecha_de_aprobacion	,
 	       Fecha_de_actualizacion = @Fecha_de_actualizacion  	
	WHERE Cartera = @Cartera and Instrumento = @Instrumento 


    SELECT 'OK'
    RETURN
SET NOCOUNT OFF

END-- Base de Datos --
GO
