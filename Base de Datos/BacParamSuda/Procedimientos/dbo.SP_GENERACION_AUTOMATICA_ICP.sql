USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_GENERACION_AUTOMATICA_ICP]    Script Date: 13-05-2022 10:53:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_GENERACION_AUTOMATICA_ICP]
AS
BEGIN

   SET NOCOUNT ON

   DECLARE @dFechaHoy           DATETIME -- t0
   ,       @dFechaAyer          DATETIME -- t-1
   ,       @dfechaAnterior      DATETIME -- t-2

   DECLARE @iValorIcpHoy        FLOAT
   ,       @iValorIcpAyer       FLOAT
   ,       @iValorIcpAnterior   FLOAT
   ,       @iValorIpcProyectado FLOAT   

   SELECT  @dFechaHoy         = fechaproc
   ,       @dFechaAyer        = fechaant
   FROM    BacSwapSuda..SWAPGENERAL

   SELECT  @dfechaAnterior    = fechaant
   FROM    BacSwapSuda..SWAPGENERALHIS
   WHERE   fechaproc          = @dFechaAyer

--	select 'debu', '@dfechaAnterior', @dfechaAnterior

   SELECT  @iValorIcpHoy        = ISNULL(vmvalor,0) FROM VALOR_MONEDA WHERE vmfecha = @dFechaHoy      AND vmcodigo = 800
   SELECT  @iValorIcpAyer       = ISNULL(vmvalor,0) FROM VALOR_MONEDA WHERE vmfecha = @dFechaAyer     AND vmcodigo = 800
   SELECT  @iValorIcpAnterior   = ISNULL(vmvalor,0) FROM VALOR_MONEDA WHERE vmfecha = @dfechaAnterior AND vmcodigo = 800

--   IF @iValorIcpHoy = 0 OR @iValorIcpHoy IS NULL
--   BEGIN
--      SELECT -1 , 'Para Hoy No existe valor para el Indice Camara Promedio (ICP) a la fecha: ' + CONVERT(CHAR(10),@dFechaHoy,103)
--      RETURN
--   END
   IF @iValorIcpAyer = 0 OR @iValorIcpAyer IS NULL
   BEGIN
      SELECT -1 , 'No existe valor para el Indice Camara Promedio (ICP) a la fecha: ' + CONVERT(CHAR(10),@dFechaAyer,103)
      RETURN
   END
   IF @iValorIcpAnterior = 0 OR @iValorIcpAnterior IS NULL
   BEGIN
      SELECT -1 , 'No existe valor para el Indice Camara Promedio (ICP) a la fecha: ' + CONVERT(CHAR(10),@dfechaAnterior,103)
      RETURN
   END

--select 'debug', '@iValorIcpAyer', @iValorIcpAyer, '@iValorIcpAnterior', @iValorIcpAnterior

   SELECT  @iValorIpcProyectado = 2.0 * ISNULL(@iValorIcpAyer,0.0) - ISNULL(@iValorIcpAnterior,0.0)

   IF EXISTS(SELECT 1 FROM VALOR_MONEDA WHERE vmfecha = @dFechaHoy AND vmcodigo = 800 AND vmvalor = 0.0 ) 
   -- MAP 20080909 Actualiza solo si es cero
   BEGIN
      UPDATE VALOR_MONEDA
         SET vmvalor = isnull(@iValorIpcProyectado,0.0)
       WHERE vmfecha = @dFechaHoy AND vmcodigo = 800

       PRINT 'Actualización del Valor Ok.'
   END ELSE
   BEGIN
	IF not EXISTS(SELECT 1 FROM VALOR_MONEDA WHERE vmfecha = @dFechaHoy AND vmcodigo = 800 ) 
        -- MAP 20080909 Solo ingresa si no hay registro
        begin
      INSERT INTO VALOR_MONEDA
      (   vmcodigo , vmvalor                          , vmfecha )
      SELECT 800   , isnull(@iValorIpcProyectado,0.0) , @dFechaHoy

       PRINT 'Cargara de Valor Ok.'
   END
   END

   SELECT 0 , 'Generación de Factor Icp, ha finalizado correctamente.'

END





GO
