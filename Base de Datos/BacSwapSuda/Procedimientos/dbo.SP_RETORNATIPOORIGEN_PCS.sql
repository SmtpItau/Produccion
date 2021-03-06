USE [BacSwapSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_RETORNATIPOORIGEN_PCS]    Script Date: 13-05-2022 11:02:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_RETORNATIPOORIGEN_PCS]  
   (   @Modulo          CHAR(3)    --> PCS
   ,   @Producto        VARCHAR(5) --> [SM, ST, SP, FR]
   ,   @Moneda          INTEGER    --> [999, 13, 998 ...]
   ,   @TipoTasa        INTEGER    --> [0 = Fija; 1 = Variable]
   ,   @TipoBase        INTEGER    --> [1,2,3,4,5]
   ,   @Indicador       INTEGER    --> [0, 3, 5, 6, 7, 8, 9, 10, 13, 14, 15]
   ,   @Plazo           NUMERIC(9) --> Plazo
   ,   @FechaProceso    DATETIME   --> Fecha de Proceso
   ,   @ValorCurva      FLOAT      --> Valor Curva Retornada en proceso RetornaTasaMoneda
   ,   @TipoFlujo       INTEGER    --> [1 = Entregamos, 2, Recibimos]
   ,   @OrigenCurva     CHAR(2)    OUTPUT
   )
AS
BEGIN

   SET NOCOUNT ON

       SET @OrigenCurva = 'MC'

   DECLARE @cTipoTasa   CHAR(1)
       SET @cTipoTasa   = CASE WHEN @TipoTasa = 0  THEN 'F'
                               WHEN @TipoTasa = 1  THEN 'V'
                          END
   DECLARE @iBidAsk     INTEGER
       SET @iBidAsk     = CASE WHEN @TipoFlujo = 1 AND @cTipoTasa = 'F' THEN 1
                               WHEN @TipoFlujo = 1 AND @cTipoTasa = 'V' THEN 2
                               WHEN @TipoFlujo = 2 AND @cTipoTasa = 'V' THEN 1
                               WHEN @TipoFlujo = 2 AND @cTipoTasa = 'F' THEN 2
                          END


   DECLARE @CodigoCurva    VARCHAR(20)
   SELECT  @CodigoCurva    = CodigoCurva
     FROM  BacParamSuda..CURVAS_PRODUCTO 
    WHERE  Modulo          = @Modulo
      AND  Producto        = @Producto
      AND  Moneda          = @Moneda
      AND  @cTipoTasa      = CASE WHEN @Producto = 'SM' THEN TipoTasa ELSE @cTipoTasa END
      AND  Indicador       = @Indicador

   IF @CodigoCurva = ''
   BEGIN
      RETURN
   END

   SELECT  @OrigenCurva    = Origen 
     FROM  BacParamSuda..CURVAS
    WHERE  FechaGeneracion = @FechaProceso
     AND   CodigoCurva     = @CodigoCurva
     AND   Dias            = @Plazo

END
GO
