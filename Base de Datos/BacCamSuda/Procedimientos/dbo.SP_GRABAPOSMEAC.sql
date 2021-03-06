USE [BacCamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_GRABAPOSMEAC]    Script Date: 11-05-2022 16:43:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_GRABAPOSMEAC] ( @PosMoneda  FLOAT
                                  ,@TotOtros   FLOAT
                                  ,@Total      FLOAT 
                                  ) 
AS
BEGIN
  DECLARE @PRECIO NUMERIC(19,4)
  DECLARE @VAL1   NUMERIC(19,4)
  DECLARE @VAL2   NUMERIC(19,4)
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
         ,@precioini         NUMERIC(10,4) 
         ,@preciocierre      NUMERIC(10,4) 
         ,@dFecpro           DATETIME  

     SELECT @HedgeSpotAntes   = AcHedgeInicialSpot   
           ,@HedgeFuturoAntes = AcHedgeInicialFuturo 
           ,@HedgeSpotActual  = AcHedgeActualSpot - AcHedgeInicialSpot
           ,@HedgeFuturoActual= AcHedgeActualFuturo - AcHedgeInicialFuturo
      FROM meac
    


  SELECT  @VAL1  = (actotco+actotve)                     FROM MEAC
  SELECT  @VAL2  = ((actotco*acpmeco)+(actotve*acpmeve)) FROM MEAC
  EXECUTE SP_DIV @VAL2,@VAL1,@PRECIO OUTPUT
  UPDATE meac 
     SET acposini = @PosMoneda
        ,acposic  = (@PosMoneda + actotco) - actotve
        ,info_posic = @TotOtros 
        ,info_utili = @Total 
        ,AcHedgeInicialSpot   = @Total
        ,AcHedgeActualSpot    = @HedgeSpotActual + @Total




     SELECT @aux_xtotco       = ACTOTCO
           ,@aux_xPmeco       = ACPMECO
           ,@aux_xtotve       = ACTOTVE
           ,@aux_xPmeve       = ACPMEVE
           ,@precioini        = ACPREINI
           ,@preciocierre     = ACPRECIE
           ,@hedge_inicial_FWD = ACHEDGEACTUALFUTURO
           ,@hedge_inicial_SPT = ACHEDGEACTUALSPOT
           ,@dFecpro           = ACFECPRO
            

     FROM meac

      DECLARE @ACUMMESDIAANT   NUMERIC(19,4)
      SELECT  @ACUMMESDIAANT   = 0      
      SELECT  @ACUMMESDIAANT   = ISNULL(ACACUMMES,0) FROM MEACH  WHERE  ACFECPRX =@dFecpro



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
          

END

GO
