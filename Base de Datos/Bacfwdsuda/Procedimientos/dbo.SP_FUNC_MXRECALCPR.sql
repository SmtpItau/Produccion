USE [Bacfwdsuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_FUNC_MXRECALCPR]    Script Date: 13-05-2022 10:30:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO


CREATE PROCEDURE [dbo].[SP_FUNC_MXRECALCPR]( @aux_motipmer   CHAR(4)           -- 01 tipo operacion motipmer
     ,@aux_motipope   CHAR(1)           -- 02 tipo operacion c v motipope
     ,@aux_mototco    NUMERIC(19,4)     -- 03 tipo cambio mototco
     ,@aux_moussme    NUMERIC(19,4)     -- 04
     ,@aux_vcto	      NUMERIC(1)        -- 05
     ,@hedge_inicial_FWD  NUMERIC(21,04)
     ,@hedge_inicial_SPT  NUMERIC(21,04)
     ,@aux_xtotco     NUMERIC(15,2) Out -- 06 Variables de entrada salida
     ,@aux_xtotcop    NUMERIC(15,2) Out -- 07
     ,@aux_xpmeco     NUMERIC(10,4) Out -- 08
     ,@aux_xtotve     NUMERIC(15,2) Out -- 09
     ,@aux_xtotvep    NUMERIC(15,2) Out -- 10
     ,@aux_xpmeve     NUMERIC(10,4) Out -- 11
     ,@aux_xtotcore   NUMERIC(19,4) Out -- 12
     ,@aux_xtotcopre  NUMERIC(19,4) Out -- 13
     ,@aux_xpmecore   NUMERIC(19,4) Out -- 14
     ,@aux_xposic     NUMERIC(15,2) Out -- 15
     ,@aux_xpohedge   NUMERIC(19,2) Out -- 16
     ,@aux_xpohefut   NUMERIC(19,4) Out -- 17
     ,@aux_xpohespt   NUMERIC(19,4) Out -- 18
     ,@aux_xtotvere   NUMERIC(19,4) Out -- 19
     ,@aux_xtotvepre  NUMERIC(19,4) Out -- 20
     ,@aux_xpreini    NUMERIC(10,4) Out -- 21
     ,@aux_xPosini    NUMERIC(15,2) Out -- 22
     ,@aux_xprecie    NUMERIC(10,4) Out -- 23
     ,@aux_xutili     NUMERIC(15,2) out -- 24
     ,@aux_prheini    NUMERIC(15,4) out -- 25
     ,@aux_xpohevenfut NUMERIC(19,4) Out -- 26 
     ,@aux_xuhedge    NUMERIC(21,4) OUT -- 27
     ,@aux_xtotcopo   NUMERIC(15,2) OUT -- 33
     ,@aux_xtotvepo   NUMERIC(15,2) OUT 
     )
AS
BEGIN
SET NOCOUNT ON
/*=======================================================================*/
DECLARE @aux_futuro        CHAR(4)  --  auxiliares para el CURSOR de tbafectoaposicion
DECLARE @aux_rentabilidad  CHAR(4)
DECLARE @aux_trading       CHAR(4)
DECLARE @aux_posicion      CHAR(4)
DECLARE @aux_hedge         CHAR(4)
DECLARE @aux_nemo          CHAR(4)
DECLARE @qUtrading         float
/*=======================================================================*/
DECLARE @xpFuturo   CHAR(3)      -- F
SELECT  @qUtrading = 0.0000 
SELECT  @xpFuturo  = 'V'
DECLARE CalEfectosOpera_CURSOR CURSOR FOR
       SELECT futuro,rentabilidad,trading,posicion,hedge,nemo
       
 FROM  VIEW_TBAFECTOAPOSICION
        WHERE  nemo = @aux_motipmer
 OPEN CalEfectosOpera_CURSOR
        FETCH CalEfectosOpera_CURSOR
              INTO  @aux_futuro
                   ,@aux_rentabilidad
                   ,@aux_trading
                   ,@aux_posicion
                   ,@aux_hedge
                   ,@aux_nemo


         WHILE (@@FETCH_status = 0)
            BEGIN
              -- Trading 
              --           SELECT 'zzzzz'
              IF @aux_trading ='V' 
                 --SELECT 'trading'
                 BEGIN
                   IF @aux_motipope='C' 
                      BEGIN
                         SET @aux_xtotco  = @aux_xtotco + @aux_moussme
                         SET @aux_xtotcop = @aux_xtotcop + (@aux_moussme* @aux_mototco)
                         EXECUTE sp_div  @aux_xtotcop , @aux_xtotco, @aux_xpmeco OUTPUT

                      END 
                   ELSE 
                      BEGIN
                         --SELECT 'zzzzz3'
                         SET @aux_xtotve  = @aux_xtotve + @aux_moussme
                         SET @aux_xtotvep = @aux_xtotvep + (@aux_moussme * @aux_mototco)
                         EXECUTE sp_div  @aux_xtotvep , @aux_xtotve, @aux_xpmeve OUTPUT
                        

                      END

                    EXECUTE Sp_MxUTrading @aux_xtotcopo ,
                                          @aux_xPmeco ,
                                          @aux_xtotvepo , 
                                          @aux_xPmeve ,
                                          @aux_xutili OUT

                   
                 END

              IF @aux_rentabilidad='V' 
   --SELECT 'rentabilidad'
                 BEGIN
                   IF @aux_motipope='C' 
                      BEGIN
                        SET @aux_xtotcore  = @aux_xtotcore + @aux_moussme                    --@aux_mouss30
                        SET @aux_xtotcopre = @aux_xtotcopre + ( @aux_moussme * @aux_mototco) -- =
                        SET @aux_xpmecore  = ROUND(( @aux_xtotcopre / @aux_xtotcore ),4)
                      END
                   ELSE
                      BEGIN
                        SET @aux_xtotvere  = @aux_xtotvere  + @aux_moussme                   --@aux_mouss30
                        SET @aux_xtotvepre = @aux_xtotvepre + ( @aux_moussme * @aux_mototco) -- =
                        SET @aux_xpmeve    = ROUND((@aux_xtotvepre/@aux_xtotvere),4)
                      END
                 END 
              IF @aux_posicion = 'V' 
                 --SELECT 'posicion'
                 BEGIN
                   IF @aux_motipope = 'C' 
                      BEGIN
                        SET @aux_xposic = @aux_xposic + @aux_moussme  --@aux_mouss30
                      END 
                   ELSE
                      BEGIN
                        SET @aux_xposic = @aux_xposic - @aux_moussme  --@aux_mouss30
                      END
                 END 


              IF @aux_hedge = 'V' 
                 --SELECT 'Hedge'
                 BEGIN

                   IF @aux_motipope = 'C' 
                      BEGIN

                        if @xpFuturo = 'V' 
                           BEGIN   -- falso es cambio 
                             SET @aux_xpohedge = @aux_xpohedge + @aux_moussme --@aux_mouss30



                             IF @aux_vcto = 1 BEGIN	-- si es operacion de vencimiento



                                SET @aux_xpohevenfut = @aux_xpohevenfut - @aux_moussme 


                             END
			     ELSE BEGIN
                                SET @aux_xpohefut = @aux_xpohefut + @aux_moussme 
                             END 
                             SET @aux_xpohespt = @aux_xpohespt 
                           END
                      END 
                   ELSE 
                      BEGIN 
                        if @xpFuturo = 'V' 
                           BEGIN   -- 
                             SET @aux_xpohedge = @aux_xpohedge - @aux_moussme 
                             IF @aux_vcto = 1 BEGIN	-- si es operacion de vencimiento
                                SET @aux_xpohevenfut = @aux_xpohevenfut + @aux_moussme 
			     END
			     ELSE BEGIN 
                                SET @aux_xpohefut = @aux_xpohefut  - @aux_moussme 
                             END 
                             SET @aux_xpohespt = @aux_xpohespt 
                           END
                      END


                    EXECUTE sp_Func_MxUhedge  @aux_xpohefut
                                             ,@aux_xpohespt
                                             ,@aux_xtotco 
                                             ,@aux_xtotve  
                                             ,@aux_xpmeco 
                                             ,@aux_xpmeve 
                                             ,@aux_xpreini 
                                             ,@aux_xPosini 
                                             ,@aux_xprecie
--                                           ,@aux_xutili  
                                             ,@aux_xPoHeSpt  
                                             ,@aux_PrHeIni   
                                             ,@aux_xpohevenfut
                                             ,@aux_xuhedge OUT   


                 END 
            
 
              FETCH CalEfectosOpera_CURSOR
               INTO  @aux_futuro
                    ,@aux_rentabilidad
                    ,@aux_trading
                    ,@aux_posicion
                    ,@aux_hedge
           ,@aux_nemo
                  
            END 
      CLOSE CalEfectosOpera_CURSOR
      DEALLOCATE CalEfectosOpera_CURSOR
END

GO
