USE [BacCamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_INSERTA_PUNTOS_FORWARDEXCEL]    Script Date: 11-05-2022 16:43:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_INSERTA_PUNTOS_FORWARDEXCEL]  ( 	
  	 	 @nBanda	NUMERIC (3,0)		
		,@nMoneda	NUMERIC (3,0)	
		,@dFecha	DATETIME		
		,@nPlazo	NUMERIC (3,0) 		
		,@fBid		FLOAT			
		,@fAsk		FLOAT			
					   	 )
AS
BEGIN

	SET NOCOUNT ON

	DECLARE @cod_atributo  CHAR(2)  
	DECLARE @tipo_atributo CHAR(30) 
	
	IF EXISTS(SELECT * FROM BacFwdSuda..TBL_TRXCOMEX_PUNTOS WITH(NOLOCK) 	
				WHERE Banda = @nBanda AND Moneda = 999 AND Fecha = @dFecha AND Plazo = @nPlazo)

	BEGIN 
		UPDATE BacFwdSuda..TBL_TRXCOMEX_PUNTOS
		SET Bid = @fBid
		,   Ask = @fAsk
		WHERE Banda = @nBanda 
			AND Moneda = 999 
			AND Fecha = @dFecha 
			AND Plazo = @nPlazo
	END 
	ELSE
	BEGIN
		  
		DECLARE tipo_atributo_cursor CURSOR FOR 

		SELECT tbcodigo1 FROM BacParamSuda.dbo.tabla_general_detalle  WITH(NOLOCK) WHERE tbcateg=8602 and tbcodigo1<>1
	
		OPEN tipo_atributo_cursor
		  
		FETCH NEXT FROM tipo_atributo_cursor 
		INTO @cod_atributo
		  
		WHILE @@FETCH_STATUS = 0
		BEGIN
			INSERT INTO BacFwdSuda..TBL_TRXCOMEX_PUNTOS
			VALUES(  @nBanda				
			  	,@nMoneda			
	                	,@dFecha				
				,@nPlazo		 		
				,@fBid						
				,@fAsk						
				,0				
				,0				
				,0				
				,0				
				,@cod_atributo				
				)
		
			FETCH NEXT FROM tipo_atributo_cursor 
			INTO @cod_atributo
		
		END
		  
		CLOSE tipo_atributo_cursor
		DEALLOCATE tipo_atributo_cursor

	END
	SET NOCOUNT OFF
END
GO
