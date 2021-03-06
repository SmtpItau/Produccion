USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[FUSION_SP_ObtieneClientesparFindur]    Script Date: 13-05-2022 10:53:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[FUSION_SP_ObtieneClientesparFindur]
AS
BEGIN


 SELECT            cf.rutCliente
				 , cf.dvCliente
				 , Apoderado1
				 , Apoderado2
				 , apoderado3
				 , apoderado4
				 , bancoReferencia
			     , centroCosto
				 , clasificacionRiesgoCredito
				 , codigoBCCH
				 , codigoRelacionado  --***
				 , codigoSBIF   --***
				 , 'condicionesGenerales' = ISNULL(ccg.estadoPartyAgreementInfo,0)
				 , correosConfirmaciones
				 , ejecutivo
				 , jefeEjecutivo
				 , mercado
				 , modalidadContratacion
				 , nombreSINACOFI     --***
				 , opeRentaFija
				 , opeSpotDerivados
				 , operaComDer
				 , organización
				 , relacionContraparte
				 , taxIdDJ1820 
				 , usPerson
				 , codigoDCV
				 , compBilateral
				 , codMetodologia
				 , codigoClienteCorpbanca
				 , nombreCliente
				 , tipoCliente
/*
				 , idAltamira
				 , institucionFinanciera
				 , calidadJuridica
				 , 'actividadEconomica' = ISNULL(actividadEconomica,0)
				 , segmento
				 , codigoAS400
				 , secuencia
				 , cnpj
				 , clienteNoOFAC
				 , fechaOFAC
				 , KYC
				 , codigoSucursal
				 , direccionCliente
				 , comuna
				 , telefono
				 , bloqueado
				 , motBloqueado
				 , vigente
				 , derivados
				 , fechaFirmaDerivados
				 , pactos
				 , fechaFirmaPactos
*/
	 FROM        dbo.FUSION_ClientesFindur AS cf WITH (nolock) LEFT JOIN
                 dbo.FUSION_Contrato_CondicionesGenerales_migracionClientes AS ccg WITH (nolock)  ON cf.rutCliente = ccg.extPartyRut AND cf.dvCliente = ccg.extPartyDv 
				 AND  cf.codigoClienteCorpbanca = ccg.codigo_cliente
	
END

GO
