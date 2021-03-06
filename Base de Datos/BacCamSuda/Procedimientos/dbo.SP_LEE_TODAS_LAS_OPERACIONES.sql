USE [BacCamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_LEE_TODAS_LAS_OPERACIONES]    Script Date: 11-05-2022 16:43:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[SP_LEE_TODAS_LAS_OPERACIONES] 
(
	@rutcli     	INT           = 0,
	@tipmerc    	CHAR(4)       = '',
	@entidad    	INT           = 0,
	@numoper    	INT           = 0,
	@cestado    	CHAR(03)      ='*',
	@origen			CHAR(15)      = '',
	@operador		CHAR(15)      = '',
	@tipoper    	CHAR(3)       = '',
	@mtoini			NUMERIC(19,4) = 0,
	@mtofin			NUMERIC(19,4) = 0,
	@tcamini		NUMERIC(19,4) = 0,
	@tcamfin        NUMERIC(19,4) = 0
)

AS

BEGIN

	IF @cestado= 'APR' set @cestado=''
	IF @cestado= 'PEN' set @cestado='P'
	IF @cestado= 'REC' set @cestado='R'
	IF @cestado= 'ANU' set @cestado='A'
	IF @cestado= 'MOD' set @cestado='M'

	SELECT motipope,
	       motipmer,
		   monumope,
		   monomcli,
		   momonmo,
		   moticam,
		   motctra,
		   moparme,
		   mopartr,
		   momonpe,
		   mocodmon,
		   mocodcnv,
		   mooper,
		   mohora,
		   'tipope'      = (CASE motipope WHEN 'C' THEN 'Compra' ELSE 'Venta' END),
		   'moestatus'   = (CASE moestatus WHEN 'P' THEN 'Pendiente' WHEN 'R' THEN 'Rechazada' WHEN 'A' THEN 'Anulada' ELSE 'Aprobada' END),
		   'entregamos'  = b.glosa,                       
		   'recibimos'   = c.glosa,
		   'fecha'       = CONVERT(CHAR(10),acfecpro,103),
		   'RazonSocial' = (SELECT RazonSocial FROM BacParamSuda..Contratos_ParametrosGenerales)
	  FROM memo,
	       VIEW_FORMA_DE_PAGO b,
		   VIEW_FORMA_DE_PAGO c,
		   meac
     WHERE morecib = b.codigo
	   AND moentre = c.codigo
	   AND @rutcli   IN(morutcli,0) 
	   AND @tipmerc  IN (motipmer, '')
	   AND @entidad  IN (moentidad,0)
	   AND @numoper  IN(monumope, 0)
	   AND @cestado  IN(moestatus, '*')
	   AND @origen   IN(moterm, '')
	   AND @operador IN(mooper, '')
	   AND @tipoper  IN(motipope, '')
	   AND (@mtoini  > @mtofin  OR momonmo BETWEEN @mtoini  AND @mtofin)
	   AND (@tcamini > @tcamfin OR moticam BETWEEN @tcamini AND @tcamfin)
  ORDER BY monomcli,
           motipmer,
		   moestatus,
		   motipope,
		   mocodmon,
		   mocodcnv,
		   morecib,
		   moentre,
		   monumope

END

RETURN
GO
