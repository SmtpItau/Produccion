USE [BacCamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_INF_OVER_TIME_DEPOSIT]    Script Date: 11-05-2022 16:43:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_INF_OVER_TIME_DEPOSIT]
            (
            @OPERADOR      CHAR(30)  ,
            @DESDE         CHAR(8)   ,
            @HASTA         CHAR(8)
            )
AS BEGIN
SET NOCOUNT ON

DECLARE @xFECPRO DATETIME
       ,@FecDesde DATETIME
       ,@FecHasta DATETIME
   
   SELECT @FecDesde = CONVERT(DATETIME,@DESDE),
          @FecHasta = CONVERT(DATETIME,@HASTA),
          @xFECPRO  = ACFECPRO
   FROM MEAC

   SELECT 'CLIENTE'         =   monomcli
         ,'MOFECH'          =   mofech
         ,'NUMERO_OPERA'    =   monumope
         ,'MONTO_ORI'       =   momonmo
         ,'MONTO_USD'       =   momonmo
         ,'MONTO_CNV'       =   mousstr
         ,'MONTO_CLP'       =   momonpe
         ,'TIP_CAM'         =   moticam
         ,'PARIDAD'         =   moparme
         ,'VALUTA_ENTRE'    =   movaluta1
         ,'VALUTA_RECIB'    =   movaluta2
         ,'FORMA_PAGO_R'    =   ' ' --g.glosa
         ,'FORMA_PAGO_E'    =   ' ' --F.glosa
         ,'DIAS'            =   modias--DATEDIFF(DAY , movaluta2, movaluta1)
         ,'FECHA_SISTEMA'   =   CONVERT(CHAR(10), GETDATE(), 103)
         ,'FECHA_PROCESO'   =   CONVERT(CHAR(10), @xFECPRO, 103)
         ,'FECHA_OPERACION' =   CONVERT(CHAR(10), mofech, 103)
         ,'HORA'            =   CONVERT(CHAR(10), GETDATE(), 108)
         ,'OPERADOR'        =   @OPERADOR
         ,'DESDE'           =   CONVERT(CHAR(10),@FecDesde,103)
         ,'HASTA'           =   CONVERT(CHAR(10),@FecHasta,103)
         ,'TIP_MER'         =   motipmer
    INTO #TEMPORAL
    FROM MEMO
    WHERE (MOTIPMER   = 'WEEK' OR
           MOTIPMER   = 'OVER')AND
           mofech    >= @DESDE AND
           mofech    <= @HASTA AND
          (MOESTATUS  = ' '    OR
           MOESTATUS  = 'M')
   UNION
   SELECT 'CLIENTE'         =   monomcli
         ,'MOFECH'          =   mofech
         ,'NUMERO_OPERA'    =   monumope
         ,'MONTO_ORI'       =   momonmo
         ,'MONTO_USD'       =   momonmo
         ,'MONTO_CNV'       =   mousstr
         ,'MONTO_CLP'       =   momonpe
         ,'TIP_CAM'         =   moticam
         ,'PARIDAD'         =   moparme
         ,'VALUTA_ENTRE'    =   movaluta1
         ,'VALUTA_RECIB'    =   movaluta2
         ,'FORMA_PAGO_R'    =   ' ' --g.glosa
         ,'FORMA_PAGO_E'    =   ' ' --F.glosa
         ,'DIAS'            =   modias--DATEDIFF(DD , movaluta2, movaluta1)
         ,'FECHA_SISTEMA'   =   CONVERT(CHAR(10), GETDATE(), 103)
         ,'FECHA_PROCESO'   =   CONVERT(CHAR(10), @xFECPRO, 103)
         ,'FECHA_OPERACION' =   CONVERT(CHAR(10), mofech, 103)
         ,'HORA'            =   CONVERT(CHAR(10), GETDATE(), 108)
         ,'OPERADOR'        =   @OPERADOR
         ,'DESDE'           =   CONVERT(CHAR(10),@FecDesde,103)
         ,'HASTA'           =   CONVERT(CHAR(10),@FecHasta,103)
         ,'TIP_MER'         =   motipmer
    FROM MEMOH
    WHERE (MOTIPMER   = 'WEEK' OR
           MOTIPMER   = 'OVER')AND
           mofech    >= @DESDE AND
           mofech    <= @HASTA AND
          (MOESTATUS  = ' '    OR
           MOESTATUS  = 'M')

	ORDER BY MOFECH

   IF EXISTS(SELECT 1 FROM #TEMPORAL) BEGIN
         SELECT * FROM #TEMPORAL
   END ELSE BEGIN
      SELECT 'CLIENTE'         = ''
            ,'MOFECH'          = ''
            ,'NUMERO_OPERA'    = ''
            ,'MONTO_ORI'       = ''
            ,'MONTO_USD'       = ''
            ,'MONTO_CNV'       = ''
            ,'MONTO_CLP'       = ''
            ,'TIP_CAM'         = ''
            ,'PARIDAD'         = ''
            ,'VALUTA_ENTRE'    = ''
            ,'VALUTA_RECIB'    = ''
            ,'FORMA_PAGO_R'    = ''
            ,'FORMA_PAGO_E'    = ''
            ,'DIAS'            = ''
            ,'FECHA_SISTEMA'   = CONVERT(CHAR(10), GETDATE(), 103)
            ,'FECHA_PROCESO'   = CONVERT(CHAR(10), @xFECPRO , 103)
            ,'FECHA_OPERACION' = CONVERT(CHAR(10), GETDATE(), 103)
            ,'HORA'            = CONVERT(CHAR(10), GETDATE(), 108)
            ,'OPERADOR'        = @OPERADOR
            ,'DESDE'           = CONVERT(CHAR(10),@FecDesde,103)
            ,'HASTA'           = CONVERT(CHAR(10),@FecHasta,103)
            ,'TIP_MER'         = ''
   END
SET NOCOUNT ON
END

GO
