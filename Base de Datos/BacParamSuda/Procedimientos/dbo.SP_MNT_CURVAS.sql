USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_MNT_CURVAS]    Script Date: 13-05-2022 10:53:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_MNT_CURVAS]
   (   @iAccion     INTEGER
   ,   @dFecha      DATETIME    = ''
   ,   @cCurva      VARCHAR(20) = ''
   ,   @iDias       NUMERIC(9)  = 0
   ,   @fValorBid   FLOAT       = 0.0
   ,   @fValorAsk   FLOAT       = 0.0
   ,   @TipoCurva   VARCHAR(5)  = ''
   ,   @OrigenCurva CHAR(2)     = ''
   )
AS
BEGIN
   -- MAP 20080513 Se modifica filtro de exitencia en tabla CURVAS_PRODUCTO, una curva 
   -- estará asociada a un producto como curva y como curva alternativa.
   SET NOCOUNT ON
   DECLARE @Modulo   CHAR(3)

   IF @iAccion = 0 --> Consulta Curvas
   BEGIN
      SELECT CodigoCurva, Descripcion, TipoCurva FROM DEFINICION_CURVAS ORDER BY CodigoCurva
   END

   IF @iAccion = 1 --> Consulta
   BEGIN
      SELECT FechaGeneracion
      ,      CodigoCurva
      ,      Dias
      ,      ValorBid
      ,      ValorAsk
      ,      Tipo
      ,      Origen
      FROM   CURVAS
      WHERE  FechaGeneracion = @dFecha
      AND    CodigoCurva     = @cCurva
   END

   IF @iAccion = 2 --> Eliminacion
   BEGIN
      DELETE FROM CURVAS 
            WHERE FechaGeneracion = @dFecha 
              AND CodigoCurva     = @cCurva
   END

   IF @iAccion = 3 --> Grabacion
   BEGIN
      IF NOT EXISTS(SELECT 1 FROM CURVAS WHERE FechaGeneracion = @dFecha AND CodigoCurva = @cCurva AND Dias = @iDias AND tipo = @TipoCurva AND origen = @OrigenCurva)
      BEGIN
         INSERT INTO CURVAS 
         SELECT @dFecha 
         ,      @cCurva 
         ,      @iDias 
         ,      @fValorBid 
         ,      @fValorAsk
         ,      @TipoCurva
         ,      @OrigenCurva
      END
   END

   IF @iAccion = 4 --> Consulta Existencia Curva
   BEGIN
      DELETE FROM  CURVAS 
             WHERE FechaGeneracion = @dFecha

      IF EXISTS(SELECT 1 FROM CURVAS WHERE FechaGeneracion = @dFecha)
      BEGIN
         SELECT -1 , 'Ya existen curvas creadas con fecha ' + CONVERT(CHAR(10),@dFecha,103)
         RETURN
      END
      SELECT 0 , 'Curvas listas para crear.'
   END

   IF @iAccion = 5 --> Consulta Existencia Curva
   BEGIN
      IF NOT EXISTS( SELECT 1 FROM DEFINICION_CURVAS WHERE CodigoCurva = @cCurva )
      BEGIN
         SELECT -1 , 'Curva ' + @cCurva + ' ... No se encuentra definida en el sistema.'
         RETURN
      END
      SELECT 0 , 'Curva se encuentra creada.'
   END


   IF @iAccion = 6 --> Grabacion
   BEGIN
      SET @Modulo   = ISNULL((SELECT DISTINCT Modulo FROM BacParamSuda..CURVAS_PRODUCTO WHERE (CodigoCurva = @cCurva or CurAlter = @cCurva) and Modulo = 'PCS'  ),'')

      IF @Modulo <> 'PCS'
         SET @TipoCurva = ''

      IF EXISTS(SELECT 1 FROM CURVAS WHERE FechaGeneracion = @dFecha AND CodigoCurva = @cCurva AND Dias = @iDias AND tipo = @TipoCurva AND origen = @OrigenCurva)
      BEGIN
         DELETE 
         FROM   CURVAS 
         WHERE  FechaGeneracion = @dFecha 
         AND    CodigoCurva     = @cCurva 
         AND    Dias            = @iDias
         AND    tipo            = @TipoCurva 
         AND    origen          = @OrigenCurva
      END

      INSERT INTO CURVAS
      SELECT @dFecha , @cCurva , @iDias , @fValorBid , @fValorAsk, @TipoCurva, @OrigenCurva
   END

   IF @iAccion = 7 --> Validación Pre-Grabacion para el Tipo y Origen de Curvas
   BEGIN
      IF @OrigenCurva = ''
      BEGIN
         SELECT -1 , 'El Origen de las Curvas es Obligatorio. Favor Regularizar Antes de Cargar.'
         RETURN
      END

      SET @Modulo   = (SELECT DISTINCT Modulo FROM BacParamSuda..CURVAS_PRODUCTO WHERE (CodigoCurva = @cCurva or CurAlter = @cCurva) and Modulo = 'PCS' )

      IF @Modulo = 'PCS' AND LTRIM(RTRIM(@TipoCurva)) = ' '
      BEGIN
         SELECT -2, 'Existen Curvas Asociadas a Swap. Que no Tienen definido el Tipo. Favor Regularizar.'
         RETURN
      END ELSE
      BEGIN
         SET @TipoCurva = ''
      END

      SELECT 0, 'Validación OK.'
   END

END

GO
