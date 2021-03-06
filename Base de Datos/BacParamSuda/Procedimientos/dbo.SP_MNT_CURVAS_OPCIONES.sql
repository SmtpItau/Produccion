USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_MNT_CURVAS_OPCIONES]    Script Date: 13-05-2022 10:53:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_MNT_CURVAS_OPCIONES]
   (   @iAccion     INTEGER
   ,   @dFecha      DATETIME    = ''
   ,   @cParMda     VARCHAR(07) = ''
   ,   @cEstructura VARCHAR(10) = ''
   ,   @nDelta      NUMERIC(05) = 0
   ,   @iDias       NUMERIC(9)  = 0
   ,   @fValorBid   FLOAT       = 0.0
   ,   @fValorAsk   FLOAT       = 0.0
   ,   @fMid        FLOAT       = 0.0

   )
AS
BEGIN
   SET NOCOUNT ON
   DECLARE @Modulo   CHAR(3)
   DECLARE @FecProc  DATETIME


   SELECT * INTO #InkOpcionesGeneral
   FROM LNKOPC.CbMdbOpc.dbo.OpcionesGeneral

   SELECT * INTO #InkSmile
   FROM LNKOPC.CbMdbOpc.dbo.Smile
   
   SELECT * INTO #InkParMda
   FROM LNKOPC.CbMdbOpc.dbo.OpcionParMonedas

   SELECT * INTO #InkOpcionEstructura
   FROM LNKOPC.CbMdbOpc.dbo.OpcionEstructura

   SELECT @FecProc = fechaproc  
   FROM #InkOpcionesGeneral


     IF @iAccion = 0 --> Par de Monedas
     BEGIN
        SELECT OpcParMdaCod 
             , OpcParMda1 
             , OpcParMda2   
        FROM #InkParMda
        ORDER BY OpcParMdaCod
     END

     IF @iAccion = 1 --> Estructura
     BEGIN
        SELECT OpcEstCod  
             , OpcEstDsc
        FROM #InkOpcionEstructura
        ORDER BY OpcEstCod
     END

     IF @iAccion = 2 --> Consulta Smile
     BEGIN
       SELECT SmlDias
             ,SmlBid
             ,SmlAsk 
             ,SmlMid
       FROM #InkSmile
       WHERE SmlFecha  = @dFecha
       AND   SmlParFor = @cParMda  
       AND   SmlEstructura = @cEstructura
       AND   SmlDelta  = @nDelta
       ORDER BY SmlDias
     END

     IF @iAccion = 3 --> Consulta Existencia Smile para fecha Proceso
     BEGIN
      DELETE FROM  LNKOPC.CbMdbOpc.dbo.Smile
             WHERE SmlFecha = @dFecha

      SELECT 0 , 'Par de Monedas listas para crear.'
     END

     IF @iAccion = 4 --> Consulta Existencia de Par de Monedas.
     BEGIN
      IF NOT EXISTS( SELECT 1 FROM #InkParMda WHERE OpcParMdaCod = @cParMda )
      BEGIN
         SELECT -1 , 'Par de Moneda ' + @cParMda + ' ... No se encuentra definido en el sistema.'
         RETURN
      END
      SELECT 0 , 'Par de Moneda se encuentra creada.'
     END

     IF @iAccion = 5 --> Grabacion Smile
     BEGIN

      IF EXISTS(SELECT 1 FROM LNKOPC.CbMdbOpc.dbo.SMILE WHERE SmlFecha = @dFecha AND SmlParFor = @cParMda AND SmlDias = @iDias AND SmlEstructura = @cEstructura AND SmlDelta = @nDelta)
      BEGIN
         DELETE 
         FROM   LNKOPC.CbMdbOpc.dbo.SMILE
         WHERE  SmlFecha      = @dFecha 
         AND    SmlParFor     = @cParMda
         AND    SmlDias       = @iDias
         AND    SmlEstructura = @cEstructura  
         AND    SmlDelta      = @nDelta 

      END

      INSERT INTO LNKOPC.CbMdbOpc.dbo.SMILE
      SELECT @dFecha , @cParMda , @cEstructura, @nDelta ,@iDias , @fValorBid , @fValorAsk, @fMid
    END

    IF @iAccion = 6   AND  @dFecha = @FecProc    --> Eliminación de Smile Simepre y cuando fecha corresponda a fecha de proceso
    BEGIN
      IF  @dFecha = @FecProc        
           DELETE FROM LNKOPC.CbMdbOpc.dbo.SMILE
           WHERE  SmlFecha          = @dFecha      

    END  


END

GO
