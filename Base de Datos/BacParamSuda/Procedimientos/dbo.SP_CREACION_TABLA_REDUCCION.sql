USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_CREACION_TABLA_REDUCCION]    Script Date: 13-05-2022 10:53:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_CREACION_TABLA_REDUCCION]
   (   @Modulo           CHAR(3)
   ,   @Producto         INTEGER
   ,   @Contrato         NUMERIC(9)
   ,   @iSegmento        INTEGER
   ,   @nREC             FLOAT
   ,   @cClasificacion   VARCHAR(6)
   )
AS
BEGIN
   
   SET NOCOUNT ON

   -->     Monto Final Threshold
   DECLARE @xThreshold     FLOAT
       SET @xThreshold     = 0.0

   -->     Identifica el Codigo Asociado a la clasificacion de riesgo
   DECLARE @iClasifica     INTEGER
       SET @iClasifica     = -1
    SELECT @iClasifica     = ( SELECT tbtasa FROM BacParamSuda.dbo.TABLA_GENERAL_DETALLE with(nolock)
                                            WHERE tbcateg   = 103
                                              AND tbcodigo1 = @cClasificacion )

   -->     Para controlar existencia de Registros
   DECLARE @iFound         INTEGER
       SET @iFound         = -1

   -->     Se encontro tabla de Reduccion para el Segmento
   SELECT  @iFound         = 1
   FROM    BacParamSuda.dbo.TBL_TABLAS_DE_REDUCCION with(nolock)
   WHERE   Segmento        = @iSegmento

   -->     Si no existe tabla de reduccion para el Segmento asociado al Cliente se aborta el proceso
   IF @iFound = -1
   BEGIN
      RETURN
   END

   DELETE FROM TBL_REDUCCION_THRESHOLD
         WHERE Sistema          = @Modulo
           AND Producto         = @Producto
           AND Numero_Operacion = @Contrato
           AND Segmento         = @iSegmento

   -->     Se crea la tabla de reduccion en base a la Definicion aportada por el mantenedor
   INSERT INTO TBL_REDUCCION_THRESHOLD
   SELECT Sistema          = @Modulo
   ,      Producto         = @Producto
   ,      Numero_Operacion = @Contrato
   ,      Segmento         = Segmento
   ,      Clasificacion    = Nacional
   ,      Descripcion      = tbcodigo1
   ,      Threshold        = CASE WHEN (@nREC * (Porcentaje / 100.0)) > Monto THEN Monto
                                  ELSE                                             (@nREC * (Porcentaje / 100.0))
                             END
   ,      PosicionInical   = CASE WHEN Nacional = @iClasifica THEN 1 ELSE 0 END
   ,      PosicionActual   = CASE WHEN Nacional = @iClasifica THEN 1 ELSE 0 END
   FROM   BacParamSuda.dbo.TBL_TABLAS_DE_REDUCCION          with(nolock)
          INNER JOIN BacParamSuda.dbo.TABLA_GENERAL_DETALLE with(nolock) ON tbcateg = 103 and tbtasa = Nacional
   WHERE  Segmento         = @iSegmento

END
GO
