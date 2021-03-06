USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[SP_GRABA_SERIE]    Script Date: 13-05-2022 10:37:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_GRABA_SERIE]
    (@xCodigo  NUMERIC(3) ,--1
     @xMascara  CHAR(12) ,--2
     @xSerie  CHAR(12) ,   --3
     @xTera  NUMERIC(9,4) ,--4
     @xMonemi  NUMERIC(3) ,--5
     @xBasemi  NUMERIC(3) ,--6
     @xRutemi  NUMERIC(9) ,--7
     @xFecemi  CHAR(10) ,  --8
     @xFecven  CHAR(10) ,  --9
     @xPlazo  NUMERIC(6) , --10
     @xTasemi  NUMERIC(9,4) ,--11
     @xCupones  NUMERIC(3) , --12
     @xTipvcup  CHAR(1)  ,   --13
     @xPervcup  NUMERIC(2) , --14
     @xNumAmort  NUMERIC(3) ,-- 15
     @xDecs  NUMERIC(2) ,    --16
     @xDiavcup  NUMERIC(2) , --17
     @xffijos  CHAR(1)  ,    --18
     @xBascup  NUMERIC(7,1) ,--19
     @xCorte  NUMERIC(19,4) ,--20
     @xTipoAmort  NUMERIC(1) ,--21
     @xTotalEmitido          FLOAT , --22
     @xtipo_letra   CHAR(1) , --23
     @xFecPriVcto  CHAR(10) )   --24
AS
BEGIN
SET NOCOUNT ON
     IF EXISTS(SELECT * FROM Serie WHERE seserie = @xMascara)
             UPDATE SERIE SET  
    serutemi = @xRutemi  ,
    sefecemi = @xFecemi  ,
    sefecven = @xFecVen  ,
    setasemi = @xTasemi  ,
    setera  =  @xTera   ,
    sebasemi = @xBasemi  ,
    semonemi = @xMonemi  ,
    secupones = @xCupones  ,
    sediavcup = @xDiavcup  ,
    sepervcup = @xPervcup  ,
    setipvcup = @xTipvcup  ,
    seplazo  = @xPlazo   ,
    setipamort = @xTipoAmort  ,
    senumamort = @xNumAmort  ,
    seffijos = @xffijos  ,
    sebascup = @xBascup  ,
    sedecs  = @xDecs   ,
    secorte  = @xCorte          ,
    setotalemitido  =       @xTotalEmitido  ,
    tipo_letra = @xtipo_letra,
    primer_vencimiento=@xFecPriVcto
    WHERE seserie  = @xMascara
     ELSE
            INSERT INTO SERIE(  secodigo  ,
    semascara  ,
    seserie   ,
    serutemi  ,
    sefecemi  ,
    sefecven  ,
    setasemi  ,
    setera   ,
    sebasemi  ,
    semonemi  ,
    secupones  ,
    sediavcup  ,
    sepervcup  ,
    setipvcup  ,
    seplazo   ,
    setipamort  ,
    senumamort  ,
    seffijos   ,
    sebascup  ,
    sedecs   ,
    secorte                 ,
    setotalemitido,
    tipo_letra ,
    primer_vencimiento,
    primer_vcto_variable  )
  VALUES(  @xCodigo  ,
    @xMascara  ,
    @xSerie   ,
    @xRutemi  ,
    @xFecemi  ,
    @xFecVen  ,
    @xTasemi  ,
    @xTera   ,
    @xBasemi  ,
    @xMonemi  ,
    @xCupones  ,
    @xDiavcup  ,
    @xPervcup  ,
    @xTipvcup  ,
    @xPlazo          ,
    @xTipoAmort  ,
    @xNumAmort  ,
    @xffijos  ,
    @xBascup  ,
    @xDecs          ,
    @xCorte          ,
    @xTotalEmitido,
    @xtipo_letra,
     @xFecPriVcto,
 ' ')
IF @@error <> 0 BEGIN
   SELECT 'NO'
   RETURN
END
SELECT 'SI'
SET NOCOUNT OFF
END
GO
