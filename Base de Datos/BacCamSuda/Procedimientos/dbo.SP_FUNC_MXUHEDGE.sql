USE [BacCamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_FUNC_MXUHEDGE]    Script Date: 11-05-2022 16:43:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_FUNC_MXUHEDGE]
                 (
                  @hedge_ini_fwd     NUMERIC(21,04),
                  @hedge_ini_spt     NUMERIC(21,04),
                  @aux_xtotco        NUMERIC(15,2),
                  @aux_xtotve        NUMERIC(15,2),
                  @aux_xpmeco        NUMERIC(10,4),
                  @aux_xpmeve        NUMERIC(10,4),
                  @aux_xpreini       NUMERIC(10,4),
                  @aux_xprecie       NUMERIC(10,4),
                  @aux_xpohedge      NUMERIC(19,4) OUTPUT
                 )
AS
BEGIN
   SET NOCOUNT ON
   DECLARE @aux_nUtiCom     NUMERIC(19,4)     
   DECLARE @aux_nUtiVen     NUMERIC(19,4)     
   DECLARE @aux_motipope    char(1)
   DECLARE @aux_moticam     NUMERIC(9,4)
   DECLARE @aux_qUhedge     NUMERIC(19,4)
   DECLARE @aux_Utili   NUMERIC(21,04)
   DECLARE @Pos_Hedge_inicial NUMERIC(21,04)
   DECLARE @achedgevctofuturo NUMERIC(19,04) 

   SELECT  @achedgevctofuturo = achedgevctofuturo
   FROM    MEAC


   SELECT @aux_nUtiCom = 0
   SELECT @aux_nUtiVen = 0
   SELECT @Pos_Hedge_inicial = ( @hedge_ini_fwd + @hedge_ini_spt ) + (@achedgevctofuturo)

    IF  (@aux_xtotco =0 AND  @aux_xtotve =0) OR (@aux_xPmeco =0 AND  @aux_xPmeve =0)
    BEGIN 
         SET @aux_xPmeco =@aux_xpreini
         SET @aux_xPmeve =@aux_xpreini
    END  


   IF @aux_xtotve < @aux_xtotco BEGIN 

/*      SELECT @aux_qUhedge = ABS( @Pos_Hedge_inicial ) * ( @aux_xPrecie - @aux_xPreini ) + 
                            ( @aux_xtotco - @aux_xTotve ) * ( @aux_xPrecie - @aux_xPmeco )*/ --Antes
        SELECT @aux_qUhedge = ( @Pos_Hedge_inicial ) * ( @aux_xPrecie - @aux_xPmeco )

   END ELSE BEGIN 
/*      SELECT @aux_qUhedge = ABS( @Pos_Hedge_inicial ) * ( @aux_xPrecie - @aux_xPreini ) +
                            ( @aux_xtotco - @aux_xTotve ) * ( @aux_xPrecie - @aux_xPmeve )*/ --Antes
        SELECT @aux_qUhedge = ( @Pos_Hedge_inicial ) * ( @aux_xPrecie - @aux_xPmeve )

   END
   -- ***************************************
   -- Se Incorporan las Operaciones de Brecha
   -- ***************************************
   SELECT @aux_nUtiCom  = ISNULL( SUM( moussme * moticam ), 0 ) FROM memo WHERE motipmer = 'BREC' AND motipope = 'C'
   SELECT @aux_nUtiVen  = ISNULL( SUM( moussme * moticam ), 0 ) FROM memo WHERE motipmer = 'BREC' AND motipope = 'V'
   SELECT @aux_Utili    = ( @aux_nUtiVen - @aux_nUtiCom )      
   SELECT @aux_xpohedge = ( @aux_qUhedge + @aux_Utili  )        

END

GO
