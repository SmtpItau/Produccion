USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[FUSION_SP_ContratoCondicionesGenerales]    Script Date: 13-05-2022 10:53:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[FUSION_SP_ContratoCondicionesGenerales]
AS
BEGIN
	  -- Query para eliminar los registros con el mismo rut y tomar solo los que tienen mayor fecha Emitida
	  SELECT  rut,MAX(fecha_ccgEmitido) AS fecha_ccgEmitido 
	  INTO #tmpFiltroReg
	  FROM FUSION_Contrato_CondicionesGenerales 
	  GROUP BY rut

	DELETE FUSION_Contrato_CondicionesGenerales_migracionClientes


	INSERT INTO FUSION_Contrato_CondicionesGenerales_migracionClientes 
	(partyAgreementName, extPartyRut,extPartyDv,estadoPartyAgreement, estadoPartyAgreementInfo, excepcion,fechaEmitido, fechaRecibido, fechaCustodia, codigo_cliente  )
	SELECT    'partyAgreementName'       = ''
			, 'extPartyRut'              =  c.rutCliente --CASE WHEN c.Clrut = 76762250 THEN 77777777 ELSE (CASE WHEN c.Clrut = 77648350 THEN 88888888 ELSE  c.Clrut END) END   -- c.Clrut  -- Rut Sin Digito Verificador contraparte externa
			, 'extPartyDv'               =  c.dvCliente  --CASE WHEN c.Clrut = 76762250 THEN '7'      ELSE (CASE WHEN  c.Clrut = 77648350 THEN '8' ELSE   c.Cldv END) END  --c.Cldv -- Digito Verificador del Rut contraparte externa
			, 'estadoPartyAgreement'     = 0		-- c.Clcodigo
			, 'estadoPartyAgreementInfo' = estCG.id --ID ESTADO
			, 'exepcion'                 = 'NO'
			, 'fechaEmitido'             = ISNULL(ccg.fecha_ccgEmitido,'')
			, 'fechaRecibido'            = ISNULL(ccg.fecha_recepcion,'')
	     	, 'fechaCustodia'            = ISNULL(ccg.fecha_recepcion,'')
			, 'codigo_cliente'           = c.codigoClienteCorpbanca
	 	--	, 'estado'                   = estCG.id
	FROM    (SELECT   ISNULL(CONVERT(VARCHAR(20), taxId.ID_CLI_EMP)
					, CASE WHEN (PATINDEX('%-%', cli.rut)) > 0 THEN SUBSTRING(cli.rut, 1, CHARINDEX('-', cli.rut) - 1) 
															   ELSE SUBSTRING(cli.rut, CHARINDEX('-', cli.rut) + 1, LEN(cli.rut)) END) AS rut_ccg
					, cli.fecha_ccgEmitido
					, cli.fecha_recepcion
					,'estado_ccg' = CASE WHEN estado_ccg  = 'RECIBIDO EXCP' THEN 'RECIBIDO' ELSE estado_ccg END  
					FROM  dbo.FUSION_Contrato_CondicionesGenerales AS cli
					    INNER JOIN  #tmpFiltroReg reg ON cli.rut = reg.rut AND cli.fecha_ccgEmitido = reg.fecha_ccgEmitido
					    LEFT OUTER JOIN  BDDW.dbo.DJB_TA_GNL_CLI_TAXID AS taxId ON cli.rut = taxId.TAXID_CLI) AS ccg RIGHT OUTER JOIN
			 dbo.FUSION_ClientesFindur AS c ON ccg.rut_ccg = CONVERT(VARCHAR(10), c.rutCliente) LEFT OUTER JOIN
			 FUSION_USER_Estados_CG estCG  ON RTRIM(estCG.descripcion) = RTRIM(ccg.estado_ccg)    
			
END


GO
