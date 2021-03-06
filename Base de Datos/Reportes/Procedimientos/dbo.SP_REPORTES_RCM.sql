USE [Reportes]
GO
/****** Object:  StoredProcedure [dbo].[SP_REPORTES_RCM]    Script Date: 16-05-2022 10:19:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_REPORTES_RCM]
	(	@tipo_reporte		CHAR(3) = ''	
	,	@Fecha			DATETIME = NULL
	)
AS
  
BEGIN   

	SET NOCOUNT ON	


	-->	   Forward
	---------------------------------
	IF(@tipo_reporte = 'BFW')
	   BEGIN

		  EXEC SP_REPORTES_RCM_BFW @Fecha 	   

	   END

	-->	   Swap Tasas
	---------------------------------
	IF(@tipo_reporte = 'IRS')
	   BEGIN
		  
		  EXEC SP_REPORTES_RCM_IRS @Fecha

	   END
   
	-->	   Swap Monedas
	---------------------------------
	IF(@tipo_reporte = 'CCS')
	   BEGIN
		  
		  EXEC SP_REPORTES_RCM_CCS @Fecha
		  
	   END 

    -->  Opciones y Anticipos de Opciones 
    ---------------------------------------
    IF(@tipo_reporte = 'OPT')
	   BEGIN
	   	
		  EXEC SP_REPORTES_RCM_OPT @Fecha
		  
	   END
    
END

GO
