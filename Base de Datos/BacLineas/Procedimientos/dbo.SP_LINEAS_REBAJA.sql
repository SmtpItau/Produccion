USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[SP_LINEAS_REBAJA]    Script Date: 13-05-2022 10:37:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO


CREATE PROCEDURE [dbo].[SP_LINEAS_REBAJA]
   (   @dFecPro    DATETIME
   ,   @cSistema   CHAR(03)
   ,   @nNumoper   NUMERIC(10,0)
   ,   @nNumdocu   NUMERIC(10,0)
   ,   @nCorrela   NUMERIC(03,0)
   ,   @nFactor    FLOAT
   ,   @Incodigo   NUMERIC(5)   = 0 --> Incodigo
   )
AS
BEGIN

   SET NOCOUNT ON


   DECLARE @Contador             INTEGER
      ,    @sw                   CHAR(1)

   DECLARE @ctranssaccion        CHAR(15)
      ,    @ctipo_detalle        CHAR(1)
      ,    @cactualizo_linea     CHAR(1)
      ,    @nmontotransaccion    NUMERIC(19,4)
      ,    @ctipo_movimiento     CHAR(1)
      ,    @nrutcli              NUMERIC(09,0)
      ,    @ncodigo              NUMERIC(09,0)
      ,    @nplazodesde          NUMERIC(09,0)
      ,    @nplazohasta          NUMERIC(09,0)
      ,    @csistematras         CHAR(03)
      ,    @nmonto               NUMERIC(19,4)
      ,    @dfecvctop            DATETIME
      ,    @ccontrolaplazo       CHAR(01)
      ,    @nRutcasamatriz       NUMERIC(09,0)
      ,    @nCodigocasamatriz    NUMERIC(09,0)
      ,    @producto		 CHAR(5)
      ,    @GrpEmi		 CHAR(01)
      ,    @nMtoGrp		 FLOAT

   DECLARE cursor_Rev            SCROLL CURSOR FOR
   SELECT  Linea_Transsaccion 
      ,    NumeroCorre_Detalle 
      ,    Tipo_Detalle  
      ,    Actualizo_Linea  
      ,    MontoTransaccion 
      ,    Tipo_Movimiento  
      ,    Rut_Cliente  
      ,    Codigo_Cliente  
      ,    PlazoDesde  
      ,    PlazoHasta	
      ,    Codigo_Producto
      ,    Grupo_Emisor
   FROM    LINEA_TRANSACCION_DETALLE
   WHERE   Id_Sistema         = @cSistema
   AND     NumeroOperacion    = @nNumoper
   AND     NumeroDocumento    = @nNumdocu
   AND    (NumeroCorrelativo  = @nCorrela OR @nCorrela = 0)

   OPEN cursor_Rev 

   WHILE (1=1)
   BEGIN
      FETCH NEXT FROM cursor_Rev 
      INTO @cTranssaccion
      ,    @Contador
      ,    @cTipo_Detalle
      ,    @cActualizo_Linea
      ,    @nMontoTransaccion
      ,    @cTipo_Movimiento
      ,    @nRutcli
      ,    @nCodigo
      ,    @nPlazoDesde
      ,    @nPlazoHasta
      ,    @producto
      ,    @GrpEmi

      IF (@@FETCH_STATUS <> 0)
      BEGIN
         BREAK
      END

      IF @cTipo_Movimiento = 'S'
         SET @nMontoTransaccion = @nMontoTransaccion * (-1)

      SET @nMontoTransaccion    = @nMontoTransaccion * @nFactor

      IF @cTipo_Detalle = 'L' AND @cActualizo_Linea = 'S'
      BEGIN

         IF @cSistema = 'BEX' 
         BEGIN
            SET @producto = CASE WHEN @producto = 'CP' THEN 'CPX'
                                 WHEN @producto = 'VP' THEN 'VPX'
                                 ELSE                       @producto
                            END
         END

         IF @cTranssaccion = 'LINGEN'
         BEGIN
            UPDATE LINEA_GENERAL
               SET totalocupado   = totalocupado  + @nMontoTransaccion
             WHERE rut_cliente    = @nRutcli
               AND codigo_cliente = @nCodigo
         END

         IF @cTranssaccion = 'LINSIS'
         BEGIN
            UPDATE LINEA_SISTEMA
               SET totalocupado   = totalocupado  + @nMontoTransaccion
             WHERE rut_cliente    = @nRutcli
               AND codigo_cliente = @nCodigo
               AND id_sistema     = @cSistema
         END

         IF @cTranssaccion = 'LINPZO'
         BEGIN
            UPDATE LINEA_PRODUCTO_POR_PLAZO
               SET totalocupado    = totalocupado  + @nMontoTransaccion
             WHERE rut_cliente     = @nRutcli
               AND codigo_cliente  = @nCodigo
               AND id_sistema      = @cSistema
               AND codigo_producto = @producto
               AND incodigo        = @Incodigo
               AND @nPlazoDesde    BETWEEN plazodesde and plazohasta
         END

      END
   END

   CLOSE cursor_rev

   DEALLOCATE cursor_rev

   SET    @nMtoGrp            = 0
   SELECT @nMtoGrp            = ((MontoTransaccion* @nFactor)*-1)
   FROM   LINEA_TRANSACCION_DETALLE 
   WHERE  Id_Sistema          = @cSistema
   AND    NumeroOperacion     = @nNumoper
   AND    NumeroDocumento     = @nNumdocu							
   AND    NumeroCorrelativo   = @nCorrela
   AND    Linea_Transsaccion  = 'LINGRP'

   UPDATE POSICION_GRUPO
      SET totalocupado        = totalocupado  + @nMtoGrp
     FROM LINEA_TRANSACCION_DETALLE 
    WHERE Id_Sistema          = @cSistema
      AND NumeroOperacion     = @nNumoper
      AND NumeroDocumento     = @nNumdocu							
      AND NumeroCorrelativo   = @nCorrela
      AND Linea_Transsaccion  = 'LINGRP'
      AND LINEA_TRANSACCION_DETALLE.Grupo_Emisor = POSICION_GRUPO.Codigo_Grupo

   UPDATE LINEA_TRANSACCION
      SET MontoTransaccion    = MontoTransaccion - (MontoTransaccion * @nFactor)
      ,   MontoOriginal       = MontoOriginal    - (MontoTransaccion * @nFactor)
    WHERE Id_Sistema          = @cSistema
      AND NumeroOperacion     = @nNumoper
      AND NumeroDocumento     = @nNumdocu
      AND NumeroCorrelativo   = @nCorrela

   UPDATE LINEA_TRANSACCION_DETALLE
      SET MontoTransaccion    = MontoTransaccion - (MontoTransaccion * @nFactor)
    WHERE Id_Sistema          = @cSistema
      AND NumeroOperacion     = @nNumoper
      AND NumeroDocumento     = @nNumdocu
      AND NumeroCorrelativo   = @nCorrela
      AND Linea_Transsaccion <> 'LINGRP'

   UPDATE LINEA_TRANSACCION_DETALLE
      SET MontoTransaccion    = MontoTransaccion - (MontoTransaccion * @nFactor)
    WHERE Id_Sistema          = @cSistema
      AND NumeroOperacion     = @nNumoper
      AND NumeroDocumento     = @nNumdocu
      AND NumeroCorrelativo   = 0
      AND Linea_Transsaccion  = 'LINGRP'

   EXECUTE SP_LINEAS_ACTUALIZA

END
GO
