USE [BacCamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_HEDGE_GRABA_CRITERIOS]    Script Date: 11-05-2022 16:43:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_HEDGE_GRABA_CRITERIOS] (
	 @Cod_Origen		VARCHAR(10)	
	,@Cod_Producto		VARCHAR(10)		
	,@Tipo_Ope		CHAR(1)			
	,@Moneda		CHAR(3)			
	,@Cuenta_Contable	VARCHAR(15)		
	,@Tipo_Valor		VARCHAR(1)		
	,@Imputacion		VARCHAR(1)		
	,@Variable		VARCHAR(30)		
	,@Cod_Orden		INTEGER			
	
)
AS BEGIN
 ---  SET NOCOUNT ON
	INSERT INTO TBL_HEDGE_MANT (Cod_Origen,Cod_Producto,Tipo_Ope,Moneda,Cuenta_Contable,Tipo_Valor,Imputacion,Variable,Cod_Orden)
	VALUES ( @Cod_Origen			
		,@Cod_Producto				
		,@Tipo_Ope					
		,@Moneda					
		,@Cuenta_Contable			
		,@Tipo_Valor				
		,@Imputacion				
		,@Variable				
		,@Cod_Orden )

	IF @@ERROR > 0
	BEGIN
		SELECT -1,'Error: al insertar tabla TBL_HEDGE_MANT'
		RETURN -1	
	END
   RETURN 0
END

GO
