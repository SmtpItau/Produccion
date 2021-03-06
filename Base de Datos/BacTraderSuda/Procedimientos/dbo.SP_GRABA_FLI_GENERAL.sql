USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_GRABA_FLI_GENERAL]    Script Date: 13-05-2022 11:31:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_GRABA_FLI_GENERAL]
	(	@Fecha_Operacion  	DATETIME
	,	@Numero_Operacion 	NUMERIC(10,0)
	,	@Tipo_operacion   	VARCHAR(4)
	,	@Total_Operacion  	NUMERIC(21,0) 
	,	@pago			TINYINT 	
	,	@Usuario		VARCHAR(12)
	)	
AS 
BEGIN 

	DECLARE @Hora		VARCHAR(8)	;

	SET @hora = (SELECT CONVERT(VARCHAR(8), GETDATE() ,108) )	;



	INSERT INTO 
	Resumen_Operaciones_Fli
 	( 	Fecha_Operacion
	,	numero_Operacion
	, 	Tipo_operacion 	
	,	Total_Operacion
	,	Usuario
	,	Hora
	,	Pago
	)
	VALUES 
 	( 	@Fecha_Operacion
	,	@numero_Operacion
	, 	@Tipo_operacion 	
	,	@Total_Operacion
	,	@Usuario
	,	@Hora
	,	@Pago
	)

END 


GO
