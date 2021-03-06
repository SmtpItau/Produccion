USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_SBIF_CARGAFAC]    Script Date: 13-05-2022 11:31:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_SBIF_CARGAFAC]
        ( @nRut   NUMERIC (09,0) ,
   @cdv   CHAR (1) ,
   @cSerieBol  CHAR(20) ,
   @dFecemi  DATETIME ,
   @cInst   CHAR (3) ,
   @cMoneda  CHAR (1) ,
   @nFactor  NUMERIC (17,5) ,
   @cNemo   CHAR (7) ,
   @cSerie         CHAR(10) )
 AS
 BEGIN
  set nocount on
 INSERT INTO MD_SBIF
  (sbRut,
  sbDv,
  sbSerBol,
  sbFecemi,
  sbInst,
  sbMoneda,
  sbFactor,
  sbNemo,
  sbSerie)
 VALUES (@nRut,
  @cdv,
  @cSeriebol,
  @dFecemi,
  @cInst,
  @cMoneda,
  @nFactor,
  @cNemo,
  @cSerie )
select 'OK'
set nocount off
  
 END

GO
