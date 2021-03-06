USE [BacCamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_INF_PUNTAS]    Script Date: 11-05-2022 16:43:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

--EXEC SP_INF_PUNTAS '20160202', '20160202'

CREATE PROCEDURE [dbo].[SP_INF_PUNTAS]
               (
               @FECHA_DESDE   CHAR(10),
               @FECHA_HASTA   CHAR(10)
               )
AS BEGIN
SET NOCOUNT ON
DECLARE @FECHA_DESDE_DAT DATETIME
DECLARE @FECHA_HASTA_DAT DATETIME

   SELECT @FECHA_DESDE_DAT = @FECHA_DESDE,
          @FECHA_HASTA_DAT = @FECHA_HASTA

      CREATE TABLE #INF_PUNTAS
                  (
                  MOTIPMER   CHAR(04)
                 ,MONUMOPE   NUMERIC(07)
                 ,MOTIPOPE   CHAR(01)
                 ,MONOMCLI   CHAR(35)
                 ,MOCODMON   CHAR(03)
                 ,MOCODCNV   CHAR(03)
                 ,MOMONMO    NUMERIC(19,4)
                 ,MOTICAM    NUMERIC(19,4)
                 ,MOPARME    NUMERIC(19,8)
                 ,ENTREGAMOS CHAR(30)
                 ,RECIBIMOS  CHAR(30)
                 ,MOHORA     CHAR(08)
                 ,HORA       CHAR(08)
                 ,MOFECH     DATETIME
                 ,MOESTATUS  CHAR(01)
                 ,MOUSSME    NUMERIC(19,4)
                 ,MOMONPE    NUMERIC(19,4)
                  )

      INSERT INTO #INF_PUNTAS
      SELECT MOTIPMER ,
             MONUMOPE ,
             MOTIPOPE ,
             MONOMCLI ,
             MOCODMON ,
             MOCODCNV ,
             MOMONMO  ,
             MOTICAM  ,
             MOPARME  ,
             'ENTREGAMOS' = (SELECT GLOSA FROM VIEW_FORMA_DE_PAGO WHERE CODIGO = MOENTRE),
             'RECIBIMOS'  = (SELECT GLOSA FROM VIEW_FORMA_DE_PAGO WHERE CODIGO = MORECIB),
             MOHORA  ,
             HORA  = RIGHT(GETDATE(),8),
             MOFECH  ,
             MOESTATUS ,
             MOUSSME  ,
             MOMONPE
      FROM   MEMO
      WHERE  MOTIPMER  =  'PTAS'       AND
            (MOESTATUS =  'M'          OR
             MOESTATUS =  ' ')         AND
            (mofech    >= @FECHA_DESDE_DAT AND
             mofech    <= @FECHA_HASTA_DAT)
      ORDER BY MONUMOPE

      -- CANJES COMPRA
      INSERT INTO #INF_PUNTAS
      SELECT MOTIPMER ,
             MONUMOPE ,
             'C'      ,
             MONOMCLI ,
             MOCODMON ,
             MOCODCNV ,
             MOMONMO  ,
             MOTCTRA  ,
             MOPARME  ,
             'ENTREGAMOS' = (SELECT GLOSA FROM VIEW_FORMA_DE_PAGO WHERE CODIGO = MOENTRE),
             'RECIBIMOS' = (SELECT GLOSA FROM VIEW_FORMA_DE_PAGO WHERE CODIGO = MORECIB),
             MOHORA  ,
             HORA  = RIGHT(GETDATE(),8),
             MOFECH  ,
             MOESTATUS ,
             MOUSSME  ,
             MOMONMO*MOTCTRA
      FROM MEMO
      WHERE  MOTIPMER  = 'CANJ'        AND
            (MOESTATUS = 'M'           OR
             MOESTATUS = ' ')          AND
            (mofech    >= @FECHA_DESDE_DAT AND
             mofech    <= @FECHA_HASTA_DAT)
      ORDER BY MONUMOPE

      -- CANJES VENTA
      INSERT INTO #INF_PUNTAS
      SELECT MOTIPMER ,
             MONUMOPE ,
             'V'  ,
             MONOMCLI ,
             MOCODMON ,
             MOCODCNV ,
             MOMONMO  ,
             MOTICAM  ,
             MOPARME  ,
             'ENTREGAMOS' = (SELECT GLOSA FROM VIEW_FORMA_DE_PAGO WHERE CODIGO = FORMA_PAGO_CLI_EXT),
             'RECIBIMOS' = (SELECT GLOSA FROM VIEW_FORMA_DE_PAGO WHERE CODIGO = FORMA_PAGO_CLI_NAC),
             MOHORA  ,
             HORA  = RIGHT(GETDATE(),8),
             MOFECH  ,
             MOESTATUS ,
             MOUSSME  ,
             MOMONPE
      FROM   MEMO
      WHERE  MOTIPMER  = 'CANJ'        AND
            (MOESTATUS = 'M'           OR
             MOESTATUS = ' ')          AND
            (mofech    >= @FECHA_DESDE_DAT AND
             mofech    <= @FECHA_HASTA_DAT)
      ORDER BY MONUMOPE

      /**********************************************************************/
      /**** PARTE HISTORICA *************************************************/
      /**********************************************************************/
      INSERT INTO #INF_PUNTAS
      SELECT MOTIPMER ,
             MONUMOPE ,
             MOTIPOPE ,
             MONOMCLI ,
             MOCODMON ,
             MOCODCNV ,
             MOMONMO  ,
             MOTICAM  ,
             MOPARME  ,
             'ENTREGAMOS' = (SELECT GLOSA FROM VIEW_FORMA_DE_PAGO WHERE CODIGO = MOENTRE),
             'RECIBIMOS' = (SELECT GLOSA FROM VIEW_FORMA_DE_PAGO WHERE CODIGO = MORECIB),
             MOHORA  ,
             HORA  = RIGHT(GETDATE(),8),
             MOFECH  ,
             MOESTATUS ,
             MOUSSME  ,
             MOMONPE
      FROM   MEMOH
      WHERE  MOTIPMER  =  'PTAS'       AND
            (MOESTATUS =  'M'          OR
             MOESTATUS =  ' ')         AND
            (mofech    >= @FECHA_DESDE_DAT AND
             mofech    <= @FECHA_HASTA_DAT) and monumope NOT IN(SELECT MONUMOPE FROM #INF_PUNTAS)
      ORDER BY MONUMOPE

      -- CANJES COMPRA
      INSERT INTO #INF_PUNTAS
      SELECT MOTIPMER ,
             MONUMOPE ,
             'C'      ,
             MONOMCLI ,
             MOCODMON ,
             MOCODCNV ,
             MOMONMO  ,
             MOTCTRA  ,
             MOPARME  ,
             'ENTREGAMOS' = (SELECT GLOSA FROM VIEW_FORMA_DE_PAGO WHERE CODIGO = MOENTRE),
             'RECIBIMOS' = (SELECT GLOSA FROM VIEW_FORMA_DE_PAGO WHERE CODIGO = MORECIB),
             MOHORA  ,
             HORA  = RIGHT(GETDATE(),8),
             MOFECH  ,
             MOESTATUS ,
             MOUSSME  ,
             MOMONMO*MOTCTRA
      FROM MEMOH
      WHERE  MOTIPMER  = 'CANJ'        AND
            (MOESTATUS = 'M'           OR
             MOESTATUS = ' ')          AND
            (mofech    >= @FECHA_DESDE_DAT AND
             mofech    <= @FECHA_HASTA_DAT) and monumope NOT IN(SELECT MONUMOPE FROM #INF_PUNTAS)
      ORDER BY MONUMOPE

      -- CANJES VENTA
      INSERT INTO #INF_PUNTAS
      SELECT MOTIPMER ,
             MONUMOPE ,
             'V'  ,
             MONOMCLI ,
             MOCODMON ,
             MOCODCNV ,
             MOMONMO  ,
             MOTICAM  ,
             MOPARME  ,
             'ENTREGAMOS' = (SELECT GLOSA FROM VIEW_FORMA_DE_PAGO WHERE CODIGO = FORMA_PAGO_CLI_EXT),
             'RECIBIMOS' = (SELECT GLOSA FROM VIEW_FORMA_DE_PAGO WHERE CODIGO = FORMA_PAGO_CLI_NAC),
             MOHORA  ,
             HORA  = RIGHT(GETDATE(),8),
             MOFECH  ,
             MOESTATUS ,
             MOUSSME  ,
             MOMONPE
      FROM   MEMOH
      WHERE  MOTIPMER  = 'CANJ'        AND
            (MOESTATUS = 'M'           OR
             MOESTATUS = ' ')          AND
            (mofech    >= @FECHA_DESDE_DAT AND
             mofech    <= @FECHA_HASTA_DAT) and monumope NOT IN(SELECT MONUMOPE FROM #INF_PUNTAS)
      ORDER BY MONUMOPE


	DECLARE @CONT INT
	SET @CONT = (SELECT COUNT(*) FROM #INF_PUNTAS)

	IF @CONT > 0
	  BEGIN

		   SELECT *   ,
				 'fecha_desde' = CONVERT(CHAR(10), @FECHA_DESDE_DAT, 103),
				 'fecha_hasta' = CONVERT(CHAR(10),@FECHA_HASTA_DAT, 103),
				 'RazonSocial' = (SELECT RazonSocial FROM BacParamSuda..Contratos_ParametrosGenerales)
		   FROM #INF_PUNTAS

      END

   ELSE
      BEGIN

		   SELECT 
		          MOTIPMER   = ' '
                 ,MONUMOPE   = 0
                 ,MOTIPOPE   = ' '
                 ,MONOMCLI   = ' '
                 ,MOCODMON   = ' '
                 ,MOCODCNV   = ' '
                 ,MOMONMO    = 0
                 ,MOTICAM    = 0
                 ,MOPARME    = 0
                 ,ENTREGAMOS = ' '
                 ,RECIBIMOS  = ' '
                 ,MOHORA     = ' '
                 ,HORA       = ' '
                 ,MOFECH     = '01-01-1900'
                 ,MOESTATUS  = ' '
                 ,MOUSSME    = 0
                 ,MOMONPE    = 0	
				 ,'fecha_desde' = '01-01-1900'
				 ,'fecha_hasta' = '01-01-1900'
				 ,'RazonSocial' = (SELECT RazonSocial FROM BacParamSuda..Contratos_ParametrosGenerales)

	  END

SET NOCOUNT OFF
END

GO
