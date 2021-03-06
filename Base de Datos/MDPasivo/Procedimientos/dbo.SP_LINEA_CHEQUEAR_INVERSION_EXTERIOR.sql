USE [MDPasivo]
GO
/****** Object:  StoredProcedure [dbo].[SP_LINEA_CHEQUEAR_INVERSION_EXTERIOR]    Script Date: 16-05-2022 11:18:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_LINEA_CHEQUEAR_INVERSION_EXTERIOR]
            (   @cSistema	CHAR   (03)
            ,   @cProducto	CHAR   (05)
            ,   @nNumoper	NUMERIC(10)
            )
AS
BEGIN



   	SET DATEFORMAT DMY
	SET NOCOUNT ON

   DECLARE @nTotalDisponible	NUMERIC	(19,4)
      ,    @nTotalDisponibleSpo	NUMERIC	(19,4)
      ,    @nTotalDisponibleFwd	NUMERIC	(19,4)
      ,    @nMonto		NUMERIC	(19,4)
      ,    @nRutcli		NUMERIC	(09,0)
      ,    @nCodigo		NUMERIC	(09,0)
      ,    @nPlazo		NUMERIC	(05,0)


   DECLARE CURSOR_INVERSION_EXTERIOR CURSOR 
      READ_ONLY FORWARD_ONLY FOR
      SELECT Rut_Cliente
         ,   Codigo_Cliente
         ,   DATEDIFF(DAY,fechaoperacion,fechavencimiento)
         ,   SUM(MontoTransaccion)
      FROM   LINEA_CHEQUEAR
      WHERE  NumeroOperacion = @nNumoper
        AND  Id_Sistema	     = @cSistema
        AND  Codigo_Producto = @cProducto
      GROUP 
	 BY  Rut_Cliente
         ,   Codigo_Cliente
         ,   DATEDIFF(DAY,fechaoperacion,fechavencimiento)

   OPEN CURSOR_INVERSION_EXTERIOR

   WHILE (1 = 1)
   BEGIN

      FETCH NEXT FROM CURSOR_INVERSION_EXTERIOR
        INTO @nRutcli
         ,   @nCodigo
         ,   @nPlazo
         ,   @nMonto

      IF (@@FETCH_STATUS <> 0)
      BEGIN

         BREAK

      END

      SELECT @nTotalDisponible    = 0
         ,   @nTotalDisponibleSpo = 0
         ,   @nTotalDisponibleFwd = 0

      SELECT @nTotalDisponible	  = InvExt_Disponible
         ,   @nTotalDisponibleSpo = ArbSpo_Disponible
         ,   @nTotalDisponibleFwd = ArbFwd_Disponible
      FROM   INVERSION_EXTERIOR
      WHERE  Rut_Cliente     = @nRutcli
        AND  Codigo_Cliente  = @nCodigo
        AND  Plazo           >= @nPlazo

      IF ISNULL(@nTotalDisponible,0) < @nMonto
         INSERT INTO #TEMP1 SELECT 'OPERACION SOBREPASA LIMITE INVERSION EXTERIOR CLIENTE'

      IF (@cSistema = 'BCC' AND @cProducto = 'ARBI') AND ISNULL(@nTotalDisponibleSpo,0) < @nMonto
         INSERT INTO #TEMP1 SELECT 'OPERACION SOBREPASA LIMITE INVERSION EXTERIOR SPOT CLIENTE'

      IF (@cSistema = 'BFW' AND @cProducto = '1') AND ISNULL(@nTotalDisponibleFwd,0) < @nMonto
         INSERT INTO #TEMP1 SELECT 'OPERACION SOBREPASA LIMITE INVERSION EXTERIOR FORWARD CLIENTE'

   END

   CLOSE CURSOR_INVERSION_EXTERIOR
   DEALLOCATE CURSOR_INVERSION_EXTERIOR

END






GO
