USE [BacCamSuda]
GO
/****** Object:  StoredProcedure [dbo].[CAL_RESUMENMONEDAS]    Script Date: 11-05-2022 16:43:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[CAL_RESUMENMONEDAS]
AS
BEGIN

   SET NOCOUNT ON

   DECLARE @dFechaProceso	DATETIME
   DECLARE @dFechaAnterior 	DATETIME;
	
   CREATE TABLE #Tempzx
   (   Fecha  		DATETIME	,
       Moneda		VARCHAR(03)	,
       Codigo		SMALLINT	,
       Monto		FLOAT		
   )

   SET @dFechaProceso  = (SELECT acfecpro FROM meac with(nolock) );
   SET @dFechaAnterior = (SELECT acfecant FROM meac with(nolock) );

   DELETE FROM TBL_RESUMEN 
         WHERE fecha = @dFechaProceso;

   INSERT INTO #TEMPZX
   (      Fecha
   ,      Moneda
   ,      Codigo
   ,      Monto
   )
   SELECT 'Fecha'    = mofech
   ,      'Moneda'   = mocodmon
   ,      'Codigo'   = Tabla.tbcodigo1
   ,      'monto'    = CASE WHEN motipope = 'C' THEN momonmo  
                            WHEN motipope = 'V' THEN momonmo * -1 
                            ELSE 0 
                       END
   FROM   BacCamSuda.dbo.MEMO with(nolock)
          LEFT JOIN BacParamSuda.dbo.TABLA_GENERAL_DETALLE Tabla ON Tabla.tbcateg = 2700 AND LTRIM(RTRIM( Tabla.nemo )) = LTRIM(RTRIM( moterm ))
   WHERE  moestatus <> 'A'

  
   INSERT INTO #TEMPZX
   (      Fecha
   ,      Moneda
   ,      Codigo
   ,      monto
   )
   SELECT 'Fecha'    = mofech
   ,      'Moneda'   = mocodcnv
   ,      'Codigo'   = Tabla.tbcodigo1
   ,      'monto'    = CASE WHEN motipope = 'C' THEN moussme *-1  
                            WHEN motipope = 'V' THEN moussme
                            ELSE 0 
                       END
   FROM   BacCamSuda.dbo.MEMO with(nolock)
          LEFT JOIN BacParamSuda.dbo.TABLA_GENERAL_DETALLE Tabla ON Tabla.tbcateg = 2700 AND LTRIM(RTRIM( Tabla.nemo )) = LTRIM(RTRIM( moterm ))
   WHERE  mocodcnv  <>'CLP'
   AND    moestatus <> 'A' 


   INSERT INTO #TEMPZX
   (      Fecha
   ,      Moneda
   ,      Codigo
   ,      monto
   )
   SELECT 'Fecha'    = @dFechaProceso
   ,      'Moneda'   = Moneda
   ,      'Codigo'   = CodigoOrigen
   ,      'monto'    = 0
   FROM   BacCamSuda.dbo.TBL_RESUMEN 
   WHERE  Fecha      = @dFechaAnterior


   INSERT INTO TBL_RESUMEN
   (      Fecha
   ,      Moneda
   ,      CodigoOrigen
   ,      Saldo_Inicial
   ,      OperadoDia
   ,      Saldo
   )
   SELECT 'Fecha'        = Fecha
   ,      'Moneda'       = Moneda
   ,      'CodigoOrigen' = codigo
   ,      'SaldoInicial' = 0
   ,      'OperadoDia'   = SUM( monto )
   ,      'Saldo'        = 0
   FROM	  #TEMPZX 
   GROUP BY Fecha, Moneda, Codigo

   /* Actualizacion del Saldo del Dia Anterior */
   UPDATE TBL_RESUMEN
      SET TBL_RESUMEN.Saldo_Inicial = ( DatosAyer.Saldo_Inicial + DatosAyer.OperadoDia ) 
     FROM TBL_RESUMEN (noLock)
          INNER JOIN (SELECT * FROM TBL_RESUMEN (noLock) WHERE fecha = @dFechaAnterior) DatosAyer ON DatosAyer.moneda       = tbl_resumen.moneda 
	                                                                                         AND DatosAyer.CodigoOrigen = tbl_resumen.CodigoOrigen
   WHERE tbl_resumen.fecha = @dFechaProceso

   UPDATE TBL_RESUMEN
      SET TBL_RESUMEN.Saldo = Saldo_Inicial+OperadoDia
    WHERE TBL_RESUMEN.fecha = @dFechaProceso




   --------------------------------------------------------------
   CREATE TABLE #TMP_DATOS
   (   Fecha        DATETIME
   ,   Moneda       CHAR(3)
   ,   Origen       INTEGER
   ,   MtoCompras   FLOAT
   ,   PromTCComp   FLOAT
   ,   MtoVentas    FLOAT
   ,   PromTCVtas   FLOAT
   ,   Puntero      INTEGER   IDENTITY (1,1)
   )

   INSERT INTO #TMP_DATOS
   EXECUTE dbo.SP_RESULTADO_POSICION @dFechaProceso
   
   DECLARE @nContador   NUMERIC(9)
       SET @nContador   = 1
   DECLARE @nRegistros  NUMERIC(9)
       SET @nRegistros  = ( SELECT MAX(Puntero) FROM #TMP_DATOS )
   
   DECLARE @dFecha      DATETIME
   DECLARE @xMoneda     CHAR(3)
   DECLARE @nOrigen     INTEGER
   DECLARE @nMtoComp    FLOAT
   DECLARE @nPromComp   FLOAT
   DECLARE @nMtoVen     FLOAT
   DECLARE @nPromVta    FLOAT

   WHILE @nRegistros >= @nContador
   BEGIN
      SELECT @dFecha      = Fecha
      ,      @xMoneda     = Moneda
      ,      @nOrigen     = Origen
      ,      @nMtoComp    = MtoCompras
      ,      @nPromComp   = PromTCComp
      ,      @nMtoVen     = MtoVentas
      ,      @nPromVta    = PromTCVtas
      FROM   #TMP_DATOS
      WHERE  @nContador   = Puntero

      IF NOT EXISTS( SELECT 1 FROM BacCamSuda.dbo.TBL_RESUMEN WHERE Fecha = @dFecha and Moneda = @xMoneda and CodigoOrigen = @nOrigen )
      BEGIN

         INSERT INTO BacCamSuda.dbo.TBL_RESUMEN
         SELECT @dFecha
         ,      @xMoneda
         ,      @nOrigen
         ,      0.0
         ,      0.0
         ,      0.0
         ,      @nMtoComp
         ,      @nPromComp
         ,      @nMtoVen
         ,      @nPromVta
         
      END ELSE
      BEGIN
         UPDATE BacCamSuda.dbo.TBL_RESUMEN
            SET MontoCompra  = @nMtoComp
            ,   TCPondCompra = @nPromComp
            ,   MontoVenta   = @nMtoVen
            ,   TCPondventa  = @nPromVta
          WHERE Fecha        = @dFecha 
            and Moneda       = @xMoneda 
            and CodigoOrigen = @nOrigen 
      END

      SET    @nContador = @nContador + 1
   END
   --------------------------------------------------------------

   SET NOCOUNT OFF

   DROP TABLE #Tempzx

END

GO
