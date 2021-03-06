USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[FUSION_SP_ExtractorClientesparaFindur]    Script Date: 13-05-2022 10:53:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[FUSION_SP_ExtractorClientesparaFindur]
AS 
BEGIN 

/*----------------------------------------------------------------------
AUTOR          : Sandra Vásquez
CAMBIOS        : Se descartan para Spot los rut que se encuentren en la query:
				- Correo : 28/03/2016 12:31

				   select monumope, morutcli, mocodcli, monomcli, motipmer, motipope, momonmo, mocodmon, moussme, momonpe
				   from   baccamsuda.dbo.MEMOH 
				   where  motipmer  = 'ccbb' and moterm = 'CORREDORA'   
				   and    moestatus = ''
				   and    morutcli  not in(96665450, 97023000)		 
----------------------------------------------------------------------*/



	DECLARE  @FechaProceso CHAR(6)

	SELECT @FechaProceso = LEFT(CONVERT(CHAR(8),acfecproc,112),6) 
	FROM Bacfwdsuda..mfac WITH (NOLOCK)

	DECLARE @TRVL TABLE (RUT INT, COD INT)

	

	INSERT INTO @TRVL 
	SELECT DISTINCT cacodigo, CACODCLI           FROM BacFwdSuda.dbo.mfcaH WHERE cafecvcto > '2014-01-01'
												 
	INSERT INTO @TRVL							 
	SELECT DISTINCT rut_cliente, codigo_cliente  FROM BaCSWAPSUDA.dbo.Carterahis WHERE numero_flujo = 1 AND fecha_termino>'2014-01-01'
	
												 
	INSERT INTO @TRVL		
	SELECT DISTINCT spot.MORUTCLI, spot.MOCODCLI
	FROM            BacCamSuda.dbo.memoh AS spot LEFT OUTER JOIN
					(SELECT        MONUMOPE, MORUTCLI, MOCODCLI, MONOMCLI, MOTIPMER, MOTIPOPE, MOMONMO, MOCODMON, MOUSSME, MOMONPE
					 FROM            BacCamSuda.dbo.memoh
					 WHERE        (MOTIPMER = 'ccbb') AND (MOTERM = 'CORREDORA') AND (MOESTATUS = '') AND (MORUTCLI NOT IN (96665450, 97023000))) AS descartCli ON 
				     spot.MORUTCLI = descartCli.MORUTCLI AND spot.MOCODCLI = descartCli.MOCODCLI
	WHERE        (descartCli.MORUTCLI IS NULL) AND (descartCli.MONUMOPE IS NULL)					 
	

										 
	INSERT INTO @TRVL       					 
	SELECT DISTINCT MoRutCliente, MOCODIGO       FROM CbMdbOpc.dbo.MoHisEncContrato



--- Datos Clientes (13258 - reg. Clientes) ------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------------------------------
	 SELECT  'Clrut' = Clrut --CASE WHEN Clrut = 76762250 THEN 77777777  ELSE (CASE WHEN Clrut = 77648350 THEN 88888888 ELSE  Clrut END) END   --OR Clrut = 77648350 THEN 77777777  ELSE Clrut END
			,'Cldv'  = Cldv -- CASE WHEN Clrut = 76762250 THEN '7'        ELSE (CASE WHEN Clrut = 77648350 THEN '8' ELSE  Cldv END) END  
			, Clcodigo
			, ROW_NUMBER() OVER(PARTITION BY Clrut ORDER BY Clrut)  AS secuencia
			, RTRIM(Clnombre) AS Clnombre
			, RTRIM(Cldirecc) AS Cldirecc
			, com.codigo_comuna
			, Clcomuna 
			, com.nombre
			, Clfono
			, Bloqueado
			, motivo_bloqueo
			, ClVigente
			, ClCompBilateral
			, ClRecMtdCod
			, RecMtdDsc
			, 'derivados'			= clCondicionesGenerales 
			, 'fechaFirmaDerivados' = clFechaFirma_cond 
			, 'pactos'			    = CASE WHEN FechaFirmaCG_Pactos > '1900-01-01 ' THEN 'S' ELSE 'N' END -- SI la fecha es mayor a tiene Firma = 'S'  AS PACTO
			, 'fechaFirmaPactos'    = FechaFirmaCG_Pactos
			, Cod_Inst
			, Clcalidadjuridica
			, Clmercado
			, clcodban 
			, EMAIL 
			, ComDer
			, Clactivida
			, Clclsbif
			, seg_comercial
			, ClPais 
			, Cltipcli
			, clCondicionesGenerales
			, 'tipoCliente'		=  CASE WHEN cltipcli =  8 then 'N' ELSE 'J' END
	  INTO  #tmpCliente
	 FROM dbo.Cliente c WITH (NOLOCK) INNER JOIN 
	 (SELECT DISTINCT RUT, MIN(COD) AS COD FROM  @TRVL  GROUP BY RUT) AS cf ON cf.RUT = c.Clrut AND cf.COD = c.Clcodigo 
	 LEFT OUTER JOIN  dbo.COMUNA  com  WITH (NOLOCK) ON c.Clcomuna = com.codigo_comuna 
	 INNER JOIN BacLineas.dbo.TBL_METODOLOGIAREC met  WITH (NOLOCK) ON c.ClRecMtdCod = met.RecMtdCod 
	 LEFT OUTER JOIN dbo.TABLA_GENERAL_DETALLE	tgd WITH (nolock)  ON c.Cltipcli = tgd.tbcodigo1
	 WHERE        (tgd.tbcateg = 72)
     ORDER BY c.clnombre

--- Institucion Financiera ----------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------
	SELECT tbcateg, tbcodigo1,tbtasa, tbglosa, nemo 
	INTO   #tmpInstitucionFinanciera
	FROM     dbo.TABLA_GENERAL_DETALLE WITH (NOLOCK)
	WHERE    tbcateg = 72 


---------- Calidad Juridica----------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------
	SELECT tbcateg, tbcodigo1, tbglosa, nemo 
	INTO   #tmpCalidadJuridica
	FROM    dbo.TABLA_GENERAL_DETALLE WITH (NOLOCK)
	WHERE   tbcateg = 39 

-------Actividad Económica----------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------
	SELECT tbcateg, tbcodigo1, tbglosa, nemo 
	INTO  #tmpActEconomica
	FROM   dbo.TABLA_GENERAL_DETALLE WITH (NOLOCK)
	WHERE  tbcateg = 13 

-----Clasificación Riesgo Crédito----------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------
	SELECT tbcateg, tbcodigo1, tbglosa, nemo 
	INTO	#tmpRiesgoCred
	FROM    dbo.TABLA_GENERAL_DETALLE WITH (NOLOCK)
	WHERE   tbcateg = 103    

-----Segmento-----------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------
	SELECT SgmCod, SgmNem, SgmDesc
	INTO  #tmpSegmento
	FROM   dbo.TBL_SEGMENTOSCOMERCIALES WITH (NOLOCK)

----------Apoderados----------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------
	SELECT    Id,  aprutcli ,apnombre , (aprutapo + apdvapo) as rutApoderado
    INTO #tmpApoderados
	FROM   ( SELECT   ROW_NUMBER() OVER(PARTITION BY aprutcli ORDER BY aprutcli) AS Id
						   ,aprutcli ,  apdvcli, apcodcli,  CONVERT(VARCHAR(10),aprutapo) AS aprutapo,apdvapo, apnombre
					FROM    dbo.CLIENTE_APODERADO WITH (NOLOCK)
				) AS seq
	WHERE Id   BETWEEN 1 AND 4
    ORDER BY aprutcli
	
-----Mercado------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------
	SELECT  tbcodigo1, tbglosa
	INTO   #tmpMercado
	FROM   dbo.TABLA_GENERAL_DETALLE WITH (nolock) 
	WHERE  tbcateg = 202


----------------------------------RELACIONADOS--------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------
-- RELACIÓN_1 --> se carga los del archivo I02
	SELECT  Id_Cli_Emp, Nombre, id_Cli_Codigo_Emp
		  , Tipo_Relacion_Con_Contraparte = Relacion_SII 
		  , Gls_Tip_Rel, ORIGENINFORMACION
	INTO #relacion_1 
	FROM BDDW.dbo.DJB_RUT_RELACIONADOS RR  WITH (NOLOCK)                    
	    LEFT JOIN  BDDW.dbo.DJB_TIP_REL_CNT_SII WITH (nolock)  on Cod_Tip_Rel = Relacion_SII
	WHERE RR.Prioridad = 2  and ANNO_MES = @FechaProceso

-- RELACIÓN_2 --> Lo anterior se pisa con lo del I01
	SELECT Id_Cli_Emp, Nombre, id_Cli_Codigo_Emp
	     , Tipo_Relacion_Con_Contraparte = Relacion_SII
		 , Gls_Tip_Rel, ORIGENINFORMACION
	INTO #relacion_2
	FROM BDDW.dbo.DJB_RUT_RELACIONADOS RR WITH (NOLOCK)
	     LEFT JOIN BDDW.dbo.DJB_TIP_REL_CNT_SII on Cod_Tip_Rel = Relacion_SII
	WHERE RR.ANNO_MES = @FechaProceso and RR.Prioridad = 1 

-- RELACIÓN_3 -->  Lo anterior se piso con los relacionados manuales
	SELECT Id_Cli_Emp, Nombre, id_Cli_Codigo_Emp
	      , Tipo_Relacion_Con_Contraparte = Relacion_SII
		  , Gls_Tip_Rel, ORIGENINFORMACION
	INTO #relacion_3
	FROM BDDW.dbo.DJB_RUT_RELACIONADOS_ESPECIFICOS RR WITH (NOLOCK)
	     LEFT JOIN BDDW.dbo.DJB_TIP_REL_CNT_SII on Cod_Tip_Rel = Relacion_SII

-- DETALLE THRESHOLD (Carga Archivo Excel)
	SELECT 'contraparte'						 =  contraparte
		 , 'rut'								 =  CASE WHEN  rut LIKE'%-%' THEN CONVERT(INT,SUBSTRING(rut, 1 , CHARINDEX('-',rut )-1)) ELSE CONVERT(INT,rut) END
		 , 'party_agreement_grace_period'		 =  CASE WHEN party_agreement_grace_period like'%H%' THEN CONVERT(INT,(SUBSTRING(party_agreement_grace_period,1 ,  CHARINDEX('H', party_agreement_grace_period)- 1)))/24  ELSE 0 END
	     , 'party_agreement_threshold'		     =  CASE WHEN ISNUMERIC(CONVERT(NUMERIC(18,0),party_agreement_threshold)) = 1 THEN party_agreement_threshold ELSE '0' END 		 --Monto_Linea_Threshold		 
		 , 'party_agreement_haircut'			 =  REPLACE(party_agreement_haircut, '%', '')	 -- 0		 
		 , 'party_agreement_min_transfer_amount' =  party_agreement_min_transfer_amount	 
		 , 'party_agreement_currency_id'		 =  party_agreement_currency_id
		 , 'party_agreement_collateral_value'	 =  CASE WHEN ISNUMERIC(party_agreement_collateral_value)	= 1 THEN  party_agreement_collateral_value  ELSE 0 END  -- cartera Garantiaas --ISNULL(cg.ValorTotalGarantiaCLP,0) -- 
	INTO #tmpDetalleThreshold
	FROM FUSION_DetalleThreshold th  WITH (NOLOCK) 
	WHERE contraparte IS NOT NULL

	

------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------
    -- Elimina todos los registros al general archivo
	DELETE FUSION_ClientesFindur

	-- select * from FUSION_ClientesFindur 
	--Ingresa los nuevos registros
	INSERT INTO FUSION_ClientesFindur (rutCliente, dvCliente,Apoderado1,Apoderado2,  apoderado3, apoderado4 , bancoReferencia, centroCosto, clasificacionRiesgoCredito, codigoBCCH, codigoRelacionado, codigoSBIF, condicionesGenerales, correosConfirmaciones, ejecutivo, jefeEjecutivo, mercado, modalidadContratacion, nombreSINACOFI, opeRentaFija, opeSpotDerivados, operaComDer, organización, relacionContraparte, taxIdDJ1820, usPerson, codigoDCV, compBilateral , codMetodologia , codigoClienteCorpbanca, nombreCliente, tipoCliente)
	SELECT  'rutCliente'		           =  c.Clrut -- CASE WHEN c.Clrut  = 76762250 THEN 77777777  ELSE (CASE WHEN c.Clrut = 77648350 THEN 88888888 ELSE  c.Clrut END) END  -- c.Clrut  
		  , 'dvCliente'		               =  c.Cldv  -- CASE WHEN c.Clrut  = 76762250 THEN '7'        ELSE (CASE WHEN c.Clrut = 77648350 THEN '8' ELSE  c.Cldv END) END --c.Cldv 
		  
		  , 'Apoderado1'			       = ISNULL(ap_1.rutApoderado,'')
		  , 'Apoderado2'			       = ISNULL(ap_2.rutApoderado,'')
		  , 'apoderado3'				   = ISNULL(ap_3.rutApoderado,'')
		  , 'apoderado4'				   = ISNULL(ap_4.rutApoderado,'')

		  , 'bancoReferencia'			   = 'NO'
		  , 'centroCosto'				   = ''
		  , 'clasificacionRiesgoCredito'   = ISNULL(CONVERT(VARCHAR(30),rCred.tbcodigo1),'') --** Tabla ITAU (K)
		  , 'codigoBCCH'				   = CONVERT(VARCHAR(10),c.clcodban)
		  , 'codigoRelacionado'		       = 0
		  , 'codigoSBIF'				   =  c.Cod_Inst    
		  , 'condicionesGenerales'         = c.clCondicionesGenerales  -- Archivo CondicionesGen ID x rut (estado) *******
		  , 'correosConfirmaciones'	       = ISNULL(c.EMAIL,'')
		  , 'ejecutivo'				       = ''
		  , 'jefeEjecutivo'			       = ''
		  , 'mercado'					   =  CASE WHEN intf.tbcodigo1 = 1
													THEN 1
													ELSE (CASE WHEN intf.tbcodigo1 >= 7 AND intf.tbcodigo1 <= 12 THEN '' ELSE 2 END) END

		  , 'modalidadContratacion'	       = CASE WHEN c.Clpais  = 6 THEN 6 ELSE 4 END		
          , 'nombreSINACOFI'			   = ISNULL(sinac.clcodigo,0) --ISNULL(sinac.nombredata,'')

		  , 'opeRentaFija'			       = 'YES'
		  , 'opeSpotDerivados'		       = 'YES'
		  , 'operaComDer'				   = CASE WHEN c.ComDer = 'S' THEN 'YES' ELSE 'NO' END

		  , 'organización'			       = 0   --** Tabla ITAU (L)
		  , 'relacionContraparte'		   =  CASE WHEN relCli_3.Tipo_Relacion_Con_Contraparte IS NOT NULL
												   THEN relCli_3.Tipo_Relacion_Con_Contraparte 
												    ELSE (CASE WHEN relCli_2.Tipo_Relacion_Con_Contraparte IS NOT NULL 
															   THEN relCli_2.Tipo_Relacion_Con_Contraparte 
															    ELSE (CASE WHEN  relCli.Tipo_Relacion_Con_Contraparte IS NOT NULL
																		   THEN relCli.Tipo_Relacion_Con_Contraparte 
																		   ELSE 99 END)
																	END) 
													END  
		 
		  , 'taxIdDJ1820'				   = ISNULL(djb.TAXID_CLI,'')
		  , 'usPerson'				       = 'NO'
		  , 'codigoDCV'				       = ''
		  , 'compBilateral'				   = CASE WHEN c.ClCompBilateral = 'N' THEN 0 ELSE 1 END 
		  , 'codMetodologia'			   = c.ClRecMtdCod

		  , 'codigoClienteCorpbanca'	   = c.Clcodigo 
		  , 'nombreCliente'                = RTRIM(c.Clnombre)
		  , 'tipoCliente'				   = tipoCliente

		  --, 'idAltamira'			       = 0
		  --, 'institucionFinanciera'        = ISNULL(intf.tbcodigo1,'0') --** Tabla ITAU (G)
		  --, 'calidadJuridica'			   = ISNULL(cjur.tbcodigo1,'0')
		  --, 'actividadEconomica'	       = actEcon.tbcodigo1    --** Tabla ITAU (I)

		  --, 'segmento'			        = ISNULL(seg.SgmCod,'0')    
		  --, 'codigoAS400'				   = 0
		  --, 'secuencia'				   = CAST(c.secuencia AS INT)
		  --, 'cnpj'					   = 0
		  --, 'clienteNoOFAC'			   = ''
		  --, 'fechaOFAC'				   = ''
		  --, 'KYC'						   = ''
		  --, 'codigoSucursal'		       = 0 

		  --, 'direccionCliente'             = c.Cldirecc
		  --, 'comuna'					   = ISNULL(c.codigo_comuna,0)
		  --, 'telefono'					   = c.ClFono
		  --, 'bloqueado'                    = c.Bloqueado
		  --, 'motBloqueado'				   = RTRIM(c.motivo_bloqueo)
		  --, 'vigente'					   = c.ClVigente
		  --, 'derivados'					   = c.derivados
		  --, 'fechaFirmaDerivados'          = c.fechaFirmaDerivados
		  --, 'pactos'					   = c.pactos
		  --, 'fechaFirmaPactos'             = ISNULL(c.fechaFirmaPactos, '1900-01-01')		 
	 FROM  #tmpCliente AS c  WITH (NOLOCK) LEFT OUTER JOIN
		   #tmpInstitucionFinanciera AS intf    WITH (NOLOCK) ON CONVERT(varchar(10), c.Cltipcli) = intf.tbcodigo1 LEFT OUTER JOIN
		   #tmpCalidadJuridica       AS cjur    WITH (NOLOCK) ON  c.Clcalidadjuridica = cjur.tbcodigo1 LEFT OUTER JOIN
		   #tmpActEconomica			 AS actEcon WITH (NOLOCK) ON c.Clactivida = actEcon.tbcodigo1 LEFT OUTER JOIN
		   #tmpRiesgoCred			 AS rCred   WITH (NOLOCK) ON c.Clclsbif = rCred.tbcodigo1 LEFT OUTER JOIN
		   #tmpSegmento				 As seg     WITH (NOLOCK) ON c.seg_comercial = seg.SgmCod LEFT OUTER JOIN
           (SELECT aprutcli ,apnombre, rutApoderado
		    FROM #tmpApoderados
			WHERE Id = 1)  AS ap_1  ON c.Clrut = ap_1.aprutcli  LEFT OUTER JOIN 
		   (SELECT aprutcli ,apnombre, rutApoderado  
		    FROM #tmpApoderados
			WHERE Id = 2)  AS ap_2  ON c.Clrut = ap_2.aprutcli   LEFT OUTER JOIN 
			BacParamSuda.dbo.SINACOFI AS sinac  WITH (NOLOCK) ON c.Clrut = sinac.clrut AND c.Clcodigo = sinac.clcodigo  LEFT OUTER JOIN 
		   (SELECT aprutcli ,apnombre, rutApoderado  
		    FROM #tmpApoderados
			WHERE Id = 3)  AS ap_3  ON c.Clrut = ap_3.aprutcli   LEFT OUTER JOIN 
		   (SELECT aprutcli ,apnombre, rutApoderado  
		    FROM #tmpApoderados
			WHERE Id = 4)  AS ap_4      ON c.Clrut = ap_4.aprutcli  LEFT OUTER JOIN 
			#relacion_1    AS relCli    ON  c.Clrut =  relCli.ID_CLI_EMP LEFT OUTER JOIN 
			#relacion_2    AS relCli_2  ON  c.Clrut =  relCli_2.ID_CLI_EMP LEFT OUTER JOIN 
			#relacion_3  AS relCli_3    ON  c.Clrut =  relCli_3.ID_CLI_EMP LEFT OUTER JOIN 
		    BDDW.dbo.DJB_TA_GNL_CLI_TAXID djb  WITH (NOLOCK) ON  djb.ID_CLI_EMP = c.Clrut  LEFT OUTER JOIN 
		    #tmpDetalleThreshold AS dt   WITH (NOLOCK) ON  c.Clrut  = dt.rut


END


GO
