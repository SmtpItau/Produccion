USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[FUSION_SP_Obtiene_ContratoCondicionesGenerales]    Script Date: 13-05-2022 10:53:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[FUSION_SP_Obtiene_ContratoCondicionesGenerales]
AS
BEGIN

/*----------------------------------------------------------------------
AUTOR          : Sandra Vásquez
DESCRIPCION    : Migracion a SQL 2008
CAMBIOS        : Se filtra por valores sin información relevante (fechaEmitido-fechaRecibido-fechaCustodia)
				 si son los tres datos 19000101
				 Se cambia (,) por (.) al generar archivo .csv (Correo: miércoles 03-02-2016 14:28)
----------------------------------------------------------------------*/



	SELECT 'contraparte'						 =  contraparte
		 , 'rut'								 =  CASE WHEN  rut LIKE'%-%' THEN CONVERT(INT,SUBSTRING(rut, 1 , CHARINDEX('-',rut )-1)) ELSE CONVERT(INT,rut) END
		 , 'party_agreement_grace_period'		 =  CASE WHEN party_agreement_grace_period like'%H%' THEN CONVERT(INT,(SUBSTRING(party_agreement_grace_period,1 ,  CHARINDEX('H', party_agreement_grace_period)- 1)))/24  ELSE 0 END
		 , 'party_agreement_threshold'			 =  Monto_Linea_Threshold-- party_agreement_threshold 
		 , 'party_agreement_haircut'			 =  0 --party_agreement_haircut 
		 , 'party_agreement_min_transfer_amount' =  0 --party_agreement_min_transfer_amount 
		 , 'party_agreement_currency_id'		 =  party_agreement_currency_id 
		 , 'party_agreement_collateral_value'	 =  ISNULL(cg.ValorTotalGarantiaCLP,0) -- party_agreement_collateral_value  -- cartera Garantiaas
	INTO #tmpDetalleThreshold
	FROM FUSION_DetalleThreshold th  WITH (NOLOCK) LEFT OUTER JOIN BacLineas..LINEA_GENERAL lin  WITH (NOLOCK) ON CASE WHEN  rut LIKE'%-%' THEN  CONVERT(INT,SUBSTRING(rut, 1 , CHARINDEX('-',rut )-1)) ELSE CONVERT(INT,rut) END = lin.Rut_Cliente
	LEFT OUTER JOIN BDBOMESA.Garantia.TBL_CarteraGarantia cg  WITH (NOLOCK) ON CASE WHEN  rut LIKE'%-%' THEN  CONVERT(INT,SUBSTRING(rut, 1 , CHARINDEX('-',rut )-1)) ELSE CONVERT(INT,rut) END  = cg.RutCliente
	WHERE contraparte IS NOT NULL
	AND rut IN('97036000'
			 , '97053000'
			 , '99500410'
			 , '97952000'
			 , '97006000'
			 , '97947000'
			 , '76362099'
			 , '99279000'
			 , '96579280'
			 , '99512160'
			 , '96812960'
			 , '96656410'
			 , '99301000'
			 , '76418751'
			 , '80537000') --> Filtro con Rut marcardo en documeto DetalleThreshold


	SELECT  'partyAgreementName'					= ''  -- Falta Definir
		  , 'extPartyRut'							= ISNULL(extPartyRut,0)  -- Rut
		  , 'extPartyDv'							= extPartyDv   -- dv Rut
		  , 'estadoPartyAgreement'					= ISNULL(estadoPartyAgreement,0)
		  , 'estadoPartyAgreementInfo'				= ISNULL(estadoPartyAgreementInfo,0)
		  , 'excepcion'								= excepcion
		  , 'fechaEmitido'							= CASE WHEN CONVERT(CHAR(8),fechaEmitido,112)  = '19000101' THEN '0' ELSE CONVERT(CHAR(8),fechaEmitido,112)  END
		  , 'fechaRecibido'							= CASE WHEN CONVERT(CHAR(8),fechaRecibido,112) = '19000101' THEN '0' ELSE CONVERT(CHAR(8),fechaRecibido,112) END
		  , 'fechaCustodia'							= CASE WHEN CONVERT(CHAR(8),fechaCustodia,112) = '19000101' THEN '0' ELSE CONVERT(CHAR(8),fechaCustodia,112)	END
		  , 'party_agreement_grace_period'          = ISNULL(dt.party_agreement_grace_period,0)   -- int     --  Días de gracia asociado al contrato de la contraparte (Calculo Mitigación)
		  , 'party_agreement_threshold'             = REPLACE( CONVERT(VARCHAR(20), ISNULL(dt.party_agreement_threshold,0)),',','.')   -- double  --  Monto threshold asociado al contrato de la contraparte.
		  , 'party_agreement_haircut'               = ISNULL(dt.party_agreement_haircut,0)  -- double  --  Porcentaje de haircut asociado al contrato de la contraparte
		  , 'party_agreement_min_transfer_amount'   = ISNULL(dt.party_agreement_min_transfer_amount,0)   -- double  --  Monto mínimo a transferir asociado al contrato de la contraparte
		  , 'party_agreement_currency_id'           = ISNULL(dt.party_agreement_currency_id,'')  -- int     --  Código de moneda asociado al contrato.
		  , 'party_agreement_collateral_value'      = REPLACE( CONVERT(VARCHAR(20), ISNULL(dt.party_agreement_collateral_value,0)),',','.')  -- double  --  Monto Garantías de la contraparte.
	FROM FUSION_Contrato_CondicionesGenerales_migracionClientes ccm WITH (NOLOCK) LEFT OUTER JOIN #tmpDetalleThreshold dt
	ON ccm.extPartyRut =  dt.rut
	WHERE     ( CONVERT(CHAR(8), fechaEmitido,112)    > '19000101'
			   OR CONVERT(CHAR(8),fechaRecibido,112) > '19000101'
			   OR CONVERT(CHAR(8),fechaCustodia,112) > '19000101' )
	GROUP BY   partyAgreementName
			 , extPartyRut
			 , extPartyDv 
			 , estadoPartyAgreement
			 , estadoPartyAgreementInfo
			 , excepcion
			 , fechaEmitido
			 , fechaRecibido
			 , fechaCustodia
			 , dt.party_agreement_grace_period 
			 , dt.party_agreement_threshold         
			 , dt.party_agreement_haircut          
			 , dt.party_agreement_min_transfer_amount
			 , dt.party_agreement_currency_id
			 , dt.party_agreement_collateral_value

END
GO
