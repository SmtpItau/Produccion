USE [BacCamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_FUNC_MXRECALCPR]    Script Date: 11-05-2022 16:43:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_FUNC_MXRECALCPR]
                 (
                  @aux_motipmer       CHAR(04),             -- 01 tipo operacion motipmer
                  @aux_motipope       CHAR(01),             -- 02 tipo operacion c v motipope
                  @aux_moprecio       NUMERIC(19,4),        -- 03 tipo cambio mototco
                  @aux_moussme        NUMERIC(19,4),        -- 04
                  @hedge_inicial_FWD  NUMERIC(21,04),       -- 05
                  @hedge_inicial_SPT  NUMERIC(21,04),       -- 06
                  @aux_moterm         CHAR(12)      ,
                  @aux_xtotco         NUMERIC(15,2) OUTPUT, -- 07 Variables de entrada salida
                  @aux_xtotcop        NUMERIC(15,2) OUTPUT, -- 08
                  @aux_xpmeco         NUMERIC(10,4) OUTPUT, -- 09
                  @aux_xtotve         NUMERIC(15,2) OUTPUT, -- 10
                  @aux_xtotvep        NUMERIC(15,2) OUTPUT, -- 11
                  @aux_xpmeve         NUMERIC(10,4) OUTPUT, -- 12
                  @aux_xtotcore       NUMERIC(19,4) OUTPUT, -- 13
                  @aux_xtotcopre      NUMERIC(19,4) OUTPUT, -- 14
                  @aux_xpmecore       NUMERIC(19,4) OUTPUT, -- 15
                  @aux_xpmevere       NUMERIC(19,4) OUTPUT, -- 15.1                  
                  @aux_xposic         NUMERIC(15,2) OUTPUT, -- 16
                  @aux_xpohedge       NUMERIC(19,2) OUTPUT, -- 17
                  @aux_xpohefut       NUMERIC(19,4) OUTPUT, -- 18
                  @aux_xpohespt       NUMERIC(19,4) OUTPUT, -- 19
                  @aux_xtotvere       NUMERIC(19,4) OUTPUT, -- 20
                  @aux_xtotvepre      NUMERIC(19,4) OUTPUT, -- 21
                  @aux_xpreini        NUMERIC(10,4) OUTPUT, -- 22
                  @aux_xPosini        NUMERIC(15,2) OUTPUT, -- 23
                  @aux_xprecie        NUMERIC(10,4) OUTPUT, -- 24
                  @aux_xutili         NUMERIC(19,4) OUTPUT, -- 25
                  @aux_prheini        NUMERIC(15,4) OUTPUT, -- 26
                  @aux_xuhedge        NUMERIC(21,4) OUTPUT, -- 27
                  @xFicAcumDia        NUMERIC(19,4) OUTPUT, -- 28
		  @aux_AcTotCoSin     NUMERIC(15,2) OUTPUT, -- 29
		  @aux_AcTotVeSin     NUMERIC(15,2) OUTPUT, -- 30
		  @aux_AcPesCoSin     NUMERIC(15,2) OUTPUT, -- 31
		  @aux_AcPesVeSin     NUMERIC(15,2) OUTPUT, -- 32
                  @aux_xtotcopo       NUMERIC(15,2) OUTPUT, -- 33
                  @aux_xtotvepo       NUMERIC(15,2) OUTPUT  -- 34

                 )
AS
BEGIN
   SET NOCOUNT ON
   /*=======================================================================*/

-- select @aux_motipmer,@aux_xpmeco,@aux_xpmeve,@aux_moterm

   DECLARE @aux_futuro        CHAR(4)  --  auxiliares para el cursor de tbafectoaposicion
   DECLARE @aux_rentabilidad  CHAR(4)
   DECLARE @aux_trading       CHAR(4)
   DECLARE @aux_posicion      CHAR(4)
   DECLARE @aux_hedge         CHAR(4)
   DECLARE @aux_nemo          CHAR(4)
   DECLARE @qUtrading         FLOAT
   DECLARE @TCinicio          NUMERIC(10,4)
   DECLARE @TCcierre          NUMERIC(10,4)

   select @TCinicio = ACPREINI
         ,@TCcierre = ACPRECIE  
   from meac
   /*=======================================================================*/
   DECLARE @xpFuturo          CHAR(3)      -- F
   SELECT @qUtrading = 0.0000 
   IF @aux_motipmer = 'FUTU' BEGIN
      SELECT @xpFuturo = 'V'
   END ELSE BEGIN
      SELECT @xpFuturo = 'F'
   END



   DECLARE CalEfectosOpera_cursor CURSOR FOR
           SELECT       futuro, rentabilidad, trading, posicion, hedge, nemo
                  FROM  tbafectoaposicion
                  WHERE nemo = @aux_motipmer
   OPEN CalEfectosOpera_cursor
   FETCH       CalEfectosOpera_cursor
         INTO  @aux_futuro,
               @aux_rentabilidad,
               @aux_trading,
               @aux_posicion,
               @aux_hedge,
               @aux_nemo
   WHILE (@@fetch_status = 0) BEGIN
      -- Trading   
      IF @aux_trading ='V'  BEGIN
         IF @aux_motipope='C' BEGIN
            SELECT @aux_xtotcopo= @aux_xtotcopo + @aux_moussme
            SELECT @aux_xtotco  = @aux_xtotco + @aux_moussme
            SELECT @aux_xtotcop = @aux_xtotcop + (@aux_moussme* @aux_moprecio)
                     
           IF (@aux_moterm='FORWARD' AND @aux_motipmer ='EMPR') or  (@aux_moprecio=0.0)
              BEGIN 
                  SELECT @aux_xpmeco = CASE WHEN @aux_xpmeco =0.0 THEN @TCinicio ELSE @aux_xpmeco END               
                  SELECT @aux_xpmeve = CASE WHEN @aux_xpmeve =0.0 THEN @TCcierre ELSE @aux_xpmeve END                 
              END 
           ELSE                
               EXECUTE sp_div  @aux_xtotcop , @aux_xtotco, @aux_xpmeco OUTPUT
               
               
              

         END ELSE BEGIN
            SELECT @aux_xtotvepo= @aux_xtotvepo + @aux_moussme            
            SELECT @aux_xtotve  = @aux_xtotve + @aux_moussme
            SELECT @aux_xtotvep = @aux_xtotvep + (@aux_moussme * @aux_moprecio)

            IF (@aux_moterm='FORWARD' AND @aux_motipmer='EMPR') or  (@aux_moprecio=0.0)
               BEGIN
                  SELECT @aux_xpmeve = CASE WHEN @aux_xpmeve =0.0 THEN @TCcierre ELSE @aux_xpmeco END                 
                  SELECT @aux_xpmeco = CASE WHEN @aux_xpmeco =0.0 THEN @TCinicio ELSE @aux_xpmeve END               
               END   
            ELSE
               EXECUTE sp_div  @aux_xtotvep , @aux_xtotve, @aux_xpmeve OUTPUT 

            
   
         END
            
                EXECUTE Sp_MxUTrading @aux_xtotcopo , 
                                 @aux_xPmeco ,
                                 @aux_xtotvepo , 
                                 @aux_xPmeve ,
                                 @aux_xutili OUT

               




      END
      IF @aux_rentabilidad = 'V' BEGIN
         IF @aux_motipope='C' BEGIN
            SELECT @aux_xtotcore  = @aux_xtotcore + @aux_moussme                    --@aux_mouss30
            SELECT @aux_xtotcopre = @aux_xtotcopre + ( @aux_moussme * @aux_moprecio) -- =
            EXECUTE sp_div   @aux_xtotcopre , @aux_xtotcore, @aux_xpmecore OUTPUT
         END ELSE BEGIN
            SELECT @aux_xtotvere  = @aux_xtotvere  + @aux_moussme                   --@aux_mouss30
            SELECT @aux_xtotvepre = @aux_xtotvepre + ( @aux_moussme * @aux_moprecio) -- =
            
            EXECUTE sp_div   @aux_xtotvepre , @aux_xtotvere, @aux_xpmevere OUT
         END
      END 
      IF @aux_posicion = 'V' BEGIN
         IF @aux_motipope = 'C' BEGIN
            SELECT @aux_xposic = @aux_xposic + @aux_moussme  --@aux_mouss30
         END ELSE BEGIN
            SELECT @aux_xposic = @aux_xposic - @aux_moussme  --@aux_mouss30
         END
      END
               

      IF @aux_hedge = 'V' BEGIN
         IF @aux_motipope = 'C' BEGIN
--            IF @xpFuturo = 'V' BEGIN   -- Futuro  
--               SELECT @aux_xpohedge = @aux_xpohedge + @aux_moussme 
--               SELECT @aux_xpohefut = @aux_xpohefut + @aux_moussme
--            END ELSE BEGIN   -- Spot  
               SELECT @aux_xpohedge = @aux_xpohedge + @aux_moussme 
               SELECT @aux_xpohespt = @aux_xpohespt + @aux_moussme
--            END
         END ELSE BEGIN 
--            IF @xpFuturo = 'F' BEGIN   
               SELECT @aux_xpohedge = @aux_xpohedge - @aux_moussme 
               SELECT @aux_xpohespt = @aux_xpohespt - @aux_moussme
--            END ELSE BEGIN   
--               SELECT @aux_xpohedge = @aux_xpohedge - @aux_moussme 
--               SELECT @aux_xpohefut = @aux_xpohefut - @aux_moussme
--            END
         END
      END 
           
      EXECUTE sp_Func_MxUhedge @aux_xpohefut , 
                               @aux_xpohespt , 
                               @aux_xtotco,  
                               @aux_xtotve, 
                               @aux_xpmeco,
                               @aux_xpmeve,
                               @aux_xpreini,
                               @aux_xprecie,
                               @aux_xuhedge   OUTPUT



      
      IF (@aux_moterm='FORWARD' AND @aux_motipmer='EMPR') or  (@aux_moprecio=0.0)
      BEGIN
           SELECT @aux_xpmeco = ACPMECO
                 ,@aux_xpmeve = ACPMEVE
           FROM meac   
      END   





      FETCH      CalEfectosOpera_cursor
            INTO @aux_futuro,
                 @aux_rentabilidad,
                 @aux_trading,
                 @aux_posicion,
                 @aux_hedge,
                 @aux_nemo
   END 
   CLOSE CalEfectosOpera_cursor
   DEALLOCATE CalEfectosOpera_cursor
   IF @aux_motipmer = 'INFO' BEGIN
      SELECT @aux_xpreini = ROUND( ( @aux_xtotcop + @aux_xtotvep ) / ( @aux_xtotco + @aux_xtotve ), 4 )
   END
END

GO
