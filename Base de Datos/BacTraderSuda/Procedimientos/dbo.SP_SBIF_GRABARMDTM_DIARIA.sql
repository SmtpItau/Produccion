USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_SBIF_GRABARMDTM_DIARIA]    Script Date: 13-05-2022 11:31:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_SBIF_GRABARMDTM_DIARIA]
     (
     @dFecha  DATETIME ,
     @cInstser CHAR (10) ,
     @cSistema CHAR (05) ,
     @cEmisor CHAR (06) ,
     @dFecvcto  DATETIME ,
     @nTasaMerc NUMERIC (8,4) ,
     @nTasaMark NUMERIC (8,4) ,
     @nTasaMark1 NUMERIC (8,4) ,
     @nTasaMark2 NUMERIC (8,4) ,
     @nRutemi NUMERIC (9,0) ,
     @nCodinst NUMERIC (3) ,
     @nMonemis NUMERIC (3) ,
     @nNominal NUMERIC (19,4)
     )
AS
BEGIN
 SET NOCOUNT ON
 INSERT INTO
 TASA_MERCADO_DIARIA  (  fecha_proceso  ,  id_sistema   ,  tmrutcart           ,  tmrutemis  ,
                         tmcodigo       ,  tminstser    ,  tmmonemis           ,  tmgenemis  ,
                         tmnominal      ,  tmfecvcto    ,  tasa_mercado        ,  tasa_market  ,
                         tasa_market1   ,  tasa_market2 ,  tasa_mercado_cierre ,  tasa_market_cierre
                      )
values(
         @dFecha      ,  @cSistema    ,  97023000   ,  @nRutemi   ,  @nCodinst   ,  @cInstser   ,
         @nMonemis    ,  @cEmisor     ,  @nNominal  ,  @dFecvcto  ,  @nTasaMerc  ,  @nTasaMark  ,
         @nTasaMark1  ,  @nTasaMark2  ,  0          ,  0)

 


END 
  




GO
