USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[sp_Rechaza_Plazo_Permanencia]    Script Date: 13-05-2022 11:31:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[sp_Rechaza_Plazo_Permanencia]
						 (
			                         @Cartera        		NUMERIC(01,00)	,
			                         @Instrumento    		CHAR(10)	,
	 				         @status 			INT	     	,
					         @Fecha_de_aprobacion 		DATETIME        ,
					         @Usuario_Supervisor  		CHAR (12)    
						 )

AS

BEGIN

      UPDATE TBLimper_pre_Aprobado 
	 SET  Codigo_Estado_de_Informacion = @status			, 
	      Fecha_de_aprobacion 	   = @Fecha_de_aprobacion	, 
	      Usuario_Supervisor  	   = @Usuario_Supervisor 

	WHERE Cartera = @Cartera and Instrumento = @Instrumento 
  END
GO
