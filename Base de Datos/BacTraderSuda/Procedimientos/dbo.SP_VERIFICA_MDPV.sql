USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_VERIFICA_MDPV]    Script Date: 16-05-2022 12:48:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_VERIFICA_MDPV]
   ( @instrumento CHAR (05)  ,
    @tir  NUMERIC (19,04)  ,
    @fecven  DATETIME  ,
    @cota_sup NUMERIC (19,04) OUTPUT ,
    @cota_inf NUMERIC (19,04) OUTPUT ,
    @porcentaje NUMERIC (19,04) OUTPUT )
AS
BEGIN
 DECLARE @tasa  NUMERIC (09,04) ,
  @fecha  DATETIME
 SELECT  @cota_sup    = 0.0 ,
         @cota_inf    = 0.0 ,
         @porcentaje  = 0.0
 SELECT @fecha = CONVERT(CHAR(8),acfecproc,112) FROM MDAC
 SELECT @tasa = trtasas     
 FROM MDRG, MDTR
 WHERE MdRg.rgfinic<=@fecven AND MdRg.rgfvenc>=@fecven AND MdTr.trserie=@instrumento AND
  MdTr.trfecha=@fecha AND MdRg.rgvaldes=MdTr.trvaldes AND
  MdRg.rgvalhas=mdtr.trvalhas AND MdTr.trtasas>0
 SELECT @porcentaje = pvporcentaje
 FROM VIEW_PORCENTAJE_VARIACION
 WHERE pvserie=@instrumento
 IF @tasa<>0 AND @tasa<>NULL AND @porcentaje<>NULL
 BEGIN
  SELECT @cota_sup = @tasa + ((@tasa * @porcentaje ) / 100.0 )
  SELECT @cota_inf = @tasa - ((@tasa * @porcentaje ) / 100.0 )
 END
 ELSE
 BEGIN
  SELECT @cota_sup = 0 ,
   @cota_inf = 0 ,
   @porcentaje = ISNULL(@porcentaje,0)
 END
END

GO
