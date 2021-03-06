USE [Bacfwdsuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_FUNC_MXUHEDGE]    Script Date: 13-05-2022 10:30:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO


CREATE PROCEDURE [dbo].[SP_FUNC_MXUHEDGE] (
                                    @hedge_ini_fwd  NUMERIC(21,04)
                                   ,@hedge_ini_spt  NUMERIC(21,04) 
                                   ,@aux_xtotco     NUMERIC(15,2) --,@aux_moussme    NUMERIC(19,4)  -- Variables de entrada salida
                                   ,@aux_xtotve     NUMERIC(15,2) 
                                   ,@aux_xpmeco     NUMERIC(10,4) 
                                   ,@aux_xpmeve     NUMERIC(10,4)  
                                   ,@aux_xpreini    NUMERIC(10,4) 
                                   ,@aux_xPosihini  NUMERIC(19,4) 
                                   ,@aux_xprecie    NUMERIC(10,4)  
--                                   ,@aux_xtotco     NUMERIC(15,2) 
                                   ,@aux_xpohespt   NUMERIC(19,4) 
                                   ,@aux_prheini    NUMERIC(15,4)
                                   ,@aux_xhedgevenfut  NUMERIC(19,4) 
                                   ,@aux_xpohedge   NUMERIC(19,4) out
                                  )
      
AS
BEGIN
SET NOCOUNT ON
  DECLARE   
        @aux_nUtiCom  NUMERIC(19,4)     
       ,@aux_nUtiVen  NUMERIC(19,4)     
       ,@aux_Utili    NUMERIC(19,4)
       ,@aux_motipope CHAR(1)
       ,@aux_moticam  NUMERIC(9,4)
       ,@aux_qUhedge  NUMERIC(19,4)
       ,@Pos_Hedge_inicial NUMERIC(21,04)

   
   SELECT @aux_nUtiCom = 0
   SELECT @aux_nUtiVen = 0



   SELECT @Pos_Hedge_inicial = ( @hedge_ini_fwd + @hedge_ini_spt )+ (@aux_xhedgevenfut)

   IF  (@aux_xtotco =0 AND  @aux_xtotve =0)   or (@aux_xPmeco =0 AND  @aux_xPmeve =0)
    BEGIN 
         SET @aux_xPmeco =@aux_xpreini
         SET @aux_xPmeve =@aux_xpreini
    END  



   IF @aux_xtotve < @aux_xtotco 
      BEGIN 
--         SELECT @aux_qUhedge=ABS(@Pos_Hedge_inicial)*(@aux_xPrecie - @aux_xPreini)+(@aux_xtotco-@aux_xTotve)*(@aux_xPrecie-@aux_xPmeco)
         SELECT @aux_qUhedge=(@Pos_Hedge_inicial)*(@aux_xPrecie-@aux_xPmeco)
      END
   ELSE
      BEGIN 
--         SELECT @aux_qUhedge=ABS(@Pos_Hedge_inicial)*(@aux_xPrecie - @aux_xPreini)+(@aux_xtotco-@aux_xTotve)*(@aux_xPrecie-@aux_xPmeve)
         SELECT @aux_qUhedge=(@Pos_Hedge_inicial)*(@aux_xPrecie-@aux_xPmeve)
      END
--   SELECT @aux_nUtiCom = ISNULL(SUM(moussme*moticam),0) FROM VIEW_MEMO WHERE motipmer='PTAS' AND motipope='C'      
--   SELECT @aux_nUtiVen = ISNULL(SUM(moussme*moticam),0) FROM VIEW_MEMO WHERE motipmer='PTAS' AND motipope='V'     

   SELECT @aux_Utili    = ( @aux_nUtiVen - @aux_nUtiCom )
   SELECT @aux_xpohedge = ( @aux_qUhedge + @aux_Utili  )        -- Retorna


END

GO
