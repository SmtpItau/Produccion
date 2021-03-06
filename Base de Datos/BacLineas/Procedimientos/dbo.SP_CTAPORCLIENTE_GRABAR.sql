USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[SP_CTAPORCLIENTE_GRABAR]    Script Date: 13-05-2022 10:37:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_CTAPORCLIENTE_GRABAR](   @rutcliente   		NUMERIC(9)		,
						@codigocliente   	NUMERIC(9)		,
						@codigomoneda   	NUMERIC(5)		,
					--	@codigopais   		NUMERIC(5)		,
					--	@codigoplaza   		NUMERIC(5) 		,
					--	@codigoswift   		VARCHAR(10)		,
						@nombre    		VARCHAR(50) 		,
						@cuentacorriente  	VARCHAR(30)		
					--	@swiftsantiago    	VARCHAR(10) = ' '	,
					--	@bancocentral     	CHAR(1)     = ' '	,
					--	@fechavencimiento 	DATETIME    = ' '	,
					--	@Codigo_contable  	CHAR(4)			,
					--	@correlativo		NUMERIC(5)		,
					--	@codigo_corres		NUMERIC(6)		,
					--	@Rut_Corresponsal	NUMERIC(9)
                    )
AS
BEGIN
	SET NOCOUNT ON
 
	INSERT INTO CUENTAS_POR_MONEDA(	rut_cliente		,
					codigo_cliente		,
					codigo_moneda		,
					codigo_pais		,
					codigo_plaza		,
					codigo_swift		,
					nombre			,
					cuenta_corriente	,
					swift_santiago		,
					banco_central		,
					fecha_vencimiento	,
					codigo_contable		,
					cod_corresponsal 	,
					codigo_corres		,
					Rut_Corresponsal
                                          )    
	VALUES(	@rutcliente		,
		@codigocliente		,
		@codigomoneda		,
		0		,
		0  		,
		''		,
		@nombre			,
		@cuentacorriente	,
		''		,
		''		,
		''	,
		''	,
		0 		,
		0		,
		0	
		)
 
	IF @@ERROR <> 0 
		SELECT 'error'
	ELSE 
		SELECT 'ok'   

END

GO
