USE [BacCamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_RECALC_EMPRESAS]    Script Date: 11-05-2022 16:43:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[SP_RECALC_EMPRESAS](  @tipope CHAR(1)  ,
     @ticam NUMERIC(19,04) ,
     @ussme NUMERIC(19,04) ,
     @codmon CHAR(3)  ,
     @codcnv CHAR(3)  ,
     @tctra NUMERIC(19,04) ,
     @parida NUMERIC(19,04) ,
     @partr NUMERIC(19,04) ,
     @monmo NUMERIC(19,04)    
       )
AS
BEGIN
SET NOCOUNT ON
 DECLARE @xUticoCP NUMERIC(19,4) ,
  @xUtiveCP    NUMERIC(19,4) ,
  @xUtiliCP    NUMERIC(19,4) ,
  @cp_totco     NUMERIC(19,4) ,
  @cp_totve     NUMERIC(19,4) ,
  @cp_totcop    NUMERIC(19,2) ,
  @cp_totvep    NUMERIC(19,2) ,
  @cp_pmeco     NUMERIC(15,4) ,
  @cp_pmeve     NUMERIC(15,4) ,
  @cp_pmecoci   NUMERIC(15,4) ,
  @cp_pmeveci   NUMERIC(15,4) ,
  @nRentab     NUMERIC(19,4)
 EXECUTE Sp_Funcion_MxCalcVolCorp  @tipope   ,
      @ticam   ,
      @ussme   ,
      @monmo   ,
      @codmon   ,
      @codcnv   ,
      @tctra    ,
      @cp_totco OUTPUT ,
      @cp_totve OUTPUT ,
      @cp_totcop OUTPUT ,
      @cp_totvep OUTPUT ,
      @cp_pmeco OUTPUT ,
      @cp_pmeve OUTPUT ,
      @cp_pmecoci OUTPUT ,
      @cp_pmeveci OUTPUT 
 EXECUTE Sp_MxCalcRenCorp @tipope   ,
     @codmon   ,
     @ticam   ,
     @tctra   ,
     @parida   ,
     @partr   ,
     @monmo   ,
     @cp_totco  ,
     @cp_totve  ,
     @cp_totcop  ,
     @cp_totvep  ,
     @cp_pmeco  ,
     @cp_pmeve  ,
     @cp_pmecoci  ,
     @cp_pmeveci  ,
     @xUtiliCP OUTPUT ,
     @xUticoCP OUTPUT ,
     @xUtiveCP OUTPUT ,
     @nRentab OUTPUT 
 UPDATE  meac 
 SET  cp_totco = ISNULL(@cp_totco,0.0)  ,
  cp_totve    = ISNULL(@cp_totve,0.0)    ,
  cp_totcop   = ISNULL(@cp_totcop,0.0)   ,
  cp_totvep   = ISNULL(@cp_totvep,0.0)   ,
  cp_pmeco    = ISNULL(@cp_pmeco,0.0)    ,
  cp_pmeve    = ISNULL(@cp_pmeve,0.0)    ,
  cp_pmecoci  = ISNULL(@cp_pmecoci,0.0)  ,
  cp_pmeveci  = ISNULL(@cp_pmeveci,0.0)  ,
  cp_utili   = ISNULL(@xUtiliCP,0.0)     ,
  cp_utico   = ISNULL(@xUticoCP,0.0)   ,
  cp_utive   = ISNULL(@xUtiveCP,0.0)    
SET NOCOUNT OFF
END
GO
