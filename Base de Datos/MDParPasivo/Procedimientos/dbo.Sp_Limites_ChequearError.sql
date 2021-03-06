USE [MDParPasivo]
GO
/****** Object:  StoredProcedure [dbo].[Sp_Limites_ChequearError]    Script Date: 16-05-2022 11:09:34 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[Sp_Limites_ChequearError]
			(
			@cSistema	CHAR	(03)	,
			@nNumoper	NUMERIC	(10,0)  ,
                        @nActualizar    CHAR(1) = 'N'
			)
AS BEGIN

	SET TRANSACTION ISOLATION LEVEL READ COMMITTED
	SET DATEFORMAT DMY
	SET NOCOUNT ON
	
	DECLARE @Error_Limite CHAR(1)
	DECLARE	@Error_Lineas CHAR(1)

	SELECT @Error_Lineas = 'N'
	SELECT @Error_Limite = 'N'

        SELECT	@Error_Lineas = 'S'
        FROM	LINEA_TRANSACCION_DETALLE  WITH (NOLOCK)
        WHERE 	Error = 'S'
	AND	NumeroOperacion	= @nNumoper
	AND	Id_Sistema	= @cSistema

        SELECT @Error_Limite = 'S'
	FROM	LIMITE_TRANSACCION_ERROR  WITH (NOLOCK)
	WHERE 	NumeroOperacion	= @nNumoper
	AND	Id_Sistema	= @cSistema

        IF @Error_Limite = 'S' OR @Error_Lineas = 'S' BEGIN

            IF @nActualizar = 'S' BEGIN
        	IF @cSistema = 'BTR' UPDATE VIEW_MOVIMIENTO_TRADER		WITH (ROWLOCK) SET mostatreg = 'P' 		WHERE monumoper = @nNumoper
		IF @cSistema = 'BCC' UPDATE VIEW_MOVIMIENTO_CAMBIO		WITH (ROWLOCK) SET moestatus = 'P' 		WHERE monumope  = @nNumoper
		IF @cSistema = 'BFW' UPDATE VIEW_MOVIMIENTO_FORWARD		WITH (ROWLOCK) SET moestado  = 'P' 		WHERE monumoper = @nNumoper
		IF @cSistema = 'BFW' UPDATE VIEW_CARTERA_FORWARD		WITH (ROWLOCK) SET caestado  = 'P' 		WHERE canumoper = @nNumoper
		IF @cSistema = 'BFW' UPDATE VIEW_MOVIMIENTO_FORWARD_PAPEL	WITH (ROWLOCK) SET estado = 'P' 		WHERE numero_operacion = @nNumoper
		IF @cSistema = 'BFW' UPDATE VIEW_CARTERA_FORWARD_PAPEL		WITH (ROWLOCK) SET estado = 'P' 		WHERE numero_operacion = @nNumoper
		IF @cSistema = 'SWP' UPDATE VIEW_CONTRATO           		WITH (ROWLOCK) SET Estado_oper_lineas  = 'P' 	WHERE Numero_operacion = @nNumoper
		IF @cSistema = 'INV' UPDATE VIEW_MOVIMIENTO_INVERSION_EXTERIOR	WITH (ROWLOCK) SET mostatreg  = 'P' 		WHERE monumoper = @nNumoper
--		IF @cSistema = 'SWP' UPDATE VIEW_FRA_CARTERA			WITH (ROWLOCK) SET Estado = 'R'			WHERE numero_operacion  = @nNumoper
            END ELSE
		SELECT	Mensaje, Monto 
		FROM	LIMITE_TRANSACCION_ERROR WITH (NOLOCK)
		WHERE 	NumeroOperacion	= @nNumoper	AND
			Id_Sistema	= @cSistema     --AND
	END ELSE BEGIN
		SELECT	Mensaje, Monto 
		FROM	LIMITE_TRANSACCION_ERROR  WITH (NOLOCK)
		WHERE 	NumeroOperacion	= @nNumoper	AND
			Id_Sistema	= @cSistema
	END
		
END
-- dbo.Sp_Limites_ChequearError 'BFW', 101172, 'S'

GO
