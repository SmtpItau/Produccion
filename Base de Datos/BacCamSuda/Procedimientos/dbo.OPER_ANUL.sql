USE [BacCamSuda]
GO
/****** Object:  StoredProcedure [dbo].[OPER_ANUL]    Script Date: 11-05-2022 16:43:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- EXEC OPER_ANUL

/****** Object:  Stored Procedure dbo.OPER_ANUL    Script Date: 06-01-2011 16:41:21 ******/
CREATE PROCEDURE [dbo].[OPER_ANUL]
AS 
BEGIN

DECLARE @COUNT INT
SET @COUNT = (SELECT COUNT(moestatus) FROM memo WHERE moestatus = 'A')

IF @COUNT > 0
BEGIN


SELECT moestatus,
       monumope,
       motipmer,
       monomcli,
       mocodmon,
       mocodcnv,
       momonmo,
       moticam,
       mopartr,
       'recibe'=ISNULL(a.glosa,''),
       'entrega'=ISNULL(b.glosa,''),
       mohora,
       autorizador_limite,
       Hora_Proc= CONVERT(CHAR(08),GETDATE(),108),
       'FecPro'=CONVERT(CHAR(10),mofech,103),
	   'RazonSocial' = (SELECT RazonSocial FROM BacParamSuda..Contratos_ParametrosGenerales)
FROM  memo LEFT OUTER JOIN view_forma_de_pago a ON morecib = a.codigo 
       LEFT OUTER JOIN view_forma_de_pago b ON moentre = b.codigo
WHERE moestatus = 'A'

END

ELSE

BEGIN

	SELECT moestatus = ' ',
       monumope = 0,
       motipmer = ' ',
       monomcli = ' ',
       mocodmon = ' ',
       mocodcnv = ' ',
       momonmo = 0,
       moticam  = 0,
       mopartr  = 0,
       'recibe' = ' ',
       'entrega' = ' ',
       mohora = ' ',
       autorizador_limite = ' ',
       Hora_Proc  = ' ',
       'FecPro'=  ' ',
	   'RazonSocial' = (SELECT RazonSocial FROM BacParamSuda..Contratos_ParametrosGenerales)
END

/* REQ.7619 CASS 
FROM memo,
       view_forma_de_pago a,
       view_forma_de_pago b
 WHERE (morecib*=a.codigo and moentre*=b.codigo) and 
       moestatus = 'A'
*/  
END 
-- SELECT * FROM MEMO
GO
