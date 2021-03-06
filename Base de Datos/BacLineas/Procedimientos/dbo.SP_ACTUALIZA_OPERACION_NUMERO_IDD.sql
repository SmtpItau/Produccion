USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[SP_ACTUALIZA_OPERACION_NUMERO_IDD]    Script Date: 13-05-2022 10:37:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_ACTUALIZA_OPERACION_NUMERO_IDD]	
		(@cmodulo			VARCHAR(3)
		,@cproducto			VARCHAR(10)
		,@nOperacion		NUMERIC(9)
		,@iCorrelativo		NUMERIC(4)
		,@nNumeroIdd		NUMERIC(9)	= 0)
AS    
BEGIN		

		IF @cmodulo = 'BEX'
		BEGIN
			SELECT @cproducto = CASE WHEN @cproducto = 'CP' THEN 'CPX' 
										WHEN @cproducto = 'VP' THEN 'VPX' 
								ELSE @cproducto 
								END
		END

		IF @cmodulo = 'BTR'
		BEGIN
			SELECT @cproducto = CASE WHEN @cproducto = 'IB' THEN 'ICOL' 
								ELSE @cproducto 
								END
		END
		
		IF EXISTS (SELECT 1 FROM Transacciones_IDD WHERE cModulo		= @cmodulo
													AND cProducto		= ( case when @cmodulo = 'PCS' then cproducto else @cproducto end )
													AND nOperacion		= @nOperacion
													AND iCorrelativo	= @iCorrelativo )
		BEGIN
			UPDATE ti
			SET	nNumeroIdd = @nNumeroIdd
			FROM Transacciones_IDD ti -- select * from Transacciones_IDD where fecha = '20190725'
			WHERE
				cModulo				= @cmodulo
				AND cProducto		=  ( case when @cmodulo = 'PCS' then cproducto else @cproducto end )
				AND nOperacion		= @nOperacion
				AND iCorrelativo	= @iCorrelativo
				AND iEstadoIDD		IN('R','P')
		END
		
		IF @@ERROR <> 0
		BEGIN
			SELECT -1,'Error al actualizar Numero IDD'
			RETURN
		END			

		
END

GO
