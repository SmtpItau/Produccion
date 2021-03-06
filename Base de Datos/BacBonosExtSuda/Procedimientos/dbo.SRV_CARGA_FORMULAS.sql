USE [BacBonosExtSuda]
GO
/****** Object:  StoredProcedure [dbo].[SRV_CARGA_FORMULAS]    Script Date: 11-05-2022 16:29:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO


CREATE PROCEDURE [dbo].[SRV_CARGA_FORMULAS]
AS
BEGIN
   SET NOCOUNT ON


   DELETE FROM BacBonosExtSuda..TEXT_VAL_FRM WHERE formula in('DUR_MAC()', 'DUR_MOD()' , 'CONVEXI()')

   DELETE FROM BacBonosExtSuda..TEXT_FRM     WHERE formula in('DUR_MAC()', 'DUR_MOD()' , 'CONVEXI()')

   CREATE TABLE #TMP_CARGA
   (      nemoinstrumento   CHAR(20)
   ,      orden             INTEGER identity NOT FOR REPLICATION
   )

   DECLARE @Familia      NUMERIC(5)
   ,       @Nemo         CHAR(20)
   ,       @FecVcto      DATETIME
   ,       @TipoCalculo  NUMERIC(5)
   ,       @Linea        NUMERIC(5)
   ,       @Variable     CHAR(15)
   ,       @Formula      CHAR(100)
   ,       @TipoFormula  CHAR(1)
   ,       @Parametros1  CHAR(15)
   ,       @Parametros2  CHAR(15)
   ,       @Parametros3  CHAR(15)
   ,       @Parametros4  CHAR(15)
   

   INSERT INTO #TMP_CARGA
      SELECT DISTINCT cod_nemo FROM BacBonosExtSuda..TEXT_VAL_FRM

   DECLARE @iMax    INTEGER
   ,       @iMin    INTEGER

   DECLARE @iLinea1 INTEGER
   ,       @iLinea2 INTEGER
   ,       @iLinea3 INTEGER
   ,       @cNemo   CHAR(20)

   SELECT  @iMax = MAX(orden)
   ,       @iMin = MIN(orden)
   FROM    #TMP_CARGA

   WHILE @iMax >= @iMin
   BEGIN

      SELECT @cNemo        = nemoinstrumento
      FROM   #TMP_CARGA
      WHERE  orden         = @iMin

      SELECT @iLinea1      = MAX(num_linea)
      ,      @Familia      = MAX(cod_familia)
      ,      @FecVcto      = MAX(fecha_vcto)
      FROM   BacBonosExtSuda..TEXT_VAL_FRM
      WHERE  cod_nemo      = @cNemo
      AND    tipo_cal      = 1

      SELECT @iLinea2      = MAX(num_linea)
      FROM   BacBonosExtSuda..TEXT_VAL_FRM
      WHERE  cod_nemo      = @cNemo
      AND    tipo_cal      = 2

      SELECT @iLinea3      = MAX(num_linea)
      FROM   BacBonosExtSuda..TEXT_VAL_FRM
      WHERE  cod_nemo      = @cNemo
      AND    tipo_cal      = 3

      INSERT INTO BacBonosExtSuda..TEXT_VAL_FRM SELECT @Familia , @cNemo , @FecVcto , 1 , @iLinea1 + 1 , 'DUR_MAC' , 'DUR_MAC()' , 'C' , '' , '' , '' , ''
      INSERT INTO BacBonosExtSuda..TEXT_VAL_FRM SELECT @Familia , @cNemo , @FecVcto , 1 , @iLinea1 + 2 , 'DUR_MOD' , 'DUR_MOD()' , 'C' , '' , '' , '' , ''
      INSERT INTO BacBonosExtSuda..TEXT_VAL_FRM SELECT @Familia , @cNemo , @FecVcto , 1 , @iLinea1 + 3 , 'CONVEXI' , 'CONVEXI()' , 'C' , '' , '' , '' , ''

      INSERT INTO BacBonosExtSuda..TEXT_VAL_FRM SELECT @Familia , @cNemo , @FecVcto , 2 , @iLinea2 + 1 , 'DUR_MAC' , 'DUR_MAC()' , 'C' , '' , '' , '' , ''
      INSERT INTO BacBonosExtSuda..TEXT_VAL_FRM SELECT @Familia , @cNemo , @FecVcto , 2 , @iLinea2 + 2 , 'DUR_MOD' , 'DUR_MOD()' , 'C' , '' , '' , '' , ''
      INSERT INTO BacBonosExtSuda..TEXT_VAL_FRM SELECT @Familia , @cNemo , @FecVcto , 2 , @iLinea2 + 3 , 'CONVEXI' , 'CONVEXI()' , 'C' , '' , '' , '' , ''

      INSERT INTO BacBonosExtSuda..TEXT_VAL_FRM SELECT @Familia , @cNemo , @FecVcto , 3 , @iLinea3 + 1 , 'DUR_MAC' , 'DUR_MAC()' , 'C' , '' , '' , '' , ''
      INSERT INTO BacBonosExtSuda..TEXT_VAL_FRM SELECT @Familia , @cNemo , @FecVcto , 3 , @iLinea3 + 2 , 'DUR_MOD' , 'DUR_MOD()' , 'C' , '' , '' , '' , ''
      INSERT INTO BacBonosExtSuda..TEXT_VAL_FRM SELECT @Familia , @cNemo , @FecVcto , 3 , @iLinea3 + 3 , 'CONVEXI' , 'CONVEXI()' , 'C' , '' , '' , '' , ''

      SET @iMin = @iMin + 1       
   END


   DELETE #TMP_CARGA

   INSERT INTO #TMP_CARGA
      SELECT DISTINCT cod_nemo FROM BacBonosExtSuda..TEXT_FRM

   SELECT  @iMax = MAX(orden)
   ,       @iMin = MIN(orden)
   FROM    #TMP_CARGA

   WHILE @iMax >= @iMin
   BEGIN

      SELECT @cNemo        = nemoinstrumento
      FROM   #TMP_CARGA
      WHERE  orden         = @iMin

      SELECT @iLinea1      = MAX(num_linea)
      ,      @Familia      = MAX(cod_familia)
      ,      @FecVcto      = MAX(fecha_vcto)
      FROM   BacBonosExtSuda..TEXT_FRM
      WHERE  cod_nemo      = @cNemo
      AND    tipo_cal      = 1

      SELECT @iLinea2      = MAX(num_linea)
      FROM   BacBonosExtSuda..TEXT_FRM
      WHERE  cod_nemo      = @cNemo
      AND    tipo_cal      = 2

      SELECT @iLinea3      = MAX(num_linea)
      FROM   BacBonosExtSuda..TEXT_FRM
      WHERE  cod_nemo      = @cNemo
      AND    tipo_cal      = 3

      INSERT INTO BacBonosExtSuda..TEXT_FRM SELECT @Familia , @cNemo , @FecVcto , 1 , @iLinea1 + 1 , 'DUR_MAC' , 'DUR_MAC()' , 'C' , '' , '' , '' , ''
      INSERT INTO BacBonosExtSuda..TEXT_FRM SELECT @Familia , @cNemo , @FecVcto , 1 , @iLinea1 + 2 , 'DUR_MOD' , 'DUR_MOD()' , 'C' , '' , '' , '' , ''
      INSERT INTO BacBonosExtSuda..TEXT_FRM SELECT @Familia , @cNemo , @FecVcto , 1 , @iLinea1 + 3 , 'CONVEXI' , 'CONVEXI()' , 'C' , '' , '' , '' , ''

      INSERT INTO BacBonosExtSuda..TEXT_FRM SELECT @Familia , @cNemo , @FecVcto , 2 , @iLinea2 + 1 , 'DUR_MAC' , 'DUR_MAC()' , 'C' , '' , '' , '' , ''
      INSERT INTO BacBonosExtSuda..TEXT_FRM SELECT @Familia , @cNemo , @FecVcto , 2 , @iLinea2 + 2 , 'DUR_MOD' , 'DUR_MOD()' , 'C' , '' , '' , '' , ''
      INSERT INTO BacBonosExtSuda..TEXT_FRM SELECT @Familia , @cNemo , @FecVcto , 2 , @iLinea2 + 3 , 'CONVEXI' , 'CONVEXI()' , 'C' , '' , '' , '' , ''

      INSERT INTO BacBonosExtSuda..TEXT_FRM SELECT @Familia , @cNemo , @FecVcto , 3 , @iLinea3 + 1 , 'DUR_MAC' , 'DUR_MAC()' , 'C' , '' , '' , '' , ''
      INSERT INTO BacBonosExtSuda..TEXT_FRM SELECT @Familia , @cNemo , @FecVcto , 3 , @iLinea3 + 2 , 'DUR_MOD' , 'DUR_MOD()' , 'C' , '' , '' , '' , ''
      INSERT INTO BacBonosExtSuda..TEXT_FRM SELECT @Familia , @cNemo , @FecVcto , 3 , @iLinea3 + 3 , 'CONVEXI' , 'CONVEXI()' , 'C' , '' , '' , '' , ''

      SET @iMin = @iMin + 1       
   END

   SELECT '<< Proceso finalizado OK >>'

   SELECT * FROM BacBonosExtSuda..TEXT_VAL_FRM WHERE formula in('DUR_MAC()', 'DUR_MOD()' , 'CONVEXI()') ORDER BY cod_nemo , num_linea
   SELECT * FROM BacBonosExtSuda..TEXT_FRM     WHERE formula in('DUR_MAC()', 'DUR_MOD()' , 'CONVEXI()') ORDER BY cod_nemo , num_linea

   DROP TABLE #TMP_CARGA
  
END

GO
