USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[SP_GRABA_LIMITES_VENTAS]    Script Date: 13-05-2022 10:37:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_GRABA_LIMITES_VENTAS]
   (   @cSistema        CHAR(03)
   ,   @cProducto       CHAR(05)
   ,   @nNumPantalla    NUMERIC(10)
   ,   @nNumoper        NUMERIC(10)
   ,   @cTipoper        CHAR(01)
   ,   @cValidaCheque   CHAR(01)
   ,   @nMercadoLocal   CHAR(01)
   ,   @Canal           CHAR(15) = ''
   )
AS
BEGIN

   SET NOCOUNT ON

      SELECT @cSistema
      ,   @cProducto
      ,   @nNumPantalla
      ,   @nNumoper
      ,   @cTipoper
      ,   @cValidaCheque
      ,   @nMercadoLocal

	IF @cSistema = 'BCC' and @Canal <> 'CORREDORA'
	BEGIN
		IF EXISTS( SELECT 1 FROM BacCamSuda.dbo.MEMO WHERE monumope = @nNumoper AND motipope = 'V' AND movaluta2 > movaluta1)
		BEGIN
			EXECUTE Sp_Lineas_GrbOperacion @cSistema, @cProducto , @nNumPantalla, @nNumoper, @cTipoper, @cValidaCheque, @nMercadoLocal
			RETURN
		END
	END

	DECLARE @dFecPro  		DATETIME
	DECLARE @dFecvctop		DATETIME
	DECLARE @cUsuario  		CHAR(15)
	DECLARE @nMonto   		NUMERIC(19,4)
	DECLARE @cCheckLimOPER  CHAR(1)

		SET @cCheckLimOPER	= 'S'

	DECLARE Cursor_LIMITES_OPERACION SCROLL CURSOR FOR
	SELECT  FechaOperacion,
			SUM(MontoTransaccion),
			FechaVencimiento,
			Operador
	FROM    LINEA_CHEQUEAR
	WHERE   NumeroOperacion = @nNumPantalla	
	AND     Id_Sistema      = @cSistema
	GROUP 
	BY		FechaOperacion, FechaVencimiento, Operador

   OPEN Cursor_LIMITES_OPERACION
   WHILE (1 = 1)
   BEGIN
      FETCH NEXT FROM Cursor_LIMITES_OPERACION
      INTO  @dFecPro,
            @nMonto,
            @dFecvctop,
            @cUsuario

      IF (@@FETCH_STATUS <> 0)
      BEGIN
         BREAK
      END
      EXECUTE Sp_Limites_Grabar @dFecPro, @cSistema, @cProducto, 0, @nNumoper, @nMonto, @dFecvctop, @cUsuario, @cCheckLimOPER, 'N'
   END

   CLOSE Cursor_LIMITES_OPERACION
   DEALLOCATE Cursor_LIMITES_OPERACION

   --********** GRABAR LIMITE DE OPERADOR *****************
   EXECUTE Sp_Limites_Chequear @cSistema, @nNumoper
   EXECUTE Sp_Limites_ReChequear @cSistema, @nNumoper,@cUsuario ,'I'   -- Agrega
   -- Deja la Operacion pendiente para Aprobacion VGS 10/2004

	--> Determina si es operación generada en CHile o NY
	DECLARE @EsOperacionNY	as char(2)
		SET @EsOperacionNY	= 'No'

	IF EXISTS( select 1 from BACBONOSEXTNY..text_mvt_dri where monumoper = @nNumoper)
		SET @EsOperacionNY = 'Si'

	IF @EsOperacionNY = 'No'
	BEGIN
		UPDATE	view_text_mvt_dri
		SET		mostatreg = 'P' 
		WHERE	monumoper = @nNumoper
	END
	IF @EsOperacionNY = 'Si'
	BEGIN
		UPDATE	view_text_mvt_dri_ny
		SET		mostatreg = 'P' 
		WHERE	monumoper = @nNumoper
	END

	DELETE LINEA_CHEQUEAR
	WHERE  Id_Sistema		= @cSistema	
	AND    NumeroOperacion	= @nNumPantalla	
/*	AND    Codigo_Producto	= @cProducto	*/

END

GO
