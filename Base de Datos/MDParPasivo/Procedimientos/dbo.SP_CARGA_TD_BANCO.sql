USE [MDParPasivo]
GO
/****** Object:  StoredProcedure [dbo].[SP_CARGA_TD_BANCO]    Script Date: 16-05-2022 11:09:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO



CREATE PROC [dbo].[SP_CARGA_TD_BANCO](   @Serie         CHAR(12)   ,
                                     @Numero_Cupon  NUMERIC(3) ,
                                     @Fecha_Cupon   CHAR(8)    ,
                                     @Interes       FLOAT      ,
                                     @Amortizacion  FLOAT      ,
                                     @Saldo         FLOAT      ,
                                     @Terminal      CHAR(20)   )
                              
AS
BEGIN

SET NOCOUNT ON
SET DATEFORMAT dmy

DECLARE @Fecha    DATETIME
DECLARE @Periodo  NUMERIC(2)

IF SUBSTRING(@Fecha_Cupon,1,2) <> '00'
   SELECT @Fecha = CONVERT(DATETIME, @Fecha_Cupon)

IF SUBSTRING(@Serie,1,3) = 'PRC'
BEGIN

   SELECT @Fecha   = sefecemi,
          @Periodo = sepervcup
     FROM SERIE
    WHERE seserie = @Serie

   SELECT @Fecha = DATEADD(month, @Periodo * @Numero_Cupon, @Fecha)

END


IF NOT EXISTS (SELECT 1 FROM SERIE WHERE semascara = @Serie) BEGIN

   SELECT 'ERROR'   
   RETURN

END 


IF EXISTS(SELECT 1 FROM TABLA_DESARROLLO WHERE tdmascara = @Serie AND tdcupon = @Numero_cupon) BEGIN

   SELECT 'EXISTE'
   RETURN
--   DELETE TABLA_DESARROLLO WHERE tdmascara = @Serie AND tdcupon = @Numero_cupon

END


INSERT TABLA_DESARROLLO ( tdmascara    ,
                          tdcupon      ,
                          tdfecven     ,
                          tdinteres    ,
                          tdamort      ,
                          tdflujo      ,
                          tdsaldo      )                  VALUES( @Serie        ,
                          @Numero_Cupon ,
                          ISNULL(@Fecha,' ') ,
                          @Interes      ,
                          @Amortizacion ,
                          @Interes + @Amortizacion,
                          @Saldo        )

IF @@ERROR <> 0
BEGIN

   DELETE FROM CARGA_INTERFAZ_SERIE WHERE serie = @Serie

   INSERT INTO CARGA_INTERFAZ_SERIE
          (   Serie        
          ,   emisor      
          ,   fecha_emision               
          ,   tasa_emision 
          ,   tasa_real    
          ,   UM         
          ,   BASE    
          ,   Numero_Cupones 
          ,   Perido_Pago 
          ,   Estado     
          ,   Terminal
          )
       SELECT seserie
          ,   serutemi 
          ,   sefecemi 
          ,   setasemi 
          ,   setera 
          ,   'semonemi' = ISNULL(( SELECT mnnemo FROM MONEDA WHERE mncodmon = semonemi AND ESTADO<>'A' ),' ')
          ,   sebasemi 
          ,   secupones 
          ,   sepervcup 
          ,   'ERROR' 
          ,   @Terminal 
       FROM SERIE
      WHERE seserie = @Serie
      
      DELETE TABLA_DESARROLLO WHERE tdmascara = @Serie 
      DELETE FROM SERIE WHERE seserie = @Serie


   PRINT 'ERROR_PROC FALLA AGREGANDO TABLA DE DESARROLLO'
   SELECT 'ERROR'
   RETURN
END

SELECT 'OK'

SET NOCOUNT OFF

END 



GO
