USE [BacCamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_RESULTADOS_OVER_DEPOSIT]    Script Date: 11-05-2022 16:43:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_RESULTADOS_OVER_DEPOSIT]
               (
                @OPERADOR      CHAR(30),
                @DESDE         CHAR(10),
                @HASTA         CHAR(10)
               )
AS BEGIN
SET NOCOUNT ON
DECLARE @XFECPROC DATETIME
DECLARE @XDESDE   DATETIME
DECLARE @XHASTA   DATETIME

   SELECT @XDESDE = @DESDE, 
          @XHASTA = @HASTA

   SELECT @XFECPROC = ACFECPRO FROM MEAC


   SELECT 'CLIENTE'      = monomcli
         ,'NUMER_OPER'   = monumope
         ,'MONTO_ORIG'   = momonmo
         ,'DOLAR_OBSE'   = (SELECT acobser FROM MEAC)
         ,'MONTO_USD'    = momonmo
         ,'MONTO_CNV'    = mousstr
         ,'MONTO_CLP'    = momonpe
         ,'TIPO_CAMB'    = moticam
         ,'INTERES'      = 0
         ,'DIAS'         = DATEDIFF(DD, movaluta2, movaluta1)
         ,'VALUTA_ENTRE' = movaluta1
         ,'VALUTA_RECIB' = movaluta2
         ,'FORMA_PAGO_R' = F.glosa
         ,'FORMA_PAGO_E' = F.glosa
         ,'TASA_C_FON'   = motctra
         ,'RES_T_C_FON'  = (SELECT((SELECT vmvalor * momonmo FROM VIEW_VALOR_MONEDA WHERE vmcodigo = 994 AND
                                                                                          vmfecha  = mofech)
                            * (( motctra/ 3600) * DATEDIFF(DD, movaluta2, movaluta1))))
         ,'RES_FINAL'    = (SELECT((SELECT vmvalor * motctra FROM VIEW_VALOR_MONEDA WHERE vmcodigo = 994 AND
                                                                                          vmfecha  = mofech)
                           - (SELECT((SELECT vmvalor * momonmo FROM VIEW_VALOR_MONEDA WHERE vmcodigo = 994 AND
                                                                                            vmfecha = mofech)
                           * ((motctra / 3600 ) * DATEDIFF(DD, movaluta2, movaluta1))))))
         ,'DESDE'        = CONVERT(CHAR(10), @XDESDE,103)
         ,'HASTA'        = CONVERT(CHAR(10), @XHASTA,103)
         ,'FECHA_PRO'    = CONVERT(CHAR(10), (SELECT acfecpro FROM MEAC ), 103)
         ,'FECHA_SIS'    = CONVERT(CHAR(10), GETDATE(), 103)
         ,'FECHA_EMI'    = CONVERT(CHAR(10), GETDATE(), 103)
         ,'FECHA_INI'    = CONVERT(CHAR(10), mofech, 103)
         ,'HORA'         = CONVERT(CHAR(10), GETDATE(), 108)
         ,'OPERADOR'     = @OPERADOR
   INTO #TEMPORAL
   FROM MEMO   ,
        VIEW_FORMA_DE_PAGO F
   WHERE (MOTIPMER  = 'WEEK'     OR
          MOTIPMER  = 'OVER')    AND
          F.codigo  =  moentre   AND
          F.codigo  =  morecib   AND 
          mofech   >=  @DESDE    AND
          mofech   <=  @HASTA    AND
          @HASTA   <=  @XFECPROC AND
         (MOESTATUS = ' '        OR
          MOESTATUS = 'M') 
   UNION

   SELECT 'CLIENTE'      = monomcli
         ,'NUMER_OPER'   = monumope
         ,'MONTO_ORIG'   = momonmo
         ,'DOLAR_OBSE'   = (SELECT acobser FROM MEAC)
         ,'MONTO_USD'    = momonmo
         ,'MONTO_CNV'    = mousstr
         ,'MONTO_CLP'    = momonpe
         ,'TIPO_CAMB'    = moticam
         ,'INTERES'      = 0
         ,'DIAS'         = DATEDIFF(DD, movaluta2, movaluta1)
         ,'VALUTA_ENTRE' = movaluta1
         ,'VALUTA_RECIB' = movaluta2
         ,'FORMA_PAGO_R' = F.glosa
         ,'FORMA_PAGO_E' = F.glosa
         ,'TASA_C_FON'   = motctra
         ,'RES_T_C_FON'  = (SELECT((SELECT vmvalor * momonmo FROM VIEW_VALOR_MONEDA WHERE vmcodigo = 994 AND
                                                                                          vmfecha  = mofech)
                            * (( motctra/ 3600) * DATEDIFF(DD, movaluta2, movaluta1))))
         ,'RES_FINAL'    = (SELECT((SELECT vmvalor * motctra FROM VIEW_VALOR_MONEDA WHERE vmcodigo = 994 AND
                                                                                          vmfecha  = mofech)
                           - (SELECT((SELECT vmvalor * momonmo FROM VIEW_VALOR_MONEDA WHERE vmcodigo = 994 AND
                                                                     vmfecha = mofech)
                           * ((motctra / 3600 ) * DATEDIFF(DD, movaluta2, movaluta1))))))
         ,'DESDE'        = CONVERT(CHAR(10), @XDESDE,103)
         ,'HASTA'        = CONVERT(CHAR(10), @XHASTA,103)
         ,'FECHA_PRO'    = CONVERT(CHAR(10), (SELECT acfecpro FROM MEAC ), 103)
         ,'FECHA_SIS'    = CONVERT(CHAR(10), GETDATE(), 103)
         ,'FECHA_EMI'    = CONVERT(CHAR(10), GETDATE(), 103)
         ,'FECHA_INI'    = CONVERT(CHAR(10), mofech, 103)
         ,'HORA'         = CONVERT(CHAR(10), GETDATE(), 108)
         ,'OPERADOR'     = @OPERADOR
   FROM MEMOH   ,
        VIEW_FORMA_DE_PAGO F
   WHERE (MOTIPMER  = 'WEEK'     OR
          MOTIPMER  = 'OVER')    AND
          F.codigo  =  moentre   AND
          F.codigo  =  morecib   AND 
          mofech   >=  @DESDE    AND
          mofech   <=  @HASTA    AND
          @HASTA   <=  @XFECPROC AND
         (MOESTATUS = ' '        OR
          MOESTATUS = 'M') 

   
   IF EXISTS(SELECT 1 FROM #TEMPORAL) BEGIN
         SELECT * FROM #TEMPORAL
   END ELSE BEGIN
      SELECT 'CLIENTE'      = ''
            ,'NUMER_OPER'   = ''
            ,'MONTO_ORIG'   = ''
            ,'DOLAR_OBSE'   = ''
            ,'MONTO_USD'    = ''
            ,'MONTO_CNV'    = ''
            ,'MONTO_CLP'    = ''
            ,'TIPO_CAMB'    = ''
            ,'INTERES'      = ''
            ,'DIAS'         = ''
            ,'VALUTA_ENTRE' = ''
            ,'VALUTA_RECIB' = ''
            ,'FORMA_PAGO_R' = ''
            ,'FORMA_PAGO_E' = ''
            ,'TASA_C_FON'   = ''
            ,'RES_T_C_FON'  = ''
            ,'RES_FINAL'    = ''
            ,'DESDE'        = CONVERT(CHAR(10),@XDESDE,103)
            ,'HASTA'        = CONVERT(CHAR(10),@XHASTA,103)
            ,'FECHA_PRO'    = CONVERT(CHAR(10), GETDATE(), 103)
            ,'FECHA_SIS'    = CONVERT(CHAR(10), GETDATE(), 103)
            ,'FECHA_EMI'    = CONVERT(CHAR(10), GETDATE(), 103)
            ,'FECHA_INI'    = CONVERT(CHAR(10), GETDATE(), 103)
            ,'HORA'         = CONVERT(CHAR(10), GETDATE(), 108)
            ,'OPERADOR'     = @OPERADOR
   END
END


GO
