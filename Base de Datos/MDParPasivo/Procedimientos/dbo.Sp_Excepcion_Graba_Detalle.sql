USE [MDParPasivo]
GO
/****** Object:  StoredProcedure [dbo].[Sp_Excepcion_Graba_Detalle]    Script Date: 16-05-2022 11:09:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[Sp_Excepcion_Graba_Detalle]
		(
		@cUsuario	  CHAR(15)	,
		@id_sistema	  CHAR(03)	,
		@codigo_producto  CHAR(05)	,
		@Codigo_Excepcion CHAR(02)	,
		@cEstado          CHAR(01)	,
		@nMonto_Excepcion FLOAT
   )
AS BEGIN
SET NOCOUNT ON
SET DATEFORMAT dmy
	IF EXISTS(SELECT 1 FROM EXCEPCION_USUARIO_DETALLE
				WHERE	usuario		 = @cUsuario		AND
					codigo_excepcion = @Codigo_Excepcion	AND
					id_sistema	 = @id_sistema		AND
					codigo_producto	 = @codigo_producto) BEGIN
		UPDATE EXCEPCION_USUARIO_DETALLE
			SET estado           = @cEstado,
			    monto_excepcion  = @nMonto_Excepcion
		WHERE	usuario		 = @cUsuario		AND
			codigo_excepcion = @Codigo_Excepcion	AND
			id_sistema	 = @id_sistema		AND
			codigo_producto	 = @codigo_producto
   
	END ELSE BEGIN
		INSERT INTO EXCEPCION_USUARIO_DETALLE
			(
			usuario		,
			codigo_excepcion,
			estado		,
			monto_excepcion	,
			id_sistema	,
			codigo_producto	
			)
		VALUES
			(
			@cUsuario		,
			@Codigo_Excepcion	,
			@cEstado		,
			@nMonto_Excepcion	,
			@id_sistema		,
			@codigo_producto
		)
	END
SET NOCOUNT OFF
END



GO
