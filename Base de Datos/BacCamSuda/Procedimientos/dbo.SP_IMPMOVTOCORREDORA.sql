USE [BacCamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_IMPMOVTOCORREDORA]    Script Date: 11-05-2022 16:43:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_IMPMOVTOCORREDORA]
                  (
                  @DESDE    datetime ='' ,
                  @HASTA    datetime ='' 
                  )
AS BEGIN
SET NOCOUNT ON
DECLARE @CONSULT     VARCHAR(255)
DECLARE @xNomprop    CHAR(50)
DECLARE @xRutprop    NUMERIC(09)
DECLARE @xDigprop    CHAR(01)
DECLARE 
        @ENTREGAMOS  CHAR(40),
        @RECIBIMOS   CHAR(40),
        @oma         CHAR(3),
        @FecDesde    DATETIME,
        @FecHasta    DATETIME

IF @DESDE = ''
   SELECT @FecDesde = ACFECPRO FROM MEAC
ELSE   
   SET @FecDesde = CONVERT(DATETIME, @DESDE)


IF @HASTA = ''
   SELECT @FecHasta = ACFECPRO FROM MEAC
ELSE
   SET @FecHasta = CONVERT(DATETIME, @HASTA)


   SELECT  @CONSULT = 'SELECT * FROM #temp1 ORDER BY TipoOpera,NombreCliente,NoOpera'

   SELECT 
          'TipoOpera'     = motipope,
          'NombreCliente' = a.clnombre,
          'Tacfecpro'     = mofech,
          'NoOpera'       = monumope,
          'MontoOpera'    = momonmo,
--          'MontoUSD'      = moussme,
          'TipoCamCie'    = moticam,
          'MontoCLP'      = momonpe,
--          'Usuario'       = mooper,
          'ENTREGAMOS'    = (SELECT GLOSA FROM VIEW_FORMA_DE_PAGO WHERE CODIGO = MOENTRE ),
          'RECIBIMOS'     = (SELECT GLOSA FROM VIEW_FORMA_DE_PAGO WHERE CODIGO = MORECIB)

   INTO #temp1
   FROM  memo                            ,
         BacParamSuda..cliente       AS a
   WHERE morutcli  =  a.clrut       AND
         mocodcli  =  a.clcodigo    AND
         a.cltipcli  = 4		and 
         motipmer  =  'EMPR'        AND
        (moestatus =  ' '           OR
         moestatus =  'M')          AND
         mofech    >= @FecDesde     AND
         mofech    <= @FecHasta

   UNION        

   SELECT 
          'TipoOpera'     = motipope,
          'NombreCliente' = a.clnombre,
          'Tacfecpro'     = mofech,
          'NoOpera'       = monumope,
          'MontoOpera'    = momonmo,
--          'MontoUSD'      = moussme,
          'TipoCamCie'    = moticam,
          'MontoCLP'      = momonpe,
--          'Usuario'       = mooper,
          'ENTREGAMOS'    = (SELECT GLOSA FROM VIEW_FORMA_DE_PAGO WHERE CODIGO = MOENTRE ),
          'RECIBIMOS'     = (SELECT GLOSA FROM VIEW_FORMA_DE_PAGO WHERE CODIGO = MORECIB)
   FROM  memoh                            ,
         BacParamSuda..cliente       AS a
   WHERE morutcli  =  a.clrut       AND
         mocodcli  =  a.clcodigo    AND
         a.cltipcli  = 4		and
         motipmer  =  'EMPR'        AND
        (moestatus =  ' '           OR
         moestatus =  'M')          AND
         mofech    >= @FecDesde     AND
         mofech    <= @FecHasta
   ORDER BY motipope

   EXECUTE (@CONSULT)

SET NOCOUNT OFF
END

GO
