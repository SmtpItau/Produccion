USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[SP_CORRESPONSALES_GRABAR]    Script Date: 13-05-2022 10:37:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO


CREATE PROCEDURE [dbo].[SP_CORRESPONSALES_GRABAR](  @rutcliente   		NUMERIC(9)		,
						@codigocliente   	NUMERIC(9)		,
						@codigomoneda   	NUMERIC(5)		,
						@codigopais   		NUMERIC(5)		,
						@codigoplaza   		NUMERIC(5) 		,
						@codigoswift   		VARCHAR(10)		,
						@nombre    		VARCHAR(50) 		,
						@cuentacorriente  	VARCHAR(30)		,
						@swiftsantiago    	VARCHAR(10) = ' '	,
						@bancocentral     	CHAR(1)     = ' '	,
						@fechavencimiento 	DATETIME    = ' '	,
						@Codigo_contable  	CHAR(4)			,
						@correlativo		NUMERIC(5)		,
						@codigo_corres		NUMERIC(6)		,
						@Rut_Corresponsal	NUMERIC(9)		,
						@chips			CHAR(15)		,
						@aba			CHAR(15)
                    )
AS
BEGIN

	IF  @Correlativo = 0 begin 
	    SET @Correlativo = (ISNULL(( select max(cod_corresponsal) from CORRESPONSAL ),0) + 1 )
	END 
	SET NOCOUNT ON
 
	INSERT INTO CORRESPONSAL(	rut_cliente		,
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
					Rut_Corresponsal	,
					Codigo_Chips    	,
					Codigo_Aba      
                                          )    
	VALUES(	@rutcliente		,
		@codigocliente		,
		@codigomoneda		,
		@codigopais		,
		@codigoplaza  		,
		@codigoswift		,
		@nombre			,
		@cuentacorriente	,
		@swiftsantiago		,
		@bancocentral		,
		@fechavencimiento	,
		@Codigo_contable	,
		@Correlativo 		,
		@codigo_corres		,
		@Rut_Corresponsal	,
		@chips			,
		@aba			
		)
 
	IF @@ERROR <> 0 
		SELECT 'error'
	ELSE 
		SELECT 'ok'   

END


-- SP_AUTORIZA_EJECUTAR 'BACUSER'

GO
