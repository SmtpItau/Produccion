USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_GRABA_PAPELETAFLI]    Script Date: 13-05-2022 11:31:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_GRABA_PAPELETAFLI](
	 @Fecha_Operacion 	datetime
	,@Numero_Operacion 	numeric(10,0)
	,@pago			tinyint
	,@Instrumento      	varchar(12)  
	,@Nominal  		numeric(21,4)
	,@Tir  			numeric(21,4)
	,@Valor_Referencial 	numeric(21,0)
	,@Margen 		numeric(21,4)
	,@Valor_Inicial	 	numeric(21,0)
	,@CarteraSuper		VARCHAR(1)
)
AS
BEGIN

	INSERT INTO papeleta_Fli
	(	Fecha_Operacion
	,	Numero_Operacion
	,	Pago
	,	Instrumento
	,	Nominal
	,	Tir  			
	,	Valor_Referencial
	,	Margen
	,	Valor_Inicial
	,	CarteraSuper
	)
	VALUES
	(
		@fecha_Operacion
	,	@Numero_Operacion
	,	@pago
	,	@Instrumento
	,	@Nominal
	,	@Tir  			
	,	@Valor_Referencial
	,	@Margen
	,	@Valor_Inicial
	,	@CarteraSuper
	)

END


GO
