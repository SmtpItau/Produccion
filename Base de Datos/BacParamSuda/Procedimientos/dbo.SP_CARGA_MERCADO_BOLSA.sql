USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_CARGA_MERCADO_BOLSA]    Script Date: 13-05-2022 10:53:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_CARGA_MERCADO_BOLSA]
   (   @iAction      INTEGER
   ,   @dFecha       DATETIME
   ,   @cModulo      CHAR(3)       = ''
   ,   @cEmisor      VARCHAR(10)   = ''
   ,   @cInstrumento VARCHAR(15)   = ''
   ,   @iTasa        FLOAT         = 0.0
   ,   @nMonto       NUMERIC(21,4) = 0.0
   )
AS
BEGIN

   SET NOCOUNT ON

   IF @iAction = 1
   BEGIN
      DELETE FROM TASA_MERCADO_BOLSA 
            WHERE Fecha = @dFecha AND Modulo = @cModulo
   END

   IF @iAction = 2
   BEGIN
      INSERT INTO TASA_MERCADO_BOLSA
      SELECT @dFecha, @cModulo, @cEmisor, @cInstrumento, @iTasa, @nMonto
   END

   IF @iAction = 3
   BEGIN
      SELECT Fecha
      ,      Modulo
      ,      Emisor
      ,      Instrumento
      ,      TasaPromedioPonderado = SUM(Tasa * Monto) / SUM(Monto)
      ,      Monto                 = SUM(Monto)
      INTO   #TMP_PASO_PROMEDIO
      FROM   TASA_MERCADO_BOLSA
      WHERE  Fecha  = @dFecha
      GROUP BY Fecha, Modulo, Emisor, Instrumento

      DELETE FROM TASA_MERCADO_BOLSA 
            WHERE Fecha = @dFecha

      INSERT INTO TASA_MERCADO_BOLSA 
             SELECT * FROM #TMP_PASO_PROMEDIO
   END

   IF @iAction = 4
   BEGIN
      DECLARE @iContador   INTEGER
      SET     @iContador   = isnull((SELECT COUNT(1) FROM TASA_MERCADO_BOLSA WHERE Fecha = @dFecha AND Modulo = @cModulo),0)
   
      SELECT Emisor, Instrumento, Tasa, Monto, @iContador AS nRegistros
      FROM   TASA_MERCADO_BOLSA
      WHERE  Fecha = @dFecha 
      AND    Modulo = @cModulo   
   END

END

GO
