USE [BacCamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_SIMULAEMPR]    Script Date: 11-05-2022 16:43:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_SIMULAEMPR] (
     @tipope    CHAR(1)          ,  -- Tipo de Operacion
     @ussme   NUMERIC(19,04)   , -- Equivalente USD
     @codmon    CHAR(3)          , -- Moneda 1
     @codcnv    CHAR(3)          , -- Moneda 2 
     @ticam  NUMERIC(19,04)   , -- Tipo Cambio OperaciÃ³n
     @Tctra   NUMERIC(19,04)   , -- Tipo Cambio Costo
     @Parida  NUMERIC(19,04)   , -- Paridad OperaciÃ³n
     @Partr   NUMERIC(19,04)   , -- Paridad de Costo
     @monmo  NUMERIC(19,04)   -- Monto Moneda 1
    )
AS BEGIN
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
 SELECT  'totcous'  = ISNULL(@cp_totco,0.0)  ,
         'totcope'  = ISNULL(@cp_totcop,0.0) ,
         'pmeco'    = ISNULL(@cp_pmeco,0.0)  ,
         'totveus'  = ISNULL(@cp_totve,0.0)  ,
         'totvepe'  = ISNULL(@cp_totvep,0.0) ,
         'pmeve'    = ISNULL(@cp_pmeve,0.0)  ,
         'spread'    = ISNULL(@nrentab,0.0)  ,
         'rentabopera'  = ISNULL(@nrentab * @monmo,0.0)
         
SET NOCOUNT OFF
END



GO
