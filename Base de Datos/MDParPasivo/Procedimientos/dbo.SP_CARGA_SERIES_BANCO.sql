USE [MDParPasivo]
GO
/****** Object:  StoredProcedure [dbo].[SP_CARGA_SERIES_BANCO]    Script Date: 16-05-2022 11:09:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO



CREATE PROC [dbo].[SP_CARGA_SERIES_BANCO]( @Serie         CHAR(12)   ,
                                   @Rut_Emisor    NUMERIC(10),
                                   @Instrumento   CHAR(10)   ,
                                   @Fecha_Emision CHAR(8)    ,
                                   @Tasa_Emision  FLOAT      ,
                                   @TERA          FLOAT      ,
                                   @Moneda        CHAR(4)    ,
                                   @Base          NUMERIC(3) ,
                                   @Cupones       NUMERIC(3) ,
                                   @Periodo       NUMERIC(3) )
AS
BEGIN


SET NOCOUNT ON
SET DATEFORMAT dmy

DECLARE @Fecha         DATETIME
DECLARE @Fecha_Vcto    DATETIME
DECLARE @Anos          NUMERIC(3)
DECLARE @Corte_Minimo  FLOAT
DECLARE @Codigo        NUMERIC(5)
DECLARE @Cod_Moneda    NUMERIC(5)


IF NOT EXISTS( SELECT 1 FROM EMISOR WHERE emrut = @Rut_Emisor ) 
BEGIN
   SELECT 'ERROR'
   RETURN

END


IF SUBSTRING(@Fecha_Emision,1,2) <> '00'
BEGIN
   SELECT @Fecha       = CONVERT(DATETIME, @Fecha_Emision)
   SELECT @Fecha_Vcto  = DATEADD(month, @Periodo * @Cupones, @Fecha_Emision)   
   SELECT @Anos        = DATEDIFF(year, @Fecha, @Fecha_Vcto)
END

IF SUBSTRING(@Instrumento,1,2) = 'LH'
   SELECT @Instrumento = 'LCHR'

IF SUBSTRING(@Instrumento,1,2) = 'BB' OR SUBSTRING(@Instrumento,1,2) = 'BE'
   SELECT @Instrumento = 'BONOS'

IF SUBSTRING(@Instrumento,1,2) = 'BT'
   SELECT @Instrumento = 'PRC'

IF RTRIM(LTRIM(@Moneda)) IN ('ACUE','CHVA','CHVM','ESVA','PREF','PROM','OTRO')
   SELECT @Moneda = 'DO'

SELECT @Codigo = 0
SELECT @Codigo = incodigo FROM INSTRUMENTO WHERE inserie = @Instrumento

SELECT @Cod_Moneda = 0
SELECT @Cod_Moneda = mncodmon FROM MONEDA WHERE mnnemo = @Moneda

SELECT @Corte_Minimo = 1.0

IF SUBSTRING(@Serie,1,3) = 'PRC' AND SUBSTRING(@Serie,6,1) = 'A'
   SELECT @Corte_Minimo = 500.0

IF SUBSTRING(@Serie,1,3) = 'PRC' AND SUBSTRING(@Serie,6,1) = 'B'
   SELECT @Corte_Minimo = 1000.0

IF SUBSTRING(@Serie,1,3) = 'PRC' AND SUBSTRING(@Serie,6,1) = 'C'
   SELECT @Corte_Minimo = 5000.0

IF SUBSTRING(@Serie,1,3) = 'PRC' AND SUBSTRING(@Serie,6,1) = 'D'
   SELECT @Corte_Minimo = 10000.0

IF SUBSTRING(@Serie,1,3) = 'PRD' AND SUBSTRING(@Serie,6,1) = 'A'
   SELECT @Corte_Minimo = 50000.0

IF SUBSTRING(@Serie,1,3) = 'PRD' AND SUBSTRING(@Serie,6,1) = 'B'
   SELECT @Corte_Minimo = 100000.0

IF SUBSTRING(@Serie,1,3) = 'PRD' AND SUBSTRING(@Serie,6,1) = 'C'
   SELECT @Corte_Minimo = 500000.0

IF SUBSTRING(@Serie,1,3) = 'PRD' AND SUBSTRING(@Serie,6,1) = 'D'
   SELECT @Corte_Minimo = 1000000.0




IF EXISTS(SELECT 1 FROM SERIE WHERE semascara = @Serie) BEGIN

   SELECT 'EXISTE'
   RETURN

END

--   DELETE SERIE  WHERE semascara = @Serie


INSERT SERIE ( secodigo       ,
               semascara      ,
               seserie        ,
               serutemi       ,
               sefecemi       ,
               sefecven       ,
               setasemi       ,
               setera         ,
               sebasemi       ,
               semonemi       ,
               secupones      ,
               sediavcup      ,
               sepervcup      ,
               setipvcup      ,
               seplazo        ,
               setipamort     ,
               senumamort     ,
               seffijos       ,
               sebascup       ,
               sedecs         ,
               secorte        ,
               setotalemitido )
       VALUES( @Codigo        ,
               @Serie         , 
               @Serie         , 
               @Rut_Emisor    ,
               @Fecha         ,
               @Fecha_Vcto    ,
               @Tasa_Emision  ,
               @TERA          ,
               @Base          ,
               @Cod_Moneda    ,
               @Cupones       ,
               1              ,
               @Periodo       ,
               'M'            ,
               @Anos          ,
               1              ,
               @Cupones       ,
        ' '             ,
               0              ,
               4              ,
               @Corte_Minimo  ,
               0.0            )

IF @@ERROR <> 0
BEGIN
   PRINT 'ERROR_PROC FALLA AGREGANDO SERIES'
   SELECT 'ERROR'
   RETURN 
END


SELECT 'OK'
SET NOCOUNT OFF

END  



GO
