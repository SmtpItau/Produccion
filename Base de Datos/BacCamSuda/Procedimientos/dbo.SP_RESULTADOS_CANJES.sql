USE [BacCamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_RESULTADOS_CANJES]    Script Date: 11-05-2022 16:43:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[SP_RESULTADOS_CANJES]
      (
          @OPERADOR      CHAR(30)
         ,@DESDE         CHAR(10)
         ,@HASTA         CHAR(10)
      )
AS
BEGIN
DECLARE @XFECPRO  DATETIME
       ,@FecDesde DATETIME
       ,@FecHasta DATETIME
SELECT @FecDesde = CONVERT(DATETIME,@DESDE)
SELECT @FecHasta = CONVERT(DATETIME,@HASTA)
IF EXISTS ( SELECT 1 FROM MEMO
                    WHERE motipmer   = 'CANJ')
--                      AND mofech >= @DESDE
--                      AND mofech <= @HASTA
--                      AND @HASTA <= @XFECPRO)
BEGIN
   SELECT 
       'CLIENTE'      =   monomcli
      ,'TIPO_OPERA'   =   motipope 
      ,'NUMER_OPER'   =   monumope
      ,'MONTO_ORIG'   =   momonmo
      ,'DOLAR_OBSE'   = ( SELECT acobser FROM MEAC )
      ,'MONTO_USD'    =   momonmo
      ,'MONTO_CNV'    =   mousstr
      ,'MONTO_CLP'    =   momonmo*motctra
      ,'TIPO_CAMB'    =   motctra 
      ,'TIPO_CNV'     =   moticam
      ,'INTERES'      =   ''
      ,'DIAS'         =   CASE  motipope WHEN 'C' THEN DATEDIFF( DD ,movaluta1 , movaluta2 )
                                         WHEN 'V' THEN DATEDIFF( DD ,movaluta2 , movaluta1 )
                          END
      ,'VALUTA_ENTRE' =   movaluta1
      ,'VALUTA_RECIB' =   movaluta2
      ,'FORMA_PAGO_R' =  isnull((SELECT  glosa FROM VIEW_FORMA_DE_PAGO WHERE  codigo =  moentre 
                                                                             AND  codigo =  morecib ),'')
      ,'FORMA_PAGO_E' =  isnull((SELECT  glosa FROM VIEW_FORMA_DE_PAGO WHERE  codigo =  moentre 
                                                                             AND  codigo =  morecib ),'')
      ,'TASA_C_FON'   =   ( SELECT mnredondeo FROM VIEW_MONEDA WHERE MNCODMON = 16 )
      ,'RES_T_C_FON'  =   (SELECT (( momonmo ) * ( SELECT V.vmvalor FROM VIEW_VALOR_MONEDA V  WHERE V.vmcodigo = 994 AND V.vmfecha = mofech )
                            * (( SELECT mnredondeo FROM VIEW_MONEDA WHERE MNCODMON = 16 ) / 3600 ) * DATEDIFF( DD ,movaluta1 , movaluta2 ) ))
      
      ,'RES_FINAL'    =   ''
      ,'DESDE'        =   CONVERT(CHAR(10),@FecDesde,103)
      ,'HASTA'        =   CONVERT(CHAR(10),@FecHasta,103)
      ,'FECHA_PRO'    =   CONVERT( CHAR(10), ( SELECT acfecpro FROM MEAC ), 103 )
      ,'FECHA_SIS'    =   CONVERT( CHAR(10), GETDATE(), 103 )
      ,'FECHA_EMI'    =   CONVERT( CHAR(10), GETDATE(), 103 )
      ,'FECHA_INI'    =   CONVERT( CHAR(10), mofech, 103 )
      ,'HORA'         =   CONVERT( CHAR(10), GETDATE(), 108 )
      ,'NOMBRE'	      =   ( SELECT acnombre FROM MEAC)
      ,'OPERADOR'     =   @OPERADOR
    FROM MEMO
   WHERE MOTIPMER = 'CANJ' and (MOESTATUS = ' ' OR MOESTATUS = 'M') 
--     AND mofech >= @DESDE
--     AND mofech <= @HASTA
--     AND @HASTA <= @XFECPRO
END ELSE
BEGIN
   SELECT 
       'CLIENTE'      =   ''
      ,'TIPO_OPERA'   =   ''
      ,'NUMER_OPER'   =   ''
      ,'MONTO_ORIG'   =   ''
      ,'DOLAR_OBSE'   =   ''
      ,'MONTO_USD'    =   ''
      ,'MONTO_CNV'    =   ''
      ,'MONTO_CLP'    =   ''
      ,'TIPO_CAMB'    =   ''
      ,'TIPO_CNV'     =   '' 
      ,'INTERES'      =   ''
      ,'DIAS'         =   ''
      ,'VALUTA_ENTRE' =   ''
      ,'VALUTA_RECIB' =   ''
      ,'FORMA_PAGO_R' =   ''
      ,'FORMA_PAGO_E' =   ''
      ,'TASA_C_FON'   =   ''
      ,'RES_T_C_FON'  =   0
      ,'RES_FINAL'    =   0
      ,'DESDE'        =   CONVERT(CHAR(10),@FecDesde,103)
      ,'HASTA'        =   CONVERT(CHAR(10),@FecHasta,103)
      ,'FECHA_PRO'    =   CONVERT( CHAR(10), (select acfecpro from meac) , 103 )
      ,'FECHA_SIS'    =   CONVERT( CHAR(10), GETDATE(), 103 )
      ,'FECHA_EMI'    =   CONVERT( CHAR(10), GETDATE(), 103 )
      ,'FECHA_INI'    =   CONVERT( CHAR(10), GETDATE(), 103 )
      ,'HORA'         =   CONVERT( CHAR(10), GETDATE(), 108 )
      ,'NOMBRE'	      =   ( SELECT acnombre FROM MEAC)
      ,'OPERADOR'     =   @OPERADOR
END
END
--   Intereses = Round(TxtMntOpera * ((TxtTir / 36000) * txtDias), 4)
--   
-- SELECT * FROM VIEW_MONEDA ORDER BY MNCODMON
-- SELECT * FROM VIEW_VALOR_MONEDA WHERE 
-- SELECT * FROM MEMO
-- Sp_Resultados_Canjes 'ADMINISTRA','20010214','20010214'







GO
