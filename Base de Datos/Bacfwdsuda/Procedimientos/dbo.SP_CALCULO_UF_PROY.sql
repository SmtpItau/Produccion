USE [Bacfwdsuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_CALCULO_UF_PROY]    Script Date: 13-05-2022 10:30:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO


CREATE PROCEDURE [dbo].[SP_CALCULO_UF_PROY]
   (   @dFechaParidad   DATETIME
   ,   @cTipoOperacion  CHAR(1)
   ,   @nTasaMon        FLOAT		= 0.0
   ,   @nTasaCnv        FLOAT		= 0.0
   ,   @dFechaProc		DATETIME	= '19000101'
   )
AS
BEGIN

   SET NOCOUNT ON

--   DECLARE @dFechaProc    DATETIME
   IF CONVERT(CHAR(8),@dFechaProc,112) = '19000101' BEGIN
	   SET     @dFechaProc    = ( SELECT acfecproc FROM BacFwdSuda..MFAC WHERE acrutprop = 97023000 )
   END

   DECLARE @nValorUf      FLOAT
   SET     @nValorUf      = ( SELECT vmvalor   FROM BacParamSuda..VALOR_MONEDA WHERE vmfecha = @dFechaProc AND vmcodigo = 998 )

   DECLARE @vValorUf      FLOAT
   SET     @vValorUf      = 0.0

   DECLARE @iProducto     INT
   SET     @iProducto     = 3

   DECLARE @iBase_Clp     FLOAT
   SET     @iBase_Clp     = 360

   DECLARE @iBase_Uf      FLOAT
   SET     @iBase_Uf      = 360

   DECLARE @iPlazo        INT
--   SET     @iPlazo        = DATEDIFF(DAY, @dFechaParidad, @dFechaProc ) GLCF
   SET     @iPlazo        = DATEDIFF(DAY, @dFechaProc,@dFechaParidad )

   CREATE TABLE #Tasa_Moneda_Bfw   --NEW
   (   Tasa           	FLOAT   NOT NULL DEFAULT(0.0)
   ,   Spread         	FLOAT   NOT NULL DEFAULT(0.0)
   ,   SpotCompra   	FLOAT   NOT NULL DEFAULT(0.0)
   ,   SpotVenta      	FLOAT   NOT NULL DEFAULT(0.0)
   )
   CREATE INDEX #ix_Tasa_Moneda_Bfw ON #Tasa_Moneda_Bfw (Tasa)


   --> Lee Tasa para los Pesos (999)
   DECLARE @nTasa_Clp   FLOAT
   SET     @nTasa_Clp   = 0.0

   TRUNCATE TABLE #Tasa_Moneda_Bfw
   INSERT INTO #Tasa_Moneda_Bfw
      EXECUTE SP_RetornaTasaMoneda 999 , @iPlazo , 'BFW' , @iProducto, -1, -1, 0, @cTipoOperacion

   IF @nTasaCnv = 0.0
   BEGIN
      SET @nTasa_Clp = ISNULL((SELECT Tasa FROM #Tasa_Moneda_Bfw ),1.0)
   END ELSE
   BEGIN
      SET @nTasa_Clp = @nTasaCnv
   END

   --> Lee Tasa para los Unidad Fomento (998)
   DECLARE @nTasa_Uf    FLOAT
   SET     @nTasa_Uf    = 0.0

   TRUNCATE TABLE #Tasa_Moneda_Bfw
   INSERT INTO #Tasa_Moneda_Bfw
      EXECUTE SP_RetornaTasaMoneda 998 , @iPlazo , 'BFW' , @iProducto, -1, -1, 0, @cTipoOperacion

   IF @nTasaMon = 0.0
   BEGIN
      SET @nTasa_Uf = ISNULL(( SELECT Tasa FROM #Tasa_Moneda_Bfw ),1.0)
   END ELSE
   BEGIN
      SET @nTasa_Uf = @nTasaMon
   END

   --> Genera Calculo
   DECLARE @Pi_K   FLOAT

   SET     @Pi_K   = ROUND((POWER( 1.0 + @nTasa_Clp / 100.0, (@iPlazo / @iBase_Clp))
                    / POWER( 1.0 + @nTasa_Uf  / 100.0, (@iPlazo / @iBase_Uf) )) * @nValorUf,4)

--   SET     @vValorUf = ROUND(@nValorUf * ( @Pi_K ),10)
	 SET     @vValorUf = @Pi_K 

   SELECT '@vValorUf' = CONVERT(NUMERIC(21,4),@vValorUf)

END

GO
