USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[Sp_Resultados_Over_Deposit]    Script Date: 13-05-2022 10:37:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO





CREATE PROCEDURE [dbo].[Sp_Resultados_Over_Deposit]
      (
          @OPERADOR      CHAR(30)
         ,@DESDE         CHAR(8)--DATETIME
         ,@HASTA         CHAR(8)--DATETIME
      )
AS
BEGIN

DECLARE @XFECPROC DATETIME

IF EXISTS ( SELECT 1 FROM MEMO
                         ,VIEW_FORMA_DE_PAGO F
                     WHERE ( MOTIPMER = 'WEEK' OR MOTIPMER = 'OVER' )
                       AND F.codigo =  moentre 
                       AND F.codigo =  morecib
                       AND mofech >= @DESDE
                       AND mofech <= @HASTA
                       AND @HASTA <= @XFECPROC
         )
BEGIN

   SELECT 
       'CLIENTE'      =   monomcli
      ,'NUMER_OPER'   =   monumope
      ,'MONTO_ORIG'   =   momonmo      ,'DOLAR_OBSE'   = ( SELECT acobser FROM MEAC )
      ,'MONTO_USD'    =   momonmo
      ,'MONTO_CNV'    =   mousstr
      ,'MONTO_CLP'    =   momonpe      ,'TIPO_CAMB'    =   moticam
      ,'INTERES'      =   0
      ,'DIAS'         =   DATEDIFF( DD ,movaluta2 , movaluta1 )
      ,'VALUTA_ENTRE' =   movaluta1
      ,'VALUTA_RECIB' =   movaluta2
      ,'FORMA_PAGO_R' =   F.glosa
      ,'FORMA_PAGO_E' =   F.glosa
      ,'TASA_C_FON'   =   motctra
      ,'RES_T_C_FON'  =   ( SELECT (( SELECT vmvalor * momonmo FROM VIEW_VALOR_MONEDA WHERE vmcodigo = 994 AND vmfecha = mofech )
                            * (( motctra / 3600 ) * DATEDIFF( DD ,movaluta2 , movaluta1 ))  )   )  

      ,'RES_FINAL'    =   (SELECT ( ( SELECT vmvalor * motctra FROM VIEW_VALOR_MONEDA WHERE vmcodigo = 994 AND vmfecha = mofech ) 
                              - ( SELECT (( SELECT vmvalor * momonmo FROM VIEW_VALOR_MONEDA WHERE vmcodigo = 994 AND vmfecha = mofech )
                              * (( motctra / 3600 ) * DATEDIFF( DD ,movaluta2 , movaluta1 ))  )   )  ))


      ,'DESDE'        =   CONVERT(CHAR(10),@DESDE,103)
      ,'HASTA'        =   CONVERT(CHAR(10),@HASTA,103)
      ,'FECHA_PRO'    =   CONVERT( CHAR(10), ( SELECT acfecpro FROM MEAC ), 103 )
      ,'FECHA_SIS'    =   CONVERT( CHAR(10), GETDATE(), 103 )
      ,'FECHA_EMI'    =   CONVERT( CHAR(10), GETDATE(), 103 )
      ,'FECHA_INI'    =   CONVERT( CHAR(10), mofech, 103 )
      ,'HORA'         =   CONVERT( CHAR(10), GETDATE(), 108 )
      ,'OPERADOR'     =   @OPERADOR
      ,'nombreentidad'   =  (SELECT acnombre FROM meac) 

    FROM MEMO
        ,VIEW_FORMA_DE_PAGO F

   WHERE ( MOTIPMER = 'WEEK' OR MOTIPMER = 'OVER' )
     AND F.codigo =  moentre 
     AND F.codigo =  morecib
     AND mofech >= @DESDE
     AND mofech <= @HASTA
     AND @HASTA <= @XFECPROC
     and (MOESTATUS = ' ' OR MOESTATUS = 'M') 

END ELSE
BEGIN

   SELECT 
       'CLIENTE'      =   ''
      ,'NUMER_OPER'   =   ''
      ,'MONTO_ORIG'   =   ''      ,'DOLAR_OBSE'   =   ''
      ,'MONTO_USD'    =   ''
      ,'MONTO_CNV'    =   ''
      ,'MONTO_CLP'    =   ''      ,'TIPO_CAMB'    =   ''
      ,'INTERES'      =   ''
      ,'DIAS'         =   ''
      ,'VALUTA_ENTRE' =   ''
      ,'VALUTA_RECIB' =   ''
      ,'FORMA_PAGO_R' =   ''
      ,'FORMA_PAGO_E' =   ''
      ,'TASA_C_FON'   =   ''
      ,'RES_T_C_FON'  =   ''
      ,'RES_FINAL'    =   ''
      ,'DESDE'        =   CONVERT(CHAR(10),@DESDE,103)
      ,'HASTA'        =   CONVERT(CHAR(10),@HASTA,103)
      ,'FECHA_PRO'    =   CONVERT( CHAR(10), GETDATE(), 103 )
      ,'FECHA_SIS'    =   CONVERT( CHAR(10), GETDATE(), 103 )
      ,'FECHA_EMI'    =   CONVERT( CHAR(10), GETDATE(), 103 )
      ,'FECHA_INI'    =   CONVERT( CHAR(10), GETDATE(), 103 )
      ,'HORA'         =   CONVERT( CHAR(10), GETDATE(), 108 )
      ,'OPERADOR'     =   @OPERADOR

END

END
--   Intereses = Round(TxtMntOpera * ((TxtTir / 36000) * txtDias), 4)


-- Sp_Resultados_Over_Deposit 'ADMINISTRA','20020411','20020411'









GO
