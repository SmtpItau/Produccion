USE [BacCamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_GRABAR_RENTABILIDAD_DIARIA]    Script Date: 11-05-2022 16:43:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_GRABAR_RENTABILIDAD_DIARIA]
                ( @dFecpro DATETIME 
                , @posic   NUMERIC(19,4)
                , @tcAct   NUMERIC(10,4)
                , @tccierr NUMERIC(10,4)
                , @resul   NUMERIC(19,4)
                 )
AS
BEGIN

      SET NOCOUNT ON

      DECLARE @hedge_inicial_FWD NUMERIC(19,4),
              @hedge_inicial_SPT NUMERIC(19,4),
              @aux_xtotco        NUMERIC(15,2),  
              @aux_xtotve        NUMERIC(15,2),  
              @aux_xpmeco        NUMERIC(10,4),
              @aux_xpmeve        NUMERIC(10,4),
              @precioini         NUMERIC(15,4),
              @preciocierre      NUMERIC(15,4),
              @aux_xuhedge       NUMERIC(15,2)

      SELECT  @hedge_inicial_FWD=0,
              @hedge_inicial_SPT=0,
              @aux_xtotco       =0,  
              @aux_xtotve       =0,  
              @aux_xpmeco       =0,
              @aux_xpmeve       =0,
              @precioini        =0,
              @preciocierre     =0,
              @aux_xuhedge      =0

      DECLARE @ACUMMESDIAANT   NUMERIC(19,4)
      SELECT  @ACUMMESDIAANT   = 0      
      SELECT  @ACUMMESDIAANT   = ISNULL(ACACUMMES,0) FROM MEACH  WHERE  ACFECPRX =@dFecpro

       SELECT @hedge_inicial_FWD= ACHEDGEACTUALFUTURO,
              @hedge_inicial_SPT= ACHEDGEACTUALSPOT,
              @aux_xtotco       = ACTOTCO,  
              @aux_xtotve       = ACTOTVE,  
              @aux_xpmeco       = ACPMECO,
              @aux_xpmeve       = ACPMEVE,
              @precioini        = ACPREINI,
              @preciocierre     = ACPRECIE

       FROM MEAC      



    EXECUTE sp_Func_MxUhedge   @hedge_inicial_FWD,
                               @hedge_inicial_SPT,
                               @aux_xtotco      ,  
                               @aux_xtotve      ,  
                               @aux_xpmeco      ,
                               @aux_xpmeve      ,
                               @precioini       , 
                               @tccierr         , 
                               @aux_xuhedge   OUTPUT

         UPDATE MEAC SET  ACPRECIE = @tccierr
                         ,ACHEDGEUTILIDAD = @aux_xuhedge                          
                         ,ACACUMDIA = ACUTILI + @aux_xuhedge
                         ,ACACUMMES = @ACUMMESDIAANT  + (ACUTILI + @aux_xuhedge) 
         WHERE ACFECPRO = @dFecpro




         DELETE FROM RENTABILIDAD WHERE Fecha = @dFecpro



         INSERT INTO RENTABILIDAD
         SELECT  ACFECPRO
               , ACUTILI
               , ACPOSIC
               , CASE WHEN ACPOSIC > 0 THEN  ACPMECO ELSE  ACPMEVE END 
               , @tccierr 
               , @resul 
               , ACHEDGEUTILIDAD
               , ACACUMDIA
               , ACACUMMES
               , cp_utili
                              
         FROM MEAC

     
      SET NOCOUNT OFF

END

GO
