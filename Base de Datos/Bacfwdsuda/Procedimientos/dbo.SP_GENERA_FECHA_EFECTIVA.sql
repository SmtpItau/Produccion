USE [Bacfwdsuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_GENERA_FECHA_EFECTIVA]    Script Date: 13-05-2022 10:30:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_GENERA_FECHA_EFECTIVA]
   (   @Producto        INTEGER 
   ,   @Modalidad       CHAR(1)
   ,   @RefMercado      INTEGER
   ,   @FechaVcto       DATETIME
   ,   @FechaEfectiva   DATETIME   OUTPUT
   )
AS
BEGIN

   SET NOCOUNT ON

   IF @RefMercado = 0
   BEGIN
      IF @Producto = 1
         SET @RefMercado = 1
      IF @Producto = 2
         SET @RefMercado = 6
   END

   DECLARE @cMensaje      CHAR(2)
   DECLARE @nContador     NUMERIC(5)
       SET @nContador     = 1
       SET @FechaEfectiva = @FechaVcto

   DECLARE @nDiasValor    NUMERIC(5)
       SET @nDiasValor    = ISNULL((SELECT DiasValor FROM BacParamSuda..REFERENCIA_MERCADO_PRODUCTO 
                                                    WHERE Producto    = @Producto
                                                      AND Modalidad   = @Modalidad
                                                      AND Referencia  = @RefMercado), 0)
   IF @nDiasValor = 0
   BEGIN 
      RETURN
   END

   WHILE ABS(@nDiasValor) >= @nContador
   BEGIN
      SET @FechaEfectiva = DATEADD(DAY, -1, @FechaEfectiva)

      WHILE (1 = 1)
      BEGIN
         EXECUTE BacParamSuda..SP_DETECTA_FECHA_HABIL_INHABIL @FechaEfectiva, @cMensaje OUTPUT
         IF @cMensaje = 'SI'   
            BREAK
         SET @FechaEfectiva = DATEADD(DAY, -1, @FechaEfectiva)
      END 

      SET @nContador = @nContador + 1
   END

   SET @FechaEfectiva = @FechaEfectiva

END
GO
