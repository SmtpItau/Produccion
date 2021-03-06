USE [BacCamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_GRABAPARAMETROS]    Script Date: 11-05-2022 16:43:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_GRABAPARAMETROS](
                                     @Entidad    CHAR(2)
                                    ,@Valor      NUMERIC(18,5)
                                    ,@Camara     NUMERIC(19,4)
                                    ,@Over       NUMERIC(19,4)
                                    ,@dCamara    NUMERIC(2)
                                    ,@dOver      NUMERIC(2)
                                    ,@cbanda     NUMERIC(19,4)
                                    ,@vbanda     NUMERIC(19,4)
                                    ,@hedgespot  NUMERIC(19,4)
                                    ,@hedgefutu  NUMERIC(19,4)
                                    ,@precioini  NUMERIC(15,4)
                                    ,@preciocierre  NUMERIC(15,4)                           
                                   )
AS
BEGIN
set nocount on
    DECLARE @HedgeSpotAntes    NUMERIC(19,4)
           ,@HedgeFuturoAntes  NUMERIC(19,4)
           ,@HedgeSpotActual   NUMERIC(19,4)
           ,@HedgeFuturoActual NUMERIC(19,4)
           ,@aux_xtotco        NUMERIC(15,2) 
           ,@aux_xPmeco        NUMERIC(10,4) 
           ,@aux_xtotve        NUMERIC(15,2) 
           ,@aux_xPmeve        NUMERIC(10,4) 
           ,@aux_xutili        NUMERIC(15,2)
           ,@hedge_inicial_FWD NUMERIC(19,4)
           ,@hedge_inicial_SPT NUMERIC(19,4)
           ,@aux_xuhedge       NUMERIC(15,2)
           ,@dFecpro           DATETIME  
 

     SELECT @HedgeSpotAntes   = AcHedgeInicialSpot   
           ,@HedgeFuturoAntes = AcHedgeInicialFuturo 
           ,@HedgeSpotActual  = AcHedgeActualSpot - AcHedgeInicialSpot
           ,@HedgeFuturoActual= AcHedgeActualFuturo - AcHedgeInicialFuturo
           ,@aux_xtotco       = ACTOTCO
           ,@aux_xPmeco       = ACPMECO
           ,@aux_xtotve       = ACTOTVE
           ,@aux_xPmeve       = ACPMEVE
           ,@hedge_inicial_FWD = ACHEDGEINICIALFUTURO
           ,@hedge_inicial_SPT = ACHEDGEINICIALSPOT
           ,@dFecpro           = ACFECPRO

      FROM meac


      DECLARE @ACUMMESDIAANT   NUMERIC(19,4)
      SELECT  @ACUMMESDIAANT   = 0      
      SELECT  @ACUMMESDIAANT   = ISNULL(ACACUMMES,0) FROM MEACH  WHERE  ACFECPRX =@dFecpro



    
    UPDATE meac 
       SET AcTCamar             = @Camara,
           AcTOvern             = @Over,
           AcDCamar             = @dCamara,
           AcDOvern             = @dOver,
           AcFinan              = @Valor,
           accband              = @cbanda,
           acvband              = @vbanda,
           AcHedgeInicialSpot   = @hedgespot,
           AcHedgeInicialFuturo = @hedgefutu,
           AcHedgePrecioInicial = @precioini,
           AcHedgeActualSpot    = @HedgeSpotActual + @hedgespot,
           AcHedgeActualFuturo  = @HedgeFuturoActual + @hedgefutu,
	   acpreini		= @precioini,
           acprecie             = @preciocierre
     WHERE acentida = @Entidad

     SELECT @hedge_inicial_FWD = ACHEDGEACTUALFUTURO
           ,@hedge_inicial_SPT = ACHEDGEACTUALSPOT

      FROM meac


     EXECUTE Sp_MxUTrading @aux_xtotco ,
                           @aux_xPmeco ,
                           @aux_xtotve ,
                           @aux_xPmeve ,
                           @aux_xutili OUT

   

     EXECUTE sp_Func_MxUhedge @hedge_inicial_FWD,
                               @hedge_inicial_SPT,
                               @aux_xtotco      ,  
                               @aux_xtotve      ,  
                               @aux_xpmeco      ,
                               @aux_xpmeve      ,
                               @precioini       ,
                               @preciocierre    ,
                               @aux_xuhedge   OUTPUT




       UPDATE meac 
       SET ACUTILI             = @aux_xutili  
          ,ACHEDGEUTILIDAD     = @aux_xuhedge 
          ,ACACUMDIA           = @aux_xutili + @aux_xuhedge 
          ,ACACUMMES           = @ACUMMESDIAANT + (@aux_xutili + @aux_xuhedge)
                WHERE acentida = @Entidad       

SELECT 0
SET NOCOUNT OFF
END

GO
